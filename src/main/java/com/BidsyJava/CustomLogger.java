package main.java.com.BidsyJava;

import java.io.IOException;
import java.util.Properties;
import java.util.logging.*;

public class CustomLogger {

	private static final Logger logger = Logger.getLogger("CustomLogger");

	static {
		logger.setUseParentHandlers(false);
		ReadPropertyFile rd = new ReadPropertyFile();
		Properties prop = rd.readPropertyFile();

		ConsoleHandler consoleHandler = new ConsoleHandler();
		consoleHandler.setFormatter(new SimpleFormatter());
		consoleHandler.setLevel(Level.INFO);

		FileHandler fileHandler;
		try {
			String path = prop.getProperty("LoggerPath");
			fileHandler = new FileHandler(path);
			fileHandler.setFormatter(new SimpleFormatter());
			fileHandler.setLevel(Level.ALL);

			logger.addHandler(fileHandler);
		} catch (IOException e) {
			e.printStackTrace();
		}

		logger.addHandler(consoleHandler);
		logger.setLevel(Level.ALL);
	}

	public static void log(String message) {
		logger.log(Level.INFO, message);
	}

}
