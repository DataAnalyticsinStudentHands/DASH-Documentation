## Service Layer

The service layer is comprised of two pieces: an interface and the implementation. In addition to the usual benefits of using an interface/implementation pair, Spring Security allows us to perform access control inside the service interface.

A resources method will call a service layer method via the interface, passing POJOs into the service layer.  The service layer then can perform any operations necessary on the data and then can do any combination of the following: return data back to the resource layer for transmission to the client and/or it can access methods of the DAO layer to manipulate the database.

##Service Interface

The interface is really only significant because of the spring security annotations that we use here. Be sure to see the page on Access Control lists for more information on how to the service interface to restrict access to each method.  Other than these annotations the Interface just serves to disconnect the implementation from other classes which use this service class. 

Example:

    @PreAuthorize("hasPermission(#sampleObject, 'delete') or hasRole('ROLE_ADMIN')")
	public void deleteSampleObject(SampleObject sampleObject);

**Often it is required to check permissions on an object, but the object is not actually used by the method so there are many methods which pass in unused parameters.

##Service Implementation

The service layer contains all of the business logic specific to your application. The service layer also converts the domain object between its POJO and Entity forms.  

####Declaring a Service Impl

Looking at SampleObjectServiceDbAccessImpl.java:

    @Component("sampleObjectService")
    public class SampleObjectServiceDbAccessImpl extends ApplicationObjectSupport
		implements SampleObjectService {

	@Autowired
	SampleObjectDao sampleObjectDao;

	@Autowired
	private GenericAclController<SampleObject> aclController;

The @Component tag registers the service as a spring bean. For more information about beans see http://www.tutorialspoint.com/spring/spring_bean_definition.htm.  Just know that this is required and should follow this format.

@Autowired triggers dependency injection and will initialize the variable using an appropriate bean if available.

####Business Logic

Because the service layer is by nature specific to your application a large portion of the Service Layer Methods will be specific to your application.  However most Services Layers will still implement CRUD methods.  Let look at SampleObjectServiceDbAccessImpl.CreateSampleObject(SampleObject):

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

The @Transactional Tag is required on all methods that will write to the database.  Read-only methods do not need this tag. 

Notice that the Doa layer accepts entities instead of POJO's; each entity should have a constructor which accepts the POJO.  

