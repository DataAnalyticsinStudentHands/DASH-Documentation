#Spring Framework and Security

All of our java backends are built using the Spring Framework. Spring provides a structure for dependency injection, consistent programming model for different transaction APIs such as Hibernate, JTA, JDBC, JPA, and JDO. Spring also provides compatibility for logging with SLFJ and Log4J, as well as other popular Java Enterprise API's such as Quartz. Spring provides it's own MVC design, and can provide integration for other MVC Designs as well

#Dependency Injection

The most appealing aspect of Spring is it's powerful Dependency Injection (DI), also referred to as Inversion of Control(IoC). When creating an application, you will often end up with a situation similar to below

	public class ClassA{
	//regular class structure
	}

	public class ClassB{
	private ClassA classA;
	//rest of the class
	}

In this instance, Class A is a dependency of Class B. Class B *depends* on class A, which means that changes to Class A influence Class B. This seems trivial in this example, but real use cases see much more complex relationships than this. A simplified implementation of DI is given below

Without DI

	public class A {
	  private B b;

	  public A() {
	    this.b = new B(); // A *depends on* B
	  }

	  public void DoSomeStuff() {
	    // Do something with B here
	  }
	}

	public static void Main(string[] args) {
	  A a = new A();
	  a.DoSomeStuff();
	}

With DI

	public class A {
	  private B b;

	  public A(B b) { // A now takes its dependencies as arguments
	    this.b = b;
	  }
	  public void DoSomeStuff() {
	    // Do something with B here
	  }
	}
	public static void Main(string[] args) {
	  B b = new B(); // B is constructed here instead
	  A a = new A(b);
	  a.DoSomeStuff();
	}

As you can see, object B is instantiated from *outside* of object A, and "injected" into object A. This is a simple concept that gains it's benefits as the complexity of the dependencies grows. You can achieve the same results with setters as well as a constructor. With Spring, this inject is automatically handled through XML Configured beans and the **@autowired** annotation. Member variables marked with this annotation will be automatically injected by the Spring IoC Container at run time. This allows us to make changes at the bean level rather than at every usage of the bean.

#Defining Beans

In our projects, our beans are declared using XML configuration in **resources/spring/applicationContext.xml**. The most important beans are those related to the entityManagerFactory. See the **DAO-Layer** and **Hibernate** documentation for more details on how this bean is used. Below is a sample bean configuration for a entityManagerFactory.

	<bean id="entityManagerFactory"
		class="org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean">
		<property name="persistenceXmlLocation" value="classpath:config/persistence-dash.xml" />
		<property name="persistenceUnitName" value="dashPersistence" />
		<property name="dataSource" ref="dashDS" />
		<property name="packagesToScan" value="dash.*" />
		<property name="jpaVendorAdapter">
			<bean class="org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter">
				<property name="showSql" value="true" />
				<property name="databasePlatform" value="org.hibernate.dialect.MySQLDialect" />
			</bean>
		</property>
	</bean>

The **<property>** tag is used to set that particular member variable. Setting it using **value=** will set the variable to the given value, such as with the "persistenceUnitName" property in the example. Setting a property using **ref=** allows you to include another bean in the definition of the current bean. In the case of the dataSource property, it is set to the bean that is defined below.

	<bean id="dashDS" class="org.springframework.jndi.JndiObjectFactoryBean"
		scope="singleton">
		<property name="jndiName" value="java:comp/env/jdbc/dashDB" />
		<property name="resourceRef" value="true" />
	</bean>

Here is a helpful analogy about bean definitions taken from the [Spring Documentation](http://docs.spring.io/spring/docs/current/spring-framework-reference/htmlsingle/#beans-factory-class)
> A bean definition essentially is a recipe for creating one or more objects. The container looks at the recipe for a named bean when asked, and uses the configuration metadata encapsulated by that bean definition to create (or acquire) an actual object.

#Spring Security

###Roles and Permissions
The Spring framework also provides security functionality for our applications. This security is primarily controlled by the user of **Roles** and **Permissions**. In our applications, there are user objects that represent that various user accounts created in the application. These user objects are the only objects that have role in the Spring Security context. In other words, it is impossible to talk about the role of a form, or group, or question, only users. Similarly only users have **Permissions** on other objects. A form or group does not have any permissions.

#####Roles

A user's **Role** defines it's relationship to the entire application. Every user has one and only one role, and this role can be changed. **Roles** are hierarchical, with each role containing all of the roles below it. Generally, the hierarchy is defined in **resources/spring/aclConfig.xml**. An example of this definition is below

	 <bean id="roleHierarchy"  class="org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl">
	     <property name="hierarchy">
	         <value>
	         	ROLE_ROOT > ROLE_ADMIN
	             ROLE_ADMIN > ROLE_MODERATOR
	             ROLE_MODERATOR > ROLE_USER
	             ROLE_USER > ROLE_VISITOR
	         </value>
	     </property>
	 </bean>

In this case, ROLE\_ROOT contains all the lower roles. A user who has ROLE\_ADMIN also has access to everything for ROLE\_MODERATOR. This means that if access to a method is restricted by the "hasRole(ROLE_MODERATOR)" annotation, a user with ROLE\_ADMIN can also access it. Roles can be added in projects as needed.

#####Permissions
A **Permission** defines a user's relationship with a particular object. A single user can have many permissions on several different objects, as well as having many permissions on the same object. The relationship has 3 parts, the user, the permission, and the object. These three parts are recorded in ACLs as ACEs, see the Access-Control-List documentation for more information. **Permissions** are discrete and non-hierarchical. If we define 4 permissions, **Create, Read, Write, and Delete**, they are separate from each other. If userA has a **Write** permission on objectA, that does not guarantee that userA also has a **Read** permission on objectA. Because permissions are assigned discretely and separately, you must pay attention to how you assign them. In theory you could have a user with **Write** permissions on an object, but no **Read** permissions. The problem with that is that you no have a user who is allowed to write to an object, but can't actually see the object it is writing too. In this case, your method that assigns the **Read** permission should also assign the **Write** permission. However, the individual nature of permissions does allow you to create custom permissions that do not have any pre-defined relationship or hierarchy to each other. This allows you to use permissions to mark other relationships between users and objects. For example, in the VMA application and it's clones, we use permissions to mark users as members and managers of a group. This can be done by adding the permission to the `CustomPermission` class with it's associated mask. Permissions are stored in the database as bitwise masks. For example, the `BasePermission` class defines WRITE as `(1 << 1, 'W')`, meaning the integer 1 is bit shifted left once to create the integer 2. This is what is actually stored in the ACL tables. 

**NOTE:** Applying a permission on an object does not actually enable or disable anything. Permissions are simply markers of arbitrary relationships that can be used by Spring Security to restrict access. It is important to clearly define what having a particular permission on an object means. For example, a user could have a WRITE permission on an object that represents a form they have created, and that relationship has been clearly defined to mean that user is allowed to edit the questions in the form. 
