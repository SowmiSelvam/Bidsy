package main.java.com.BidsyJava;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.util.Properties;

public class ReadPropertyFile {
	
	public Properties readPropertyFile() {
		try {
			
			BufferedReader reader = new BufferedReader(new InputStreamReader(
				    this.getClass().getResourceAsStream("/main/java/com/BidsyJava/Resources/Bidsy.properties")));
			 

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
