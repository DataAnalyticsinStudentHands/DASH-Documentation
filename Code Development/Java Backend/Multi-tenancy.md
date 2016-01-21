#Multi-Tenancy

Multi-Tenancy is defined by [Gartner IT](http://www.gartner.com/it-glossary/multitenancy) as "the mode of operation of software where multiple independent instances of one or multiple applications operate in a shared environment. The instances (tenants) are logically isolated, but physically integrated." Essentially multi-tenancy is an architectural design where multiple tenants interact with the software, but are isolated from each other. For example, imagine there is a company that provides a social network application that is used within a company. Companies like this exist, such as [Edmodo](https://www.edmodo.com/) and [Bitrix24](https://www.bitrix24.com/). Two companies could pay you to set up networks within your application, but those two networks would exist separate from each other. One network's users cannot connect to the other network despite the fact that all of the server side code is running the same. Each company in this example is it's own "tenant". In contrast, a website like Facebook would NOT be considered a multi-tenant application because all users interact with the same instance of the application. There is no logical separation of data with shared functionality. 

##Combined Backend
Our implementation of multi-tenancy can be found in our [Combined Backend Repository](https://github.com/DataAnalyticsinStudentHands/CombinedBackend). This java backend is designed to serve as a single code base that can handle various clones of the [VMA](./Volunteer-Management.md). This allows us to easily create a front end clone of this project and provide a new VMA style network without having to maintain an separate backend for this. 

##Data Segregation
When using a standard SQL database, you have three separate options for separating one tenant's data from another. 

1. Separate databases
1. Shared database, separate schema
1. Shared database, shared schema

These three options inversely provide simplicity and security. In the first option, each tenant has it's own database instance. The makes it difficult to add a new tenant, since you must instantiate a new database instance each time. However, queries from your code will be directed to a database filled with only that user's data, making it extremely unlikely that one tenant could accidentally acquire or modify another tenant's data. The second option uses a single database instance but multiple schemas in that same database. This is better because it is easier to create a new schema for a new tenant than to instantiate a new database instance, but it is somewhat less secure. Because queries are sent to the same database, it's possible that a query could accidentally target the wrong schema. The final solution is to include all data in the same schema. This is done by adding a tenant id column to every table. This column identifies which tenant each entry belongs to. While this is the simplest method, it is the least secure. Queries all target the same database and it is much more likely that they will impact other tenants data. It also requires you to have an identical data design for all tenants. More information about multi-tenancy can be found in [this article by Microsoft](https://msdn.microsoft.com/en-us/library/aa479086.aspx)

In our multi-tenant applications, we have chosen the second means of data segregation. This method was selected because we do not need to be able to dynamically add tenants, something most easily done with the shared schema approach, and because it provides sufficient data security. Separate database instances are most often used if the tenant needs to have more direct access to the database rather than simply interacting with the data through our UI and API. 

##Implementation
In order to implement multi-tenancy, two things must be accomplished. You must be able to identify the tenant and then access the specific tenant's data. 

###Selecting the proper dataSource
To accomplish the second task, we utilize a special datasource. Our [DAO Layers](./DAO-Layer.md) utilize an `entityManager` to connect to the database. This object is created by the entityManagerFactory bean specified in the project's `applicationContext.xml`. An example definition is below.

```xml
    <bean id="entityManagerFactory"
        class="org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean">
        <property name="persistenceXmlLocation" value="classpath:config/persistence-dash.xml" />
        <property name="persistenceUnitName" value="dashPersistence" />
        <property name="dataSource" ref="datasource" />
        <property name="packagesToScan" value="dash.*" />
        <property name="jpaVendorAdapter">
            <bean class="org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter">
                <property name="showSql" value="true" />
                <property name="databasePlatform" value="org.hibernate.dialect.MySQLDialect" />
            </bean>
        </property>
    </bean>
```

This bean includes a reference to a dataSource bean. In single-tenant applications, this bean would be defined as an instance of `org.springframework.jndi.JndiObjectFactoryBean`. However, Spring also provides an abstract class called `AbstractRoutingDataSource`. This class contains one abstract method `protected Object determineCurrentLookupKey()`. In our projects, `dash.multitenancy.TenantRoutingDatasource` extends this class and implements the function. In multi-tenant applications, the `entityManagerFactory` bean references an bean that is a `TenantRoutingDatasource` as it's dataSource. The `AbstractRoutingDataSource` can function as a single `dataSource` object, but is actually a map of potential `dataSource` objects. The abstract `determineCurrentLookupKey()` method is used to identify which `dataSource` should be selected at runtime. Our implementation simply uses the `ThreadLocalContextUtil` class to access a `ThreadLocal<String>` variable that holds the tenantId. A more detailed tutorial for implementing the `AbstractRoutingDataSource` class can be found [here](https://spring.io/blog/2007/01/23/dynamic-datasource-routing/)


###Constructing the TenantRoutingDataSource bean
Like most beans, the `TenantRoutingDatasource` bean is constructed in `applicationContext.xml`. An example definition is below.

```xml
<bean id="datasource" class="dash.multitenancy.TenantRoutingDatasource">
        <property name="targetDataSources">
            <map key-type="java.lang.String">
                <entry key="tenant1" value-ref="dashDS1" />
                <entry key="tenant2" value-ref="dashDS2" />
            </map>
        </property>
        <property name="defaultTargetDataSource" ref="dash1" />
    </bean>
```

This bean contains a map with references to the actual dataSource beans. This beans can be declared exactly like they would be for a single-tenant application.

###Identifying the Tenant
The tenant is identified for each request by the `MultiTenantIdentifierFilter` class. This filter intercepts all incoming requests, and attempts to find the value of the `X-TenantId` header. This string value is then stored in a `ThreadLocal<String>` variable by the `ThreadLocalContextUtil` class. This means that all requests to a multi-tenant backend must include the `X-TenantId` header, or else they will be routed to the default dataSource. 
