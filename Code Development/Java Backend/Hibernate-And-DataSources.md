#Hibernate and DataSources

##Hibernate
Hibernate is an implementation of the [*Java Persistence API*](http://www.oracle.com/technetwork/java/javaee/tech/persistence-jsp-140049.html). This API provides a method of persisting POJOs to a particular data source. In short, This API provides a general way to create a POJO that can be easily persisted, modified, and retrieved. Hibernate is a complete Java Persistence framework, as well as a JPA implementation. In most instances, we utilize the JPA specification rather than Hibernate's native API.

JPA and Hibernate are powerful and complicated parts of Java EE development. Because of this, there are multiple "right" ways to do things. For example, pure JPA has no concept of a bean, yet our implementation utilizes multiple beans. Because of this flexibility in configuration and implementation, most tutorials and examples online will not match up with our specific implementation exactly. This can make it difficult to understand. However, this document should give a basic level of understanding that is sufficient for updating and maintaining these java backends.

##EntityManagerFactory
The most important part of Hibernate is the `EntityManagerFactory` class. A bean of this class is defined in *applicationContext.xml* in all of our backends. An example of this bean definition is below. 

```xml
    <bean id="entityManagerFactory"
        class="org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean">
        <property name="persistenceXmlLocation" value="classpath:config/persistence-dash.xml" />
        <property name="persistenceUnitName" value="dashPersistence" />
        <property name="dataSource" ref="dashDS" />
        <property name="packagesToScan" value="dash.*" />
        <property name="jpaVendorAdapter">
            <bean class="org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter">
                <property name="showSql" value="false" />
                <property name="databasePlatform" value="org.hibernate.dialect.MySQLDialect" />
            </bean>
        </property>
        <property name="jpaProperties">
            <props>
                <prop key="hibernate.hbm2ddl.auto">update</prop>
            </props>
        </property>
    </bean>
```

Several properties in this definition are important and will be discussed individually.

###DataSources
The `EntityManagerFactory` bean contains a reference to the `DataSource` bean that identifies what data source the `EntityManager` instances should target. This bean definition is below.

```xml
<bean id="dashDS" class="org.springframework.jndi.JndiObjectFactoryBean"
        scope="singleton">
    <property name="jndiName" value="java:comp/env/jdbc/dashDB" />
    <property name="resourceRef" value="true" />
</bean>
```

This bean references a JNDI name that is declared in *context.xml*. In order to change the database being used by an application, you must change the information in *context.xml*. This will change the database targeted by the `EntityManager` instances created by the `EntityManagerFactory`, and will also change all other database references such as authentication.

###hibernate.hbm2ddl.auto
This *hibernate.hbm2ddl.auto* property is used to select a database initialization option. Hibernate has the ability to automatically generate a database schema based on your entity mappings during initialization. Be careful with this property as it can potentially cause data loss. This property has 5 potential values, defaulting to *none*.

+ *none* - No changes will be made to the database
+ *validate* - The current schema will be compared against the entity mappings. Differences will be reported but no changes will be made
+ *update* - The current schema will be compared against the entity mappings. Differences will be changed if possible. It is important to note that this cannot guarantee a proper mapping. For example, if the type of a member variable was changed, Hibernate is unable to modify that variable. This could cause problems if the two data types are not valid. 
+ *create* - A "create if not exists" statement will be used to create a schema matching the entity mappings. If tables already exist, they will not be modified
+ *create-drop* - The previous schema will be completely dropped and the existing entity mappings will be used to create a new schema.

While the *hibernate.hbm2ddl.auto* property can be useful, it should be used carefully as it can delete data. It is useful for generating a new schema if you are starting a project from scratch. This property should be avoided on production systems to prevent data loss.

##Transaction Management
The `TransactionManager` bean handles transactions with the database. Certain queries must be performed within a transaction to be safe. This include most queries that have the potential to change data in the database. Data can be retrieved outside of a transaction but not inserted or modified. In order to begin a transaction, you must annotate a method as `@Transactional`. This should be done on service layer methods. Transactions serve as a way of protecting against exceptions and failures in code. If a method is marked as `@Transactional`, it will open a transaction when the method begins execution. Everything will operate within that transaction until the method ends. If an exception is thrown or something interferes with the execution of the method, the data will *roll-back* to the state it was in when the transaction begins. Look at the following code example. 

```java

@Transactional
public void testMethod(){
    user.setAge(30);
    ...
    updateUser(); //Updates the user object in database
    otherMethod();
}
```

Assume that an exception was thrown inside of `otherMethod()` that caused a roll back. The value of `user.age` would be reset to whatever it was before `testMethod()` began execution rather than 30, despite the fact that `updateUser()` has been called.

##HQL and Native SQL Queries
Hibernate uses its own query language, HQL, to construct database queries. HQL is designed to be syntactically similar to standard SQL, but also allows you to query for entire entities. For example, the following query would retrieve the `User` object with id 6.

```SQL
SELECT u FROM User WHERE u.id = 6
```

HQL also provides a single syntax across all database distributions that Hibernate is compatible with. These queries can be build through the `EntityManager` instance in the DAO layer. The code below constructs and executes a query to retrieve a specific `User` object from the database

```java 
public User getUserById(Long id){
    try {
            String qlString = "SELECT u FROM UserEntity u WHERE u.id = ?1";
            TypedQuery<UserEntity> query = entityManager.createQuery(qlString, UserEntity.class);
            query.setParameter(1, id);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
}
```

It is important to use the `query.setParameter()` method rather than directly embedding user input into the query string. This method protects from SQL injection through user input.

####Native SQL
Although HQL is powerful and capable of doing many things standard SQL queries cannot, it is not perfect. In some cases, you may need to use the native SQL language of your database to execute queries. Hibernate allows us to construct a *Native SQL Query* through it's `Session` object. Hibernate's `EntityManager` class is actually wrapped around the `Session` class used by Hibernate's native API. This can be done by simply calling `entityManager.unwrap(Session.class`. This method returns the current `Session` instance. The `Session` object can then be used to build a native SQL query by calling `session.createSQLQuery(String arg0)` method. An example of a basic SELECT query is below.

```Java
Session session = entityManager.unwrap(Session.class);
String qlString = "SELECT string_col FROM table WHERE int = :int";
SQLQuery query = session.createSQLQuery(qlString);
query.setLong("int", int);
List<String> strings = query.list();
return strings;
```