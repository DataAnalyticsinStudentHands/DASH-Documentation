FormBuilder Modules
===

FormBuilder has several inter-dependent modules that comprise of the whole application. Various modules can be separated to perform specific roles. Each module should declare its own dependencies and be able to function on its own.

### Modules

#### Core
The core modules contains dependencies to all modules/features that are included as a part of the application. Each derivative application created from FormBuilder will have its own core module that contains the main module that is bootstrapped by the `ng-app` statement. 

#### Components
The components module contains the Form components as described [here](../FormBuilder-Component.md). Additional components shall be defined here.

#### FormBuilder
The FormBuilder module is the main module that facilitates the creation and editing of a form.

#### FormData
This module manages data transmission to and from the backend server regarding form data.

#### FromResponder
This module allows users to respond to forms.

#### FormResponseViewer
This module displays a response viewer table of all responses to a form. Additionally, facilitates the creation of PDF/CSV export of form responses.

#### FormUtil
The FormUtil contains miscellaneous directives and filters that are not separated to a specific module to minimize code duplication.

#### Home
The home module facilitates the display of all forms that an use has access to.

#### Login
The login module contains user registration and login functionality.

#### ResponseData
The Response Data module manages the data transmission to and from the backend server regarding form response data.

#### Study
The Study module creates and manages form studies.

#### User Response Viewer
The user response viewer module allows for users to view a form that an user has filled out in read-only format.