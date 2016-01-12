Automation
===

Automation is used to handle commonly repeated tasks in frontend development. There are several ways that automation is handled in DASH frontend applications.

- Primarily, via gulpfile.js.
- Secondarily, via hooks.
 
Both methods allow running of commands via Javascript, enabling cross-platform commands to be run via shelljs. However, other commands must be used to enable cross-platform support when the terminal commands differ between MacOS and Windows.