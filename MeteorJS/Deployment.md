## Deploying to hnetdev.hnet.uh.edu

We are running our Meteor applications on our own infrastructure. Our servers provide Node.js 0.10 and a MongoDB server. (The current release of Meteor has been tested with Node 0.10.36.)

While you are on hnetdev.hnet.uh.edu, run

```meteor build my_directory```

This command will generate a fully-contained Node.js application in the form of a tarball.  You can then run the application by invoking node, specifying the HTTP port for the application to listen on, and the MongoDB endpoint.

```cd my_directory
(cd programs/server && npm install)
    env PORT=3000 MONGO_URL=mongodb://localhost:27017/myapp node main.js```

Some packages might require other environment variables. For example, the email package requires a `MAIL_URL` environment variable.
