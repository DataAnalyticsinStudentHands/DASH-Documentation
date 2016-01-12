Automation
===

Automation is used to handle commonly repeated tasks in frontend development. There are several ways that automation is handled in DASH frontend applications.

- Primarily, via gulpfile.js.
- Secondarily, via hooks.
 
Both methods allow running of commands via Javascript, enabling cross-platform commands to be run via shelljs. However, other commands must be used to enable cross-platform support when the terminal commands differ between MacOS and Windows.

### Gulpfile.js
The sample gulpfile.js provided [here](https://gist.github.com/CarlSteven/39833149163beeb8fd55) has the following common functionality required for DASH frontend development. In order to start using the gulpfile, a `npm install` is generally necessary to install gulp and other necessary npm packages for the gulpfile to function properly.

####Actions:
- `gulp setup`
    This performs common tasks necessary to be executed whenever an application is downloaded or cloned to a local machine from github. General tasks include a bower install.
- `gulp deploy-dev` and `gulp deploy-prod`
    These tasks take advantage of the `clean`, `setup`, and `deploy` tasks in order to set up the repository for pushing to the remote server.
    Afterwards, a dist folder is created in the root of the directory, and all necessary repo files are copied there, this is a temporary repository created to push to the git remote preset at HouSuggest or HnetDev.
    A prerequisite for this step is to first setup a local SSH environment with keys and SSH config properly, first as described [here](../App-Deployment-to-web-server.md).
- `gulp clean`
    Deletes the temporal internal git repository located at `\dist` used to push to the deployment servers.
- `gulp android-setup` and `gulp ios-setup`
    Performs initial setup and Cordova project creation for iOS or Android mobile application testing. Includes building of ionic resources for icon and splash assets.
- `gulp android-build` and `gulp ios-build`
    Performs subsequent builds after the appropriate `setup` task has been run.

### Hooks
- `hooks/before_platform_add/add_plugins.js`
    Performs the addition of plugins when the platform is added. Sample script is [here](https://gist.github.com/CarlSteven/7970206dd16ffe95e5e3)