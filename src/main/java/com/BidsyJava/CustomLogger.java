package main.java.com.BidsyJava;

import java.io.IOException;
import java.util.Properties;
import java.util.logging.*;

public class CustomLogger {

	private static final Logger logger = Logger.getLogger("CustomLogger");

	static ReadPropertyFile rd = new ReadPropertyFile();
	static Properties prop = rd.readPropertyFile();
	static String enableLogging = prop.getProperty("EnableLogging");
	
	static {
		try {
			logger.setUseParentHandlers(false);
			ConsoleHandler consoleHandler = new ConsoleHandler();
			consoleHandler.setFormatter(new SimpleFormatter());
			consoleHandler.setLevel(Level.INFO);

			FileHandler fileHandler;

			if(enableLogging.equalsIgnoreCase("1")) {
				String path = prop.getProperty("LoggerPath");
				fileHandler = new FileHandler(path);
				fileHandler.setFormatter(new SimpleFormatter());
				fileHandler.setLevel(Level.ALL);

				logger.addHandler(fileHandler);
				logger.addHandler(consoleHandler);
				logger.setLevel(Level.ALL);
			}
		}
		catch (IOException e) {
			e.printStackTrace();
		}

	}

	public static void log(String message) {
		
		if(enableLogging.equalsIgnoreCase("1")) {
			logger.log(Level.INFO, message);
		}
	}

}
