package com.danidemi;

import static org.mockito.Mockito.mock;

import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;
import org.junit.Test;
public class WordCountMapTest {

	@Test
	public void testMap() throws IOException {
		
		LongWritable key = new LongWritable(100);
		Text value = new Text("home sweet home");
		OutputCollector<Text, IntWritable> output = new FakeOutputCollector();
		Reporter reporter = mock(Reporter.class);
		
		WordCountMap wordCountMap = new WordCountMap();
		wordCountMap.map(key, value, output, reporter);
		
	}

}
