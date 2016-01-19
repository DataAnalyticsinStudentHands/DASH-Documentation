# NEEDS TO BE EDITED: Description of the Java Backend

We are using [Jersey](https://jersey.java.net/) as framework for providing REST.

 * Some notes about how we do [logging](../ Logging.md)
 * Page [Access Control Lists](../Access-Control-Lists.md)
 * Page [Backend Development Reference Introduction](../Backend-Development-Reference-Introduction)
 * Page [DAO Layer](../DAO-Layer.md)
 * Page [Resource Layer](../Resource-Layer.md)
 * Page [Service Layer](../Service-Layers.md)
 * Page [Core VMA](../Volunteer-Management.md)


# NEEDS TO BE EDITED: DASH Volunteer Management App Backend

## Contents

 1. [Introduction](../README.md#welcome)
   * [Welcome](..//README.md#welcome)
   * [Using the API](../README.md#using-the-api)
     * [Type Definition](../README.md#type-definition)
     * [Resource Use Cases](../README.md#resource-use-cases-create-read-update-delete-ect)
     * [Permission Management](../wiki#permission-management-use-cases-only-for-resources-utilizing-access-control)
  * [Authentication](../README.md#authentication)
   * [The Cors Filter](../README.md#the-cors-filter)
   * [Error Codes](../README.md#error-codes)


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
 All apps will use some form of authentication.  Every API request must include a Basic Authorization header, which will be evaluated for validity, prior to performing an service. The password should be hashed and salted (Please see @CarlSteven or @cmholley for our hashing salting algoriths) before encoding the username/password into Basic.


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

#Setting up your local development environment
1. Download the following
    + [Java 7](../How-To-Install-JAVA.md)
    + Eclipse Java EE Edition (Java local IDE)
    + XAMPP (Used to temporarily activate Apache and MySQL at localhost)
    + SourceTree (for git managment)
    + putty (For ssh, windows only. Mac and Linux can use command-line ssh)
    + WinSCP (For file transfering between local machine and server)
    + MySQL Workbench (Remote SQL management)
    +  