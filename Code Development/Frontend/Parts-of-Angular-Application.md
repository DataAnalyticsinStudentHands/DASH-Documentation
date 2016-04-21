###App Module
First AngularJS file that is run.

Reason: module defined in this file (i.e. angular.module('xyz')) is included in the ng-app directive in the index.html to cause AngularJS library to start from here.

Config Section

Sets up UI-Router states that the app can navigate to. Each state defines the views and associated controllers to be loaded. Refer to [AngularJS UI-Router Documentation](http://angular-ui.github.io/ui-router/site/#/api/ui.router).

Run Section

Code that is run before the rest of the application is initialized. Used to define authentication and other necessary variables that are needed throughout the application.

###Controllers
All application controllers are in this very large file. Refer to [this](https://docs.angularjs.org/guide/controller) (important read for knowing the purpose of a controller) for more details on AngularJS controllers. Controllers can be loaded via the ng-controller in the HTML (partial) or as defined the UI-Router state definitions.

###Services
All application services are in this very large file. Refer to [this](https://docs.angularjs.org/guide/services) (important read for knowing the purpose of a service) for more details on AngularJS services.

Services are currently being used to a) load data from the JAVA Backend server using the [Restangular (docs)](https://github.com/mgonto/restangular) module and b) process data in before it can be passed to the controllers and used throughout the application.

###Filters
AngularJS filters are located here. [AngularJS filters doc](https://docs.angularjs.org/guide/filter)

###Directives
Application directives here. [guide on directives](https://docs.angularjs.org/guide/directive). We use a ton of directives throughout the HTML that aren't defined here because they are either a part of core Angular or part of another package usually ng-* in the HTML means it's a Angular directive and ui-* means it's a UI-Router directive, but there are many more that are parts of other packages.