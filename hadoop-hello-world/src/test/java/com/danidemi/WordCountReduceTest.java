package com.danidemi;

import static org.junit.Assert.*;
import static org.mockito.Mockito.mock;

import java.io.IOException;
import java.util.Arrays;
import java.util.Iterator;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;
import org.junit.Test;

public class WordCountReduceTest {

	@Test
	public void testReduce() throws IOException {
		
		Text key = new Text( "one" );
		Iterator<IntWritable> values = Arrays.asList( new IntWritable(21), new IntWritable(10), new IntWritable(3) ).iterator();
		OutputCollector<Text, IntWritable> output = new FakeOutputCollector();
		Reporter reporter = mock(Reporter.class);
		WordCountReduce wordCountReduce = new WordCountReduce();
		wordCountReduce.reduce(key, values, output, reporter);
		
	}

}
