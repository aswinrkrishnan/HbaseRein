package com.tcs.abim.hbaserein.util;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HTable;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.util.Bytes;

public class TableCreate {
	
	public static void main(String[] args) throws IOException {

		Put hbasePut;
		final Configuration conf = HBaseConfiguration.create();
		final HTable hTable = new HTable(conf, "EmailTable");
		hbasePut = new Put(Bytes.toBytes("Email|333142"));
		
		hbasePut.add(
				Bytes.toBytes("C"),
				Bytes.toBytes("Email|1364207277000|"+System.currentTimeMillis()),
	//			Bytes.toBytes("Email|1364207277000|1364207277000"),
				Bytes.toBytes("Bad Response!%@$-----ann tomie <666ann@gmail.com> <666ann@gmail.com> wrote: ----->> To: Test25.User25@tcs.com> From: ann tomie <666ann@gmail.com> <666ann@gmail.com>> Date: 03/21/2013 10:56AM> Subject: :)>>> Hi ,>> I just wanna say I love your Company! You have one of the best automated> systems out there! I've been with you since 04 and I can't tell you how> much you've helped me! You deserve a metal! But I hate technology changing> so fast, that anything we buy, isn't worth squat, 6 months later! Not good> at all!> --> @nn>> =====-----=====-----=====> Notice: The information contained in this e-mail> message and/or attachments to it may contain> confidential or privileged information. If you are> not the intended recipient, any dissemination, use,> review, distribution, printing or copying of the> information contained in this e-mail message> and/or attachments to it are strictly prohibited. If> you have received this communication in error,> please notify us by reply e-mail or telephone and> immediately and permanently delete the message> and any attachments. Thank you>>-- @nn--e89a8ff1c6d668640704d8bd3f1fContent-Transfer-Encoding: quoted-printable"));
		hTable.put(hbasePut);
	}

}
