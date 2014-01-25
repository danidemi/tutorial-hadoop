package com.danidemi;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mrunit.MapDriver;
import org.apache.hadoop.mrunit.MapReduceDriver;
import org.apache.hadoop.mrunit.ReduceDriver;
import org.junit.Test;

public class MRTest {
	MapDriver<LongWritable, Text, Text, IntWritable> mapDriver;
	ReduceDriver<Text, IntWritable, Text, IntWritable> reduceDriver;
	MapReduceDriver<LongWritable, Text, Text, IntWritable, Text, IntWritable> mapReduceDriver;
		
	@Test
	public void test() throws IOException {
		new MapDriver<LongWritable, Text, Text, IntWritable>()
			.withMapper(new WordCountMap())
			.withInput(new LongWritable(4),new Text("Hello World"))
			.withOutput(new Text("Hello"),new IntWritable(1))
			.withOutput(new Text("World"),new IntWritable(1))
			.runTest();

	}

}
