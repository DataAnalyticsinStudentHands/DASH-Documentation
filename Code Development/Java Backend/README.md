#Welcome
 These documents designed to assist back end developers with understanding and working on all of our Java backends. This introduction page includes generic information that is applicable to all of the apps using the DASH server.

##Recommended Reading Order
If you are new to the java backend projects in our organization, please read the documents in the following order. Instructions for setting up your local development environment can be found below.

1. [Backend Development Reference Introduction](./Backend-Development-Reference-Introduction.md)
2. [Resource Layer](./Resource-Layer.md)
3. [Service Layer](./Service-Layer.md)
4. [DAO Layer](./DAO-Layer.md)
5. [Hibernate and DataSources](./Hibernate-And-DataSources.md)
6. [Spring](./Spring)
7. [Access Control Lists and Filtering](./Access-Control-Lists-and-Filtering.md)
8. [Multi-tenancy](./Multi-tenancy.md)
9. [Scheduling and Quartz](./Scheduling-and-Quartz.md)
10. [EMA Use Case](./EMA-Use-Case.md)
11. [Logging](./Logging)

The [Glossary and Acronyms](./Glossary-And-Acronyms.md) and [Learning Resources](./Learning-Resources.md) documents provide general information for use duing development and further readings. These documents can be consulted as needed.

##Technologies Used 
Our backends use [Jackson](http://wiki.fasterxml.com/JacksonHome) to expose the backends functionality to front end HTTP requests. Jackson helps to convert JSON data into java objects and vice versa. Our projects are created with the [Spring Framework](https://projects.spring.io/spring-framework/). This framework provides dependency injection and security features for our webservices. Logging is accomplished through the [Logback Project](http://logback.qos.ch/). Database access and ORM is done through [Hibernate](http://hibernate.org/) and their [JPA](http://www.oracle.com/technetwork/java/javaee/tech/persistence-jsp-140049.html) implementation. 

##Authentication
 All apps will use some form of authentication.  Every API request must include a Basic Authorization header, which will be evaluated for validity, prior to performing an service. The password should be hashed and salted (Please see @CarlSteven or @cmholley for our hashing salting algorithms) before encoding the username/password into Basic.

#Setting up your local development environment
1. Download the following
    + [Java 7](./How-To-Install-JAVA.md)
    + [Eclipse Java EE Edition](https://eclipse.org/downloads/) (Java local IDE)
    + [XAMPP](https://www.apachefriends.org/index.html) (Used to temporarily activate Apache and MySQL at localhost)
    + [SourceTree](https://www.sourcetreeapp.com/) (for git management)
    + [putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) (For ssh, windows only. Mac and Linux can use command-line ssh)
    + [WinSCP](https://winscp.net/eng/download.php) (For file transfers between local machine and server)
    + [MySQL Workbench](https://www.mysql.com/products/workbench/) (Remote SQL management)
2. Clone the backend repository through git. A tutorial for doing this through SourceTree can be found [here](https://confluence.atlassian.com/bitbucket/clone-a-repository-223217891.html).
3. Import the project into Eclipse. A tutorial for this can be found [here](http://agile.csc.ncsu.edu/SEMaterials/tutorials/import_export/).
4. Create a server in Eclipse to run the backend on. Our servers run on Tomcat 7, so make sure you select Tomcat 7 for you local server.
5. Add the project to the server by right clicking the server, clicking "Add and Remove" and following the instructions. 