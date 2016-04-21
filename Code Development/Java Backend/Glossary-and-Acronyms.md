#Glossary and Acronyms

ACL - Stands for Access Control List. This data pattern contains a list of Access Control Entries (ACEs) that define a particular, pre-defined relationship between one object and the object the ACL is attached to. For more information, see the [Access Control Lists documentation](./Access-Control-Lists-and-Filtering.md).

Bean - Can mean either the Jave Enterprise standard for a Java bean, which is a class that implements the serializable interface, has a zero-argument constructor, and allows access to it's private member variables using getters and setting. In the context of Spring, beans are " the objects that form the backbone of your application and that are managed by the Spring IoC container are called beans. A bean is an object that is instantiated, assembled, and otherwise managed by a Spring IoC container." (From [Spring Documentation](http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#beans).

DAO - Stands for Data Access Object. A DAO provides an abstract interface for accessing a database from an application. This design pattern helps achieve isolation and supports the [Single Responsibility Principal](https://en.wikipedia.org/wiki/Single_responsibility_principle), which states that "every module or class should have responsibility over a single part of the functionality provided by the software, and that responsibility should be entirely encapsulated by the class."

DI - Dependency Injection, the Spring the process where objects define their dependencies only through constructor arguments, arguments to a factory method, or properties that are set on the object instance after it is constructed or returned from a factory. These dependencies are inject into the bean when it is created. This is know as Inversion of Control because it is fundamentally the opposite of traditional control, where the bean itself controls the instantiation of its dependencies. 

EMA - Stands for [Ecological Momentary Assessment](http://link.springer.com/referenceworkentry/10.1007%2F978-1-4419-1005-9_947). This refers to "a collection of methods often used in behavioral medicine research by which a research participant repeatedly reports on symptoms, affect, behavior, and cognitions close in time to experience and in the participants’ natural environment (Stone Shiffman, 1994)." The general idea is to place the collection of data closer to the actual experience in question. Rather than going to a doctor at the end of the week where you answer a series of questions about how you felt over the course of the week, you record your answers to questions about how you feel right now. Our EMA Application provides a means of gathering data through a pre-determined form at various times.

JDBC - Java Database Connectivity. This API     

JDK - Java Development Kit. This is the full development environment for Java. It includes the JRE, as well as development tools such as JavaDoc and Java Debugger. The differences between a JRE and JDK can be found [here](http://stackoverflow.com/questions/1906445/what-is-the-difference-between-jdk-and-jre).

JPA - Java Persistence API. This generalized API provides an interface for persisting POJOs in a datasource. Hibernate implements the JPA standard, and our applications often leverage the JPA standard through Hibernate. More information on JPA can be found [here](http://www.oracle.com/technetwork/java/javaee/tech/persistence-jsp-140049.html).

JRE - Java Runtime Environment. This includes only the JVM and Applet extensions needed to run Java applications and programs. The differences between a JRE and JDK can be found [here](http://stackoverflow.com/questions/1906445/what-is-the-difference-between-jdk-and-jre).

JVM - Java Virtual Machine. This is the virtual environment that all Java applications and programs run in. Rather than compiling into some architecturally specific machine code, Java compiles into its own byte code that runs on the virtual hardware created by the virtual machine. This aides in portability of programs, since the JVM is consistent across all platforms. More information on how the JVM and Java complication process works can be found [here](http://searchsoa.techtarget.com/definition/Java-virtual-machine).

IoC - Inversion of Control, synonymous with Dependency Injection.