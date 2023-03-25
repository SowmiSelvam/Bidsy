package main.java.com.BidsyJava;

import java.io.FileReader;
import java.util.Properties;

public class ReadPropertyFile {
	
	public static Properties readPropertyFile() {
		try {
			FileReader reader=new FileReader("/Property Files/Bidsy.properties");  

			Properties p=new Properties();  
			p.load(reader);
			return p;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;

	}
}
