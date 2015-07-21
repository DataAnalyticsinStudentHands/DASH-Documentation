## Introduction

The Resource layer is generally responsible for containing the code which maps out the URL scheme for the API and also translates between JSON and Plain Old Java Objects. Each API method in the Resource layer can accept parameters and data in the form of headers or post data and then uses forwards that data on to the service layer where business logic is performed.

###Defining the Resource Class

The resource layer can be found in the directory "src/.../pojo". We will be stepping through SampleObjectResource.java.

    @Component("sampleObjectResource")
    @Path("/sampleObjects")
    public class SampleObjectResource {...}

@Component registers the class as part of the web service and  will be used on the resource, service implementation, and DAO implementation layers.  When creating your own resource class just replace "sampleObject" with "yourObjectClassName".

@Path defines the url that this resource can be accessed at.  In practice it appends the "/sampleObjects" to the end of the URL for the webservice.

###Creating New Objects

In **C**.R.U.D the 'C' stands for Create.  The first thing a new user is going to do when they use and application is register or create a new account. Every time a user writes a comment or starts a new group they are creating new database entries which will be read, modified and deleted as the people use the application.

Generally the API returns a status code which tells the client application that the object was successfully created or that the creation failed and will describe why.

####Creating a Single Object

The create method for a resource should be accessed by a @POST to the resources root path.

	@POST
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.TEXT_HTML })
	public Response createSampleObject(SampleObject sampleObject)
			throws AppException {
		Long createSampleObjectId = sampleObjectService
				.createSampleObject(sampleObject);
		return Response
				.status(Response.Status.CREATED)
				// 201
				.entity("A new sampleObject has been created at index")
				.header("Location", String.valueOf(createSampleObjectId))
				.header("ObjectId", String.valueOf(createSampleObjectId))
				.build();
	}
	
The @Consumes tag defines that the Client need to send a JSON string as input.  Jackson will automatically take the incoming JSON and attempt to map it to the methods parameter which in this case is of type SampleObject.  This relies on the mapping provided in SampleObject.java by the @XMLElement tags.

Inside the method the sampleObject is handed to the createSampleObject funtion of the Service layer.  If everything is successful then the method returns the 201 code and includes information about the new objects ID and the URL to access it.

See the section on returning status codes and the section on object creation at the service level for how to return useful error information.

####Creating a collection of Objects

*See createSampleObjects(List<SampleObject> sampleObjects) example.  Note that this method is not in use and its use is restricted to ROOT for testing purposes only.

###Returning Information from the API

The body of the resource class contains your API methods.  At its most basic it contains methods to create, read, edit, and delete a domain object of that resource class also know as "CRUD". When looking at SampleObjectResource.java you will notice there are many more methods than just these four and you are able to add  and removed unused methods to customize the API.  

Most API methods return either a Response object or domain object/objects.  A Response object contains an HTTP status code and a message body which can contain an error message or other information and is used when you want to communicate that something did or did not work but you have no data that needs to be transmitted. When you need to return data to the client, you can return the POJO version of your domain object or even a collection of POJOs. 

####To return a status code

There are standardized HTTP status codes which we try to use.  Refer to http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information.

There are a couple of reasons you would want to return a response code:

1. Everything worked just fine but you don't need to return an object or
1. Something went wrong and you need to let the client know why.

#####Case 1

    @POST
	@Consumes({ MediaType.APPLICATION_JSON })
	@Produces({ MediaType.TEXT_HTML })
	public Response createSampleObject(SampleObject sampleObject)
			throws AppException {
		Long createSampleObjectId = sampleObjectService
				.createSampleObject(sampleObject);
		return Response
				.status(Response.Status.CREATED)
				// 201
				.entity("A new sampleObject has been created at index")
				.header("Location", String.valueOf(createSampleObjectId))
				.header("ObjectId", String.valueOf(createSampleObjectId))
				.build();
	}

In this method the API takes in a JSON string, converts it to a POJO, and then creates a new row in the database to record this object. For this method we don't need to send the client the object back since they are writing to the database and it makes sense just to let the client know that everything worked the way it should.

To return a Response object, you would just make the method return type Response, set the @Produces annotation as "MediaType.TEXT_HTML" and then return a Response object created like the one above.  With this implementation, if no exceptions are thrown, this method will return a 201 (Created) code which tells the client that the request was successfully executed on the new object was created.

#####Case 2

Unlike the Case 1, sending an error code can happen in any layer of the backend and can occur in every API method, regardless of its defined return type.  Obviously we would never make a API method that's sole purpose was to return an error.  Instead we throw an exception and any unhandled exceptions will be returned to the client device.

    @GET
	@Path("{id}")
	@Produces({ MediaType.APPLICATION_JSON })
	public Response getSampleObjectById(@PathParam("id") Long id,
			@QueryParam("detailed") boolean detailed) throws IOException,
			AppException {
		SampleObject sampleObjectById = sampleObjectService
				.getSampleObjectById(id);
		return Response.status(200)
				.entity(new GenericEntity<SampleObject>(sampleObjectById) {
				}).header("Access-Control-Allow-Headers", "X-extra-header")
				.allow("OPTIONS").build();
	}

This method returns a JSON translation of a sampleObject when it works properly. But if the user were to ask for a sampleObject that doesn't exist the API needs to return an error code with a message about why the request failed.

Notice that this method's return type is SampleObject, not Response but it Throws exceptions IOException and AppException.  IOExceptions are thrown by Hibernate when a query to the database fails, AppExceptions can be generated by code that you write and are a the best way for you to communicate to the client that something went wrong. 

The AppException class is defined in https://github.com/DataAnalyticsinStudentHands/RESTFUL-WS/blob/master/src/main/java/dash/errorhandling/AppException.java

 In this example the most common error which will be communicated to the client is that a sampleObject with the ObjectId that they provided does not exist (error code 404).  The exception is thrown in the sampleObjectServiceImpl.java(line: 89):

    public SampleObject getSampleObjectById(Long id) throws AppException {
		SampleObjectEntity sampleObjectById = sampleObjectDao
				.getSampleObjectById(id);
		if (sampleObjectById == null) {
			throw new AppException(Response.Status.NOT_FOUND.getStatusCode(),
					404, "The sampleObject you requested with id " + id
							+ " was not found in the database",
					"Verify the existence of the sampleObject with the id "
							+ id + " in the database",
					AppConstants.DASH_POST_URL);
		}

		return new SampleObject(sampleObjectDao.getSampleObjectById(id));
	}

On line 92 it checks if the sampleObjectById is still null, meaning that it was not found.  If it is null the AppException is built with the 404 error and a quick message about what happened is included. The exception is handed up the stack until its caught by the servlet container which converts it into a response to send to the user.

####To return an Object or and Array of Objects

One of the basic API methods of C.**R**.U.D. is Read.  It should provide the user with a JSON of the object that they requested.  All read based methods should be accessed through a @GET request and therefore will start with that annotation.

An API method can return POJO or even a List of POJOs which Jackson will translate into a JSON string. The POJO we are working with in these examples is SampleObject.java. Refer to this section for instructions on how to define POJOs so that they are mapped for JSON conversion.

#####Return a single POJO

 There are two ways to achieve this. The following method is an implementation where you return a collection with only one object:

    @GET
    @Path("{id}")
    @Produces({ MediaType.APPLICATION_JSON })
	public Response getSampleObjectById(@PathParam("id") Long id,
			@QueryParam("detailed") boolean detailed) throws IOException,
			AppException {
		SampleObject sampleObjectById = sampleObjectService
				.getSampleObjectById(id);
		return Response.status(200)
				.entity(new GenericEntity<SampleObject>(sampleObjectById) {
				}).header("Access-Control-Allow-Headers", "X-extra-header")
				.allow("OPTIONS").build();
	}

The @Produces({ MediaType.APPLICATION_JSON }) annotation tells Jackson to treat your object as a JSON string.  Lines 128-131 build the response object which contains the SampleObject. Response.entity(GenericEntity) is where you wrap your SampleObjects in a GenericEntity which can be converted into a JSON string.

The alternative method for returning a single object is the recommended implementation.  

    @GET
	@Path("myUser")
	@Produces({ MediaType.APPLICATION_JSON })
	public User getMyUser()
			throws AppException {
		List<User> users = userService.getMyUser();
		if (!users.isEmpty()) {
			return users.get(0);
		}
		else
			return null;
	}

Again the @Produces annotation declares that we are sending a JSON. This implementation just returns the POJO version of the object that you want to return.  This relies on the @XmlElement annotations in POJO class declaration and requires no special Response object or generics.

#####Return an Array of Objects

You can return a collection of objects similar to the first implementation of returning a single object above. Here is the example implementation:

    @GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public List<SampleObject> getSampleObjects(
			@QueryParam("numberOfSampleObjects") @DefaultValue("25") int numberOfSampleObjects,
			@QueryParam("startIndex") @DefaultValue("0") Long startIndex)
			throws IOException, AppException {
		List<SampleObject> sampleObjects = sampleObjectService
				.getSampleObjects(numberOfSampleObjects, startIndex);
		return sampleObjects;
	}

@Produces tag allows the method to produce a JSON string or the XML form of the same collection (The client can use a header to select which version they need).  Just build a list of the objects to be returned and Jackson will convert it to the proper form.
