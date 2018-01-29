## Meteor Setup on Server

This is an example of how it was installed on can.hnet.uh.edu

### Git

`sudo yum install git`

### NodeJS

Followed instructions on NodeJS [website](https://nodejs.org/en/download/package-manager/#enterprise-linux-and-fedora).

Since the fibers package doesn't run on 6.5, we need an older version of node.

Installed [n](https://github.com/tj/n) for Node version management

`sudo npm install -g n`

Change Node version, e.g.

`sudo n 4.2.4`

### MongoDB

Followed instructions on MongoDB [website](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/)

Setup authentication according to MongoDB [website](https://docs.mongodb.com/manual/security/).

### Meteor

`curl https://install.meteor.com/ | sh`

Depending on whether the command had been run (as root or not) you may have to set the environment according to instructions from the install script.

### PM2 & pm2-logrotate

Following instructions at the PM2 [website](http://pm2.keymetrics.io/).
`sudo npm install pm2 -g`

`pm2 install pm2-logrotate`
