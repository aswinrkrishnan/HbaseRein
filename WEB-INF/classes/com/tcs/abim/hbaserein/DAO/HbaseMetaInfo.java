package com.tcs.abim.hbaserein.DAO;

import java.io.IOException;
import java.util.ArrayList;

import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.client.HBaseAdmin;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.HTableInterface;
import org.apache.hadoop.hbase.util.Pair;

import com.tcs.abim.hbaserein.beans.TableVO;
import com.tcs.abim.hbaserein.util.ApplicationUtil;

public class HbaseMetaInfo {
	public static TableVO getTableDetails(String tableName) throws IOException {

		HBaseAdmin admin = new HBaseAdmin(ApplicationUtil.configuration);

		HTableDescriptor tableDiscriptor = new HTableDescriptor(tableName);

		tableDiscriptor = admin.getTableDescriptor(tableName.getBytes());


		HColumnDescriptor[] colFamList = tableDiscriptor.getColumnFamilies();
		ArrayList<String> startKeyStrings = new ArrayList<String>();
		ArrayList<String> endKeyStrings = new ArrayList<String>();

		
		
		HTable table = new HTable(ApplicationUtil.configuration, tableName);
		Pair<byte[][], byte[][]> startEndKeys = table.getStartEndKeys();

		for (int i = 0; i < startEndKeys.getFirst().length; i++) {

			startKeyStrings.add(new String(startEndKeys.getFirst()[i]));
			endKeyStrings.add(new String(startEndKeys.getSecond()[i]));
		}

		TableVO tvo = new TableVO();
		tvo.setColFamList(colFamList);
		tvo.setStartKeyStrings(startKeyStrings);
		tvo.setEndKeyStrings(endKeyStrings);
		table.close();
		return tvo;

	}
}
