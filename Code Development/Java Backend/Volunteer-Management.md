#Volunteer Management App
1. Introduction
2. Users
  * Type Definition
  * Create
  * Modify
  * Delete
3. Groups
  * Type Definition
  * Create
  * Modify
  * Delete
  * Managers
  * Members

##Introduction
# API
## Users
### Type Definition
### Create
### Modify
### Delete
## Group
### Type Definition
### Create
### Modify
### Delete
### Managers
### Members


Stereotypes
=====================

Test1 (Manager all)
- Has Global role USER
- Test1 Read, Write, Delete
- testGroup1 Manager
- testTask1 Manager
- testPost1 Read, Write, Delete

Test2 (no permissions but own)
- Has global role USER
- Test2 Read, Write, Delete


Test3 (Member for all of Test1's objects)
- Has global role USER
- Test3 read, write, delete
- testGroup1 member
- testTask1 member
- testTask2 manager
- testPost2 Read, Write, Delete

Test4 (Member of testGroup1 but not task)
- Has Global role USER
- Test4 read, write, delete
- testGroup1 member




Test1
=================

Creation
-------------------
1. Users
    - Create user Test1
    - verify data fidelity

2. Groups
   - Test1 creates group testGroup1
    - Check if Test1 is a manager of testGroup1
    - verify data fidelity

3. Tasks
    - Test1 creates testTask1 inside groupTest1
    - Check if Test1 is a manager of testTask1
    - verify data fidelity

4. Posts
    - Test1 creates testPost1
    - Check if Test1 has write permission to testPost1
    - verify data fidelity

Update
------------
1. Users
    - make partial edit to Test1
    - verify data
    - make full edit to Test1
    - verify data

2. Group
    - make partial edit to testGroup1
    - verify data
    - make full update to testGroup1
    - verify data

3. Task
    - partial edit to testTask1
    - verify data
    - full update to testTask1
    - verify data

4. Post
    - partial edit to testPost1
    - verify data
    - full update to testPost1
    - verify data

Deletion
--------------
1. User
    - N/A for now

2. Group 
    - delete testGroup1
    - get testGroup1
    - recreate testGroup1 with diff description
    - verify data
    - verify testTask1 deletion
    - verify testPost1 deletion
    - recreate testTask1
    - recreate testPost1

3. Task
    - delete testTask1
    - get testTask1
    - create testTask1 with diff description
    - verify data

4. Post
    - delete testPost1
    - get testPost1
    - create testPost1 with diff description
    - verify data

Anticipated Conflicts
-------------------------
1. Users
    - Attempt duplicate Test1
    - Attempt to get non existing user
    - attempt to delete non existing user

2. Group
    - Attempt duplicates testGroup1
    - Attempt to get non existing 
    - attempt to delete non existing group

3. Task
    - Attempt duplicates testTask1
    - Attempt to get non existing 
    - attempt to delete non existing task

4. Post
    - Attempt duplicates testPost1
    - Attempt to get non existing 
    - attempt to delete non existing post

Test2
=======================

Object Creation
----------------------
1. Users
    - Create Test2

Security 
-------------------------
1. Users
    - User2 attempts to edit User1
    - Verify data

2. Groups (no group permissions)
    - User2 attempts to edit testGroup1
    - User2 attempts to put testGroup1
    - User2 attempts to delete testGroup1
    - User2 attempts to resetManager of testGroup1 to User2
    - User2 attempts to addManager to testGroup1 
    - User2 attempts to deleteManager Test1 from testGroup1
    - verify data

3. Tasks (no group permissions, no task permissions)
    - User2 attempts to edit testTask1
    - User2 attempts to put testTask1
    - User2 attempts to delete testTask1
    - User2 attempts to resetManager of testTask1 to User2
    - User2 attempts to addManager to testTask1 
    - User2 attempts to deleteManager Test1 from testTask1
    - verify data

4. Posts (no group permissions, no post permissions)
    - User2 attempts to create testPost2 from testGroup1
    - User2 attempts to edit testPost1
    - User2 attempts to put testPost1
    - User2 attempts to delete testPost1
    - verify data

Test3
===========================
_Todo_


Test4
===========================
_Todo_