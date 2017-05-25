# How to Customize the Munkireport Web Interface
Customization centers around a single file, `config.php`. General information here: https://github.com/munkireport/munkireport-php/wiki/Server-Configuration

1. Become the admin and ssh into curly
2. Go to the munkireport subdirectory in the OS X server: `cd /Library/Server/Web/Data/Sites/Default/reporting`
3. Run `ls` and note that you see a `config_default.php` and a `config.php`
   * The first contains all possible settings at their default values with descriptions, the second contains only your changes to the defaults. Do not edit `config_default.php`
4. Run `nano config.php` to edit it in terminal. Note the commands at the bottom of the window, where `^X` is 'control+x'
5. Edit `config.php` as per the instructions below, exit `nano` and save changes with *control+x*, then *y*, then *return*
   * If there is a typo in `config.php`, munkireport will not load
6. Create a new package and deploy it via Munki to distribute new settings

## Choosing Modules
Each module tells the client to supply a particular set of data. Some modules require third party software. You should consider a module as a self contained unit that is responsible for collecting data, processing data and storing data in the database. Most, but not all modules translate direcly into one of the items on the *Listings* drop-down menu of munkireport. For more information and a complete list of all possible modules: https://github.com/munkireport/munkireport-php/wiki/Modules

1. Find `$conf['modules']`
2. Add or remove modules as desired
   * **_Module data will not appear until a new package is created and installed on clients_**

## Customizing the Dashboard
Each box on the dashboard of munkireport is a widget. For a complete list of all possible widgets, look in `config_default.php` or on https://github.com/munkireport/munkireport-php/blob/master/config_default.php.

1. Find `$conf['dashboard_layout']` and note it is an array of arrays of widgets
   * Each inner array is a row on the dashboard. It can be written as a single array, but then widgets would just go wherever they fit and it would look messy
2. Simply add or remove widgets as desired. When `config.php` is saved, reload munkireport and you will see your new configuration
   * Widgets will appear and disappear immediately upon saving `config.php`, but will either throw a "not found" error or not be populated with data unless there is a distributed munkireport package that tells clients to supply that particular data
   * **_Widgets do not tell clients to supply data, only modules do. Widgets simply display the data collected by modules_**
   
## Customizing the App Versions Report
This report is similar to the dashboard, but instead of widgets we are listing applications.

1. Find `$conf['apps_to_track']` and note it is an array of application names
   * This can be written as an array of arrays like the dashboard, but this is not necessary
2. Simply add or remove applications as desired. When `config.php` is saved, reload munkireport and you will see your new configuration
   * Applications will appear and disappear immediately upon saving, but will not be filled with data if there are no active modules that collect app version data
   * **_Application names are case sensitive and must be listed exactly as they appear under Listings->Inventory in munkireport_**
