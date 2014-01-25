package com.danidemi;

import static java.lang.String.format;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.OutputCollector;

final class FakeOutputCollector implements
		OutputCollector<Text, IntWritable> {
	public void collect(Text key, IntWritable value) throws IOException {
		System.out.println( format("Collecting entry [%s] => [%s]", key, value) );
		
	}
}