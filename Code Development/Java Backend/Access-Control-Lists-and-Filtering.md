#Access Control Lists (ACLs) and Filtering/Authorization

We utilize Spring Security to protect data from unauthorized access. There are three primary things that you will need to be able to do: 

1. Restrict access to an object/method 
1. Register an object and initialize its ACL
1. Grant/revoke permissions on an object


There are several classes in the security directory that implement our version of ACLs. Please note that we have overwritten several classes with custom implementations. These classes are typically named "CustomWhatever.java" and there is inline documentations about what was modified.

For information about the database schema see http://docs.spring.io/spring-security/site/docs/3.0.x/reference/domain-acls.html

# Restrict Access 

The first use case of ACLs is to prevent access to data that a client does not have permission to read.  By default the permissions required are checked against the permissions granted to the currently authorized user.

    @PostAuthorize("hasPermission(returnObject, 'read')")
    public SampleObject getSampleObjectById(Long id) throws AppException;

The PostAuthorize tag is used to perform access control after the method has been executed, particularly useful for read operation.   The tag accepts a string parameter which is evaluated as a boolean expression.  In this case it looks at the object being returned from the database (#returnObject) and checks if the currently authenticated user has the 'read' permission.

Another similar tag is the PostFilter.

    @PostFilter("hasPermission(filterObject, 'READ')"
    public List<SampleObject> getSampleObjects(int numberOfSampleObjects, Long startIndex) throws AppException;

PostFilter will read through the returned collection(filterObject) and remove any objects which the current user doesn't have the required permission (in this case READ)

Both Filter and Authorize have two forms, Post- and Pre-. **@PreAuthorize** and **@PreFilter** will validate the user before executing the annotated method, while **@PostAuthorize** and **@PostFilter** will validate after the execution of the method. You can use these annotations with the **hasPermissions(object, permission)** and **hasRole(role)** methods, as well as any other boolean expression. You do have access to static methods, as well as member methods of the annotated method's parameters. Below are examples of these.

Checks for read permission on object1
	
	@PreAuthorize("hasPermission(#object1, 'READ')"
	public void doSomething(Class1 object1, Class2 object2)

Uses a static method. In this case, the static methods **Class1.staticMethod()** would be executed, and the authorize would be evaluated on the return of this method

	@PreAuthorize("Class1.staticMethod()")

Uses **hasRole()** to check if the user has ROLE_ADMIN as its role

	@PreAuthorize(hasRole('ROLE_ADMIN')

Uses member function of the methods parameter. In this instance, assume **Class1** has a public method with a boolean return type called **booleanMethod()**. This can also be used with **returnObject** and **filterObject** as well.

	@PreAuthroize("#object1.booleanMethod()")
	public void doSomething(Class1 object1)

Longer boolean expression

	@PreAuthorize("hasPermission(#object1, 'READ') or hasPermission(#object2, 'READ') or hasRole('ROLE_ADMIN')
	public void doSomething(Class1 object1, Class2 object2)

For more information about built in security annotations please see http://docs.spring.io/spring-security/site/docs/3.0.x/reference/el-access.html

# Register/Unregister an Object with Spring and Create/Delete its ACL

Before you can keep track of who is allowed which permissions on an object, you must first register the object with spring and create the ACL for that object.

##### Which objects require registration?

Any object belonging to a class which you will require object level permissions for.  Not all objects require an ACL. Here are two cases where you would not create an ACL for an object.  

1. The object belongs to another object (aggregation / composition) which already has an ACL and you will not be sharing permissions on the owned object with other users.
1. The object is only used by the backend internally, there for no users would explicitly read/write/create them.

Other than these two cases, most POJO's which contain domain data are going to use permissions and therefor require an access control list.

##### How to Register an Object (except the User)

First the class you wish to use ACLs on must implement the interface IAclObject. When an object of this class is instantiated (in the service implementation layer) you will need to use the GenericAclController.java class to register the object with Spring Security and create its ACL. There are two methods CreateACL(T) and CreateACL(T, sid) that are used to register the object.  CreateACL(T) will set ownership of the object to the currently authenticated User and CreateACL(T,sid) allows you to pass in the sid of another User which you would like to grant ownership to.

**Please note our implementation of Springs ACL does not rely on ownership for anything and in many cases ownership is just given to the root user.

After creating the ACL for a object you should be sure to give read, write, delete permissions to the User who created the object, if that is appropriate.  See the section below about creating permissions.

Example implementation from **SampleObjectServiceDbAccessImpl.java**

        @Override
	@Transactional
	public Long createSampleObject(SampleObject sampleObject)
			throws AppException {

		long sampleObjectId = sampleObjectDao
				.createSampleObject(new SampleObjectEntity(sampleObject));
		sampleObject.setId(sampleObjectId);
		aclController.createACL(sampleObject);
		aclController.createAce(sampleObject, CustomPermission.READ);
		aclController.createAce(sampleObject, CustomPermission.WRITE);
		aclController.createAce(sampleObject, CustomPermission.DELETE);
		return sampleObjectId;
	}

##### Unregister and Delete ACL

When an object that has an ACL is deleted (ie. in the service implementation delete method), its ACL also needs removal.  Use GenericAclController.DeleteACL(T) to destroy the associated ACL.

# Grant/Revoke Permissions for a User

 You will use the **GenericAclController.java** class in the service layer implementation to grant and revoke permissions.  The object must have already been registered with Spring and have an ACL previously created before you may uses these methods.

You will almost always use these methods when an object is created to give permissions to the the object's creator.  If Users other than the author will be given permissions on the object, you will need to add methods to the Service Layer which exist specifically to give permission to other users.

##### Granting Permissions

Use **CreateAce(T, permission)** and **CreateAce(T, permission, sid)** to create an "Access Control Entry" or ACE.  An ACE represents a single permission (parameter "permission") on an object (parameter "T") given to a single user (either the currently authenticated User or User represented by parameter "sid").  

##### Delete a Permission
Likewise the **GenericAclController.DeleteACE(T, Permission, Sid)** will delete a single permission.

# Custom Permissions

Basic READ, WRITE, CREATE, ADMINISTRATION, and DELETE permissions are implemented in the **BasePermission.java** class. In order to add additional flexibility, several projects include a **CustomPermissions.java** class in the Security directory. This class extends the **BasePermission.java** class, and the new permissions must be registered in a new factory class, in this case **CustomPermissionFactory.java**. This custom factory should be used in all instances where a factory is needed to generate a permission. The new permissions must be given a new, unique mask. In most instances, just continue with the numbering scheme found in **BasePermission.java**. When creating a new permission type, first be sure that the 5 existing permissions are not sufficient. When naming the new permission, be sure to give it a proper name so that other developers can understand its purpose easily.

#Database Diagram

*To do: Create database diagram*