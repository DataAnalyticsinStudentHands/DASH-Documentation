# NEEDS TO BE EDITED: Description of the Java Backend

We are using [Jersey](https://jersey.java.net/) as framework for providing REST.

 * Some notes about how we do [logging](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/Logging.md)
 * Page [Access Control Lists](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/Access-Control-Lists)
 * Page [Backend Development Reference Introduction](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/Backend-Development-Reference-Introduction)
 * Page [DAO Layer](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/DAO-Layer)
 * Page [Resource Layer](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/Resource-Layer)
 * Page [Service Layer](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/Service-Layers)
 * Page [Core VMA](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/Volunteer-Management)





 # NEEDS TO BE EDITED: DASH Volunteer Management App Backend

 ##Contents
 1. [Introduction](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#welcome)
   * [Welcome](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#welcome)
   * [Using the API](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#using-the-api)
     * [Type Definition](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#type-definition)
     * [Resource Use Cases](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#resource-use-cases-create-read-update-delete-ect)
     * [Permission Management](https://github.com/DataAnalyticsinStudentHands/RESTFUL-WS/wiki#permission-management-use-cases-only-for-resources-utilizing-access-control)
  * [Authentication](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#authentication)
   * [The Cors Filter](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#the-cors-filter)
   * [Error Codes]https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/blob/master/Code%20Development/Java%20Backend/README.md#error-codes)
 2. [Volunteer Management App](https://github.com/DataAnalyticsinStudentHands/RESTFUL-WS/wiki/Volunteer-Management#volunteer-management-app)
   * Contents
   * API
     * Users
     * Groups


 ## Welcome
 This wiki is designed to assist front end developers connect and utilize the RESTful API for their application.  This introduction page includes generic information that is applicable to all of the apps using the DASH server.

 ## Using the API
 Each resource for each application has a dedicated page on the wiki.  You can find a comprehensive list of resources on the home page for that app. An applications resources are accessed by navigating to housuggest.org:8888/*APP NAME HERE*/*RESOURCE*.   Here is a description of the components of a resources wiki.

 ### Type Definition
 1. Accounts for all of the fields/variables of that data type
 2. Provides a conceptual explanation of any permission or roles that are used.
 3. Outlines the URL structure for that resource

 ### Resource Use Cases (Create, Read, Update, Delete, ect..)
 1. Defines the URL and Method for each use case.
 2. Defines all of the required and optional parameters.
 3. Declares which roles and permissions are required for access.
 4. Provides the format of possible responses.

 ### Permission Management Use Cases (Only for resources utilizing access control)
 1. Defines the URL and Method for each use case.
 2. Defines all of the required and optional parameters.
 3. Declares which roles and permissions are required for access.
 4. Provides the format of possible responses.

 ##Authentication
 All apps will use some form of authentication.  Every API request must include a Basic Authorization header, which will be evaluated for validity, prior to performing an service. The password should be hashed and salted  (Please see @CarlSteven or @Tswiggs for our hashing salting algorithm) before encoding the username/password into Basic.  See the section on error codes 401 and 500, code 5001 "access is denied", for information about handling failed Authentication.

 ##The Cors Filter
 TODO: Write instructions for using preflights.

 ##Error Codes
 TODO: Write decriptions of each error code







Some weird old stuff ... that needs to be cleaned out.

Instructions for authentication against the security filter
===========================================================

1. Set up the webSecurityConfig.xml to connect to the database you keep the security tables in.  By default it connects to the DB `test` with the login credentials "root" and no password.

2. Import the test_acl.sql file included in the mysql directory.  This includes the necessary tables for user management and acl.  The only user that comes with the table is "tyler" who is given "ROLE_ADMIN".  You can use this user to authenticate against the server to gain access to UserService.createUsers() function which should allow for batch creation of users.  All new users created via post are given role "ROLE_USER".

Using ACL for new object services
=================================

For examples of using PreAuthorize, PostAuthorize, PreFilter, and PostFilter..
See http://krams915.blogspot.com/2011/01/spring-security-3-full-acl-tutorial_1042.html

Key things to remember:
1. Authorization annotations should be included at the service level interface.

2. Any methods that will delete a resource should accept an instance of the POJO as a parameter and apply a PreAuthorization annotation. Do not allow deletion of an object with just an id, it wont work right.  The have to give us a json of the object they want to delete. Example:

    I want to delete an object of class Foo, called bar.
    My service level method should look like

    ```
    @PreAuthorize("hasPermission(#bar, 'DELETE')")
    void deleteObject(Foo bar);
    ```

3. All  POJOs that will be access controlled need to implement interface IAclObject.  Make sure that it is the POJO that implements it, and not the entity for that POJO.

4. The service implementation of all resources (other than user) should contain an instance of GenericAclContoller.  Be sure to provide the template the POJO class you are handling with that service.
