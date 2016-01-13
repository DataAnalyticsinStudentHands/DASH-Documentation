#Introduction
The DAO or Data Access Object Layer uses the Entity form of the domain object to interface with the database. Like the Service layer the DAO is broken into an Interface and Implementation.  There is nothing out of the ordinary in the interface so we will focus on the Implementation.

Our DAO implementation uses Hibernate to facilitate communication with the MySQL backend.

##Declaring the DAO
Let's look at SampleObjectDaoJPA2Impl.java:

    @Component("sampleObjectDao")
    public class SampleObjectDaoJPA2Impl implements SampleObjectDao {
	@PersistenceContext(unitName = "dashPersistence")
	private EntityManager entityManager;

The @Component tag registers the class with Spring as a bean.  

Using the @PersistenceContext tag on the declaration of EntityManager initializes entityMangager with the correct bean. 

Some of our java backends connect to multiple databases through the same code base. This concept is called "multi-tenancy." Details of this can be found in the [multi-tenancy documentation](../Multi-tenancy). 

##Reading from the database

The most common thing that you will need to do is read from the database.  This is in SQL using a select statement and we can leverage Hibernate to make this even easier and safer.

SampleObjectDaoJPA2Impl.getSampleObjectById(Long):

    @Override
	public SampleObjectEntity getSampleObjectById(Long id) {

		try {
			String qlString = "SELECT u FROM SampleObjectEntity u WHERE u.id = ?1";
			TypedQuery<SampleObjectEntity> query = entityManager.createQuery(qlString,
					SampleObjectEntity.class);
			query.setParameter(1, id);

			return query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		}
	}

This method takes a Long (ids are Long as opposed to int) and returns the object with that id from the table SampleObjects are stored in (this table is defined in the Entity).  This method uses a prepared statement.  IT IS EXTREMELY IMPORTANT TO USE PREPARED STATEMENTS BECAUSE THEY PREVENT BAD USER INPUT FROM BECOMING AN SQL INJECTION ATTACK.

##Notes about efficiency

Well written SQL/Hibernate queries are essential for efficient execution.  The rule of thumb is to craft your read queries so that they return only the objects that you need to access. For example do not write a query that retrieves a collection of entries, and then uses java code to pick only one of those entries to return.  Instead design your database so that searches can be done in a single step and that any Columns that you SELECT on are indexed.  