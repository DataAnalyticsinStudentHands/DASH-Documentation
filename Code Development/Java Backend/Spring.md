#Spring Framework and Security

All of our java backends are built using the Spring Framework. Spring provides a structure for dependency injection, consistent programming model for different transaction APIs such as Hibernate, JTA, JDBC, JPA, and JDO. Spring also provides compatibility for logging with SLFJ and Log4J, as well as other popular Java Enterprise API's such as Quartz. Spring provides it's own MVC design, and can provide integration for other MVC Designs as well

#Dependencies Explained

The most appeal aspect of Spring is it's powerful Dependency Injection (DI), also referred to as Inversion of Control(IoC). When creating an application, you will often end up with a situation similar to below

	public class ClassA{
	//regular class structure
	}

	public class ClassB{
	private ClassA classA;
	//rest of the class
	}

In this instance, Class A is a dependency of Class B. Class B *depends* on class A, which means that changes to Class A influence Class B. This seems trivial in this example, but real use cases see much more complex relationships than this. 