#Glossary and Acronyms

IoC - Inversion of Control, synonymous with Dependency Injection

DI - Dependency Injection, the Spring the process where objects define their dependencies only through constructor arguments, arguments to a factory method, or properties that are set on the object instance after it is constructed or returned from a factory. These dependencies are inject into the bean when it is created. This is know as Inversion of Control because it is fundamentally the opposite of traditional control, where the bean itself controls the instantiation of its dependencies. 

Bean - Can mean either the Jave Enterprise standard for a Java bean, which is a class that implements the serializable interface, has a zero-argument constructor, and allows access to it's private member variables using getters and setting. In the context of Spring, beans are " the objects that form the backbone of your application and that are managed by the Spring IoC container are called beans. A bean is an object that is instantiated, assembled, and otherwise managed by a Spring IoC container." (From [Spring Documentation](http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#beans)

