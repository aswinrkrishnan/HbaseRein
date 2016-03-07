package com.aswinrkrishnan.hbaserein.beans;

import java.util.ArrayList;

import org.apache.hadoop.hbase.HColumnDescriptor;


public class TableVO {

	 private HColumnDescriptor[] colFamList;
	 private ArrayList<String> startKeyStrings;// = new ArrayList<String>();
	 private ArrayList<String> endKeyStrings;// = new ArrayList<String>();
	 private ArrayList<String> colFamNames;

	 public HColumnDescriptor[] getColFamList() {
		return colFamList;
	}
	public void setColFamList(HColumnDescriptor[] colFamList) {
		this.colFamList = colFamList;
		colFamNames=new ArrayList<String>();
		for(HColumnDescriptor colDisc: this.colFamList){
			colFamNames.add(colDisc.getNameAsString());
		}
	}

	public ArrayList<String> getColFamNames(){
		return colFamNames;
	}

	public ArrayList<String> getStartKeyStrings() {
		return startKeyStrings;
	}
	public void setStartKeyStrings(ArrayList<String> startKeyStrings) {
		this.startKeyStrings = startKeyStrings;
	}
	public ArrayList<String> getEndKeyStrings() {
		return endKeyStrings;
	}
	public void setEndKeyStrings(ArrayList<String> endKeyStrings) {
		this.endKeyStrings = endKeyStrings;
	}
	public void getWg(){
	colFamList[0].getNameAsString();
	}
}
