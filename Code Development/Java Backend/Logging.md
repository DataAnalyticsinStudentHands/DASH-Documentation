# Logging Notes

This [page](http://gordondickens.com/wordpress/2013/03/27/sawing-through-the-java-loggers/) describes the frameworks we use for logging(SLF4j and Logback). Another tutorial can be found [here](http://www.codingpedia.org/ama/how-to-log-in-spring-with-slf4j-and-logback/). A quick summary:

* Don't use `System.out.`!

1. All of our logging code should use the same SLF4j API. For example:

	import org.slf4j.Logger;
	import org.slf4j.LoggerFactory;
	public class MyClass {
	  private static final Logger logger = LoggerFactory.getLogger(MyClass.class);

	
	  public void someMethod() {
	    logger.debug("something is happening");
	  }
	
	}


2. Make sure you have the dependencies defined in the pom.xml (Maven)

```
<properties>
  <slf4j.version>1.7.5</slf4j.version>
  <logback.version>1.0.11</logback.version>
</properties>

<dependencies>
  <!-- SLF4J - logging api -->
  <dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-api</artifactId>
    <version>${slf4j.version}</version>
  </dependency>

  <!-- Logback - logging impl -->
  <dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>${logback.version}</version>
  </dependency>
</dependencies>

```
3. Configure logging via Logback
