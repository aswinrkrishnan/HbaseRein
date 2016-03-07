package com.aswinrkrishnan.hbaserein.beans;

public class QualifierValueVO {

	String colFamily;

	String qualifier;

	String value;

	public QualifierValueVO(String colFamily, String qualifier, String value) {
		super();
		this.colFamily = colFamily;
		this.qualifier = qualifier;
		this.value = value;
	}

	public String getQualifier() {
		return qualifier;
	}

	public void setQualifier(String qualifier) {
		this.qualifier = qualifier;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getColFamily() {
		return colFamily;
	}

	public void setColFamily(String colFamily) {
		this.colFamily = colFamily;
	}

}
