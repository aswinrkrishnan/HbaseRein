package com.aswinrkrishnan.hbaserein.DAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.KeyValue;
import org.apache.hadoop.hbase.MasterNotRunningException;
import org.apache.hadoop.hbase.ZooKeeperConnectionException;
import org.apache.hadoop.hbase.client.Delete;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.HTableInterface;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.filter.BinaryComparator;
import org.apache.hadoop.hbase.filter.ColumnPaginationFilter;
import org.apache.hadoop.hbase.filter.ColumnPrefixFilter;
import org.apache.hadoop.hbase.filter.CompareFilter.CompareOp;
import org.apache.hadoop.hbase.filter.Filter;
import org.apache.hadoop.hbase.filter.FilterList;
import org.apache.hadoop.hbase.filter.FilterList.Operator;
import org.apache.hadoop.hbase.filter.PrefixFilter;
import org.apache.hadoop.hbase.filter.QualifierFilter;
import org.apache.hadoop.hbase.filter.RowFilter;
import org.apache.hadoop.hbase.filter.SubstringComparator;
import org.apache.hadoop.hbase.filter.ValueFilter;
import org.apache.hadoop.hbase.util.Bytes;

import com.aswinrkrishnan.hbaserein.beans.QualifierValueVO;
import com.aswinrkrishnan.hbaserein.util.ApplicationUtil;

public class HbaseTableOP {

	public enum Condition {
		startsWith, equals, contains
	}

	public static ArrayList<String> listTables() {

		HBaseAdmin admin;
		try {
			admin = new HBaseAdmin(ApplicationUtil.configuration);

			ArrayList<String> tableLists = new ArrayList<String>();
			HTableDescriptor[] tables = admin.listTables();

			for (HTableDescriptor htd : tables) {
				tableLists.add(htd.getNameAsString());
			}
			return tableLists;
		} catch (MasterNotRunningException e) {
			e.printStackTrace();
		} catch (ZooKeeperConnectionException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static LinkedHashMap<String, Map<String, QualifierValueVO>> fetchTableData(
			String selectedTable) {
		LinkedHashMap<String, Map<String, QualifierValueVO>> tableMap = new LinkedHashMap<String, Map<String, QualifierValueVO>>();
		Scan scan = new Scan();
		// Filter pgFilter = new ColumnPaginationFilter(10, 10);
		String rowKey;
		try {
			HTableInterface selectedHTable = ApplicationUtil.hTablePool
					.getTable(selectedTable);

			// scan.setFilter(pgFilter);

			ResultScanner selectedTableScanner = selectedHTable
					.getScanner(scan);

			for (Result selectedResult : selectedTableScanner) {
				rowKey = Bytes.toString(selectedResult.getRow());
				tableMap.put(rowKey,
						new LinkedHashMap<String, QualifierValueVO>());
				for (KeyValue kv : selectedResult.raw()) {
					tableMap.get(rowKey).put(
							Bytes.toString(kv.getQualifier()),
							new QualifierValueVO(
									Bytes.toString(kv.getFamily()), Bytes
											.toString(kv.getQualifier()), Bytes
											.toString(kv.getValue())));
				}
			}
			selectedHTable.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return tableMap;
	}

	public static void insertIntoTable(String tableName, String rowKey,
			String family, String qualifier, String value) throws IOException {

		HTableInterface table = ApplicationUtil.hTablePool.getTable(tableName);
		Put put = new Put(rowKey.getBytes());
		put.add(family.getBytes(), qualifier.getBytes(), value.getBytes());
		table.put(put);
		table.close();
	}

	public static void deletefromTable(String tableName, String rowKey,
			String family, String qualifier) throws IOException {

		HTableInterface table = ApplicationUtil.hTablePool.getTable(tableName);
		Delete delete = new Delete(rowKey.getBytes());
		delete.deleteColumns(family.getBytes(), qualifier.getBytes());
		table.delete(delete);
		table.close();
	}

	public static LinkedHashMap<String, Map<String, QualifierValueVO>> tableSearch(
			String selectedTable, String rowKey, String rowKeyCondn,
			String columnQualifier, String columnQualifierCondn,
			String columnValue, String columnValueCondn) {
		LinkedHashMap<String, Map<String, QualifierValueVO>> tableMap = new LinkedHashMap<String, Map<String, QualifierValueVO>>();
		HTableInterface table = null;
		try {
			table = ApplicationUtil.hTablePool.getTable(selectedTable);
			Scan tableScan = new Scan();
			FilterList filterList = new FilterList(Operator.MUST_PASS_ALL);
			Filter filter = null;
			if (rowKey != null && !rowKey.equals("")) {
				switch (Condition.valueOf(rowKeyCondn)) {
				case contains:
					filter = new RowFilter(CompareOp.EQUAL,
							new SubstringComparator(rowKey));
					break;
				case equals:
					filter = new RowFilter(CompareOp.EQUAL,
							new BinaryComparator(rowKey.getBytes()));
					break;
				case startsWith:
					filter = new PrefixFilter(rowKey.getBytes());
					break;
				}
				filterList.addFilter(filter);
			}



			if (columnQualifier != null && !columnQualifier.equals("")) {
				switch (Condition.valueOf(columnQualifierCondn)) {
				case contains:
					filter = new QualifierFilter(CompareOp.EQUAL,
							new SubstringComparator(columnQualifier));
					break;
				case equals:
					filter = new QualifierFilter(CompareOp.EQUAL,
							new BinaryComparator(columnQualifier.getBytes()));
					break;
				case startsWith:
					filter = new ColumnPrefixFilter(columnQualifier.getBytes());
					break;
				}
				filterList.addFilter(filter);
			}


			if (columnValue != null && !columnValue.equals("")) {
				switch (Condition.valueOf(columnValueCondn)) {
				case contains:
					filter = new ValueFilter(CompareOp.EQUAL,
							new SubstringComparator(columnValue));
					break;
				case equals:
					filter = new ValueFilter(CompareOp.EQUAL,
							new BinaryComparator(columnValue.getBytes()));
					break;
				}
				filterList.addFilter(filter);
			}

			tableScan.setFilter(filterList);

			ResultScanner selectedTableScanner = table.getScanner(tableScan);
			if (selectedTableScanner != null) {
				for (Result selectedResult : selectedTableScanner) {
					rowKey = Bytes.toString(selectedResult.getRow());
					tableMap.put(rowKey,
							new LinkedHashMap<String, QualifierValueVO>());
					for (KeyValue kv : selectedResult.raw()) {
						tableMap.get(rowKey).put(
								Bytes.toString(kv.getQualifier()),
								new QualifierValueVO(Bytes.toString(kv
										.getFamily()), Bytes.toString(kv
										.getQualifier()), Bytes.toString(kv
										.getValue())));
					}
				}
			}
			table.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return tableMap;
	}
}
