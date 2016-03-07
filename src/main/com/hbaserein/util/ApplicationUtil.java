package com.aswinrkrishnan.hbaserein.util;

import java.io.IOException;
import java.util.Properties;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.HTablePool;

public class ApplicationUtil {

	public static HTablePool hTablePool;

	public static Configuration configuration;

	public static void init() {
		configuration = HBaseConfiguration.create();
		Properties configProp = new Properties();
		try {
			configProp.load(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream("clusterConf.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		String quorum = configProp.getProperty("quorum");
		String qPort = configProp.getProperty("qport");

		configuration.set("hbase.zookeeper.quorum", quorum);
		configuration.set("hbase.zookeeper.property.clientPort", qPort);
		hTablePool = new HTablePool(configuration, 10);
	}
}
