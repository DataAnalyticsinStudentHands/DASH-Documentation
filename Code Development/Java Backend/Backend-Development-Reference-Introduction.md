#Introduction

This page of the wiki is intended to assist backend developers with understanding the design strategies we've used to create this generic and flexible backend and how to extend this code base for a new project.  Our design of this backend is based on Object Oriented Design and you should be familiar with that paradigm before attempting to design your own implementations. You should also be familiar with HTTP protocol and how clients and servers interact in general.

This wiki page is going to use the SampleObject as an example for each layer of the project for implementing CRUD (Create, Read, Write, Delete) services.  SampleObject is a "plain old java object" which represents a generic domain object for you to copy/paste->find/replace and implement your own domain objects.  See the section on "Extending the Project for a New Application" for tips on how to use the SampleObject stack to rapidly implement new domain object.

# Architecture

Every project extended from this code base is built using a similar architecture.  Please note that we have developed our own flavor of terminology for these layers but for internal purposes it is useful to refer to them the same way.  Simply put each domain object in our RESTful backend have: 

1. A resource layer which accepts requests and returns responses with useful HTTP status codes, JSONs and files when appropriate 
1. A service layer where application logic is implemented 
1. A DAO layer which formulates queries to read, write and delete objects in the database. 

![A simple diagram of our three layer architecture](http://i.imgur.com/ROhqVxG.png)

Each domain object can have two forms:

1. POJO (Plain Old Java Object), the java representation of the object and can be converted to/created from JSON objects
1. Entity, a mapping to convert the POJO into fields in a database

Please note: Newer projects combine the POJO and Entity in one object. These projects will only have SampleObject.java and will not contain SampleObjectEntity.java

