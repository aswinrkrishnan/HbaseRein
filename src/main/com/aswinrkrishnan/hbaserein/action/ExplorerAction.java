package com.aswinrkrishnan.hbaserein.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import com.opensymphony.xwork2.ActionSupport;
import com.aswinrkrishnan.hbaserein.DAO.HbaseMetaInfo;
import com.aswinrkrishnan.hbaserein.DAO.HbaseTableOP;
import com.aswinrkrishnan.hbaserein.beans.QualifierValueVO;
import com.aswinrkrishnan.hbaserein.beans.TableVO;

public class ExplorerAction extends ActionSupport {

	/**
	 *
	 */

	ArrayList<String> tables;
	ArrayList<String> colFamilyList;

	String selectedTable;

	TableVO tableVO;

	String rowKey;
	String columnFamily;
	String columnQualifier;
	String columnValue;

	String rowKeyCondn;
	String columnQualifierCondn;
	String columnValueCondn;

	LinkedHashMap<String, Map<String, QualifierValueVO>> tableHashMap;

	public String login() {
		tables = HbaseTableOP.listTables();
		return SUCCESS;
	}

	public String fetchTableData() {
		tableHashMap = HbaseTableOP.fetchTableData(selectedTable);
		return SUCCESS;
	}

	public String fetchTableMetaInfo() {
		try {
			tableVO = HbaseMetaInfo.getTableDetails(selectedTable);
		} catch (IOException e) {
			return ERROR;
		}
		return SUCCESS;
	}

	public String fetchColumnFamily() {
		try {
			colFamilyList = HbaseMetaInfo.getTableDetails(selectedTable)
					.getColFamNames();
		} catch (IOException e) {
			return ERROR;
		}
		return SUCCESS;
	}

	public String insertRow() {
		try {
			HbaseTableOP.insertIntoTable(selectedTable, rowKey, columnFamily,
					columnQualifier, columnValue);
		} catch (IOException e) {
			return ERROR;
		}
		return SUCCESS;
	}

	public String deleteRow() {
		try {
			HbaseTableOP.deletefromTable(selectedTable, rowKey, columnFamily, columnQualifier);
		} catch (IOException e) {
			return ERROR;
		}
		return SUCCESS;
	}

	public String searchTable() {
		tableHashMap = HbaseTableOP.tableSearch(selectedTable, rowKey,
				rowKeyCondn, columnQualifier, columnQualifierCondn,
				columnValue, columnValueCondn);

		return SUCCESS;
	}

	public ArrayList<String> getTables() {
		return tables;
	}

	public void setTables(ArrayList<String> tables) {
		this.tables = tables;
	}

	public String getSelectedTable() {
		return selectedTable;
	}

	public void setSelectedTable(String selectedTable) {
		this.selectedTable = selectedTable;
	}



	public LinkedHashMap<String, Map<String, QualifierValueVO>> getTableHashMap() {
		return tableHashMap;
	}

	public void setTableHashMap(
			LinkedHashMap<String, Map<String, QualifierValueVO>> tableHashMap) {
		this.tableHashMap = tableHashMap;
	}

	public TableVO getTableVO() {
		return tableVO;
	}

	public void setTableVO(TableVO tableVO) {
		this.tableVO = tableVO;
	}

	public ArrayList<String> getColFamilyList() {
		return colFamilyList;
	}

	public void setColFamilyList(ArrayList<String> colFamilyList) {
		this.colFamilyList = colFamilyList;
	}

	public String getRowKey() {
		return rowKey;
	}

	public void setRowKey(String rowKey) {
		this.rowKey = rowKey;
	}

	public String getColumnFamily() {
		return columnFamily;
	}

	public void setColumnFamily(String columnFamily) {
		this.columnFamily = columnFamily;
	}

	public String getColumnQualifier() {
		return columnQualifier;
	}

	public void setColumnQualifier(String columnQualifier) {
		this.columnQualifier = columnQualifier;
	}

	public String getColumnValue() {
		return columnValue;
	}

	public void setColumnValue(String columnValue) {
		this.columnValue = columnValue;
	}

	public String getRowKeyCondn() {
		return rowKeyCondn;
	}

	public void setRowKeyCondn(String rowKeyCondn) {
		this.rowKeyCondn = rowKeyCondn;
	}

	public String getColumnQualifierCondn() {
		return columnQualifierCondn;
	}

	public void setColumnQualifierCondn(String columnQualifierCondn) {
		this.columnQualifierCondn = columnQualifierCondn;
	}

	public String getColumnValueCondn() {
		return columnValueCondn;
	}

	public void setColumnValueCondn(String columnValueCondn) {
		this.columnValueCondn = columnValueCondn;
	}

}
