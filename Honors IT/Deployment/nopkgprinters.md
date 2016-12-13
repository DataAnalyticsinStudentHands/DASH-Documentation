## nopkg Installation of Printer Settings

A nopkg installation allows us to push a just a script to the client, without a corresponding payload. Essentially, for each package munki needs a "payload" (i.e. software) to install, and this installation can be modified with scripts via munki. Nopkg allows us to simply forgo the payload and instead just install the script. For the printers, this script is installing the printer settings via a nopkg installation. The nopkg installer package is dependent on the respective printer driver package being installed, which insures that the settings are only applied to clients who already have the driver installed. If the driver isn't found, the dependency first installs the driver and then the nopkg settings.


### Creating a nopkg Package Using printer-pkginfo

All of the relevant documentation on creating the nopkg package is available [here](https://github.com/munki/munki/wiki/Managing-Printers-With-Munki). I'll attempt to create a TL;DR version here, but see the aforementioned docs if you have more questions.


To create the nopkg package, we'll need to use the [printer-pkginfo script created by Graham Gilbert](https://github.com/grahamgilbert/printer-pkginfo). In this documentation, we'll be using the included example-hp4100.plist file as our template.


Most of the fields are fairly self-explanatory, but I'll go through them anyways:

| Field         | Description                                                                                                                                                                                                                                                              |
|-----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| address         | IP address of the printer.
| default_catalog | The munki catalog that the nopkg settings file will go in. Should be testing.                                                                                                                                                                                                        |
| display_name    | The name that is displayed in Managed Software Center.                                                                                                                                                                                                                                   |
| location        | The physical location of the device.                                                                                                                                                                                                                                                     |
| name            | The name that is displayed in munkiAdmin. For the sake of consistency, it should be "Settings for *[printer-name]*"                                                                                                                                                                                                                                                |
| options         | This is the tricky part: printer options. For most printers it shouldn't be too hard, but check the CUPS configuration (localhost:631/printers/) for the default options. Otherwise, you'll have to find the printer options via the OSX printer settings or the printer console itself. |
| ppd             | The location of the driver.                                                                                                                                                                                                                                                              |
| queue_name      | The name of the printer in the print queue. This will be the printer name in CUPS.                                                                                                                                                                                                                                              |
| requires        | The package name of the driver in munkiAdmin. This field establishes the dependency of the settings file on the driver already being installed.                                                                                                                                                                                                                                            |
| version         | The version of the settings file.                                                                                                                                                                                                                                                        |

You'll need to change each field to match the printer. For example, here's the example-hp4100.plist converted to copystorage_sharpmx6070n.plist:



Remember to name the input plist file as *[printer-location]_[printername]*.plist to keep the scripts nicely organized.


Once you've replaced the fields in the input file, you'll have to run the printer-pkginfo tool. Open the terminal and use the following command:

    ./printer-pkginfo --plist /path/to/inputfile.plist --> /path/to/outputfile.plist    

The inputfile.plist will be the file you've just created and the outputfile.plist will be the nopkg installer that the tool will generate. Name the outputfile.plist as *[printer-location][printer-manufacturer]-v[version-number]*.plist.

For example, using the *copystorage_sharpmx6070n.plist* input file and assuming that the terminal is already pointed to the folder, we would run the following command:

    ./printer-pkginfo --plist copystorage_sharpmx6070n --> copystorageSharpv1.0.plist


Once the output file is generated, drop it in to /web/munki/pkgsinfo/printers on the hc-storage drive. Refresh the packages in munkiAdmin and change the new settings package icon (it should be named "Settings for *[printer-name]*") to match the respective printer. Double check to make sure the package is in the testing catalog and then test it by installing it on an hc-admin computer using Managed Software Center. The printer should show up in the OSX printer settings after installation--test to see if the printer configuration works by printing a test page. Once the printer works, add it to the following table to keep track of which printers are on the new nopkg configuration:


| Printer            | Configuration plists                                          |
|--------------------|---------------------------------------------------------------|
| Copy Storage Sharp | copystorageSharpv1.0.plist, copystorageSharpv-colorv1.0.plist |
| Gardens Sharp      | gardensSharpv1.0.plist                                        |
