package main.java.com.BidsyJava;

import java.io.IOException;
import java.util.logging.*;

public class CustomLogger {
	  
	  private static final Logger logger = Logger.getLogger("CustomLogger");
	  
	  static {
	    logger.setUseParentHandlers(false);
	    
	    ConsoleHandler consoleHandler = new ConsoleHandler();
	    consoleHandler.setFormatter(new SimpleFormatter());
	    consoleHandler.setLevel(Level.INFO);
	    
	    FileHandler fileHandler;
	    try {
	      fileHandler = new FileHandler("/Users/anubhavgarikapadu/ApacheTomcat/apache-tomcat-9.0.62/CustomLogs/CustomLogs.log");
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

///Users/anubhavgarikapadu/ApacheTomcat/apache-tomcat-9.0.62/CustomLogs