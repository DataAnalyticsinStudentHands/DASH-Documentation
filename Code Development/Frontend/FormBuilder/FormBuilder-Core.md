Modifying FormBuilder Core Module
=

The FormBuilder core files are located in FormBuilder at `/www/module/formbuilder/` the file structure within is described below.
 
### File Structure
#### src
Located within this folder are coffee script files which are compiled into `*.js` and `*.js.map` files. DO NOT in any circumstance modify `*.js.*` files as those changes will be immediately overwritten when the `*.coffee` files are compiled.

In order to compile CoffeeScript files, you must run `npm install -g coffee-script` to install the coffeescript compiler. The easiest way to compile after installing is to open up the project in [WebStorm](https://www.jetbrains.com/webstorm/) (obtain a free EDU license [here](https://www.jetbrains.com/student/)), open a `*.coffee` file and allow the automatic watcher to detect the coffee binaries and do the compilation automatically. NOTE: You may also use the command line coffee compile tool, but has never been done successfully.

##### controller.coffee
Contains all the controllers for FormBuilder. Includes the form controller, popover controller, form component editable and non-editable controllers. This is one of the most common files that you will edit.

Logic on how form is generated, form is processed, etc is located here.

##### directive.coffee
Contains FormBuilder directives. Usually will not need to be modified. This does link-in the controllers.

##### drag.coffee
Contains logic for the drag and drop functionality in the form builder portion.

##### module.coffee
Module definition. Most likely will not need to be modified.

##### provider.coffee
'Provides' the builder. Most likely will not need to be modified.

####components
In this folder are the default FormBuilder components as described [here](../FormBuilder-Component.md)