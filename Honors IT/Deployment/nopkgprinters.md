##nopkg Installation of Printer Settings

A nopkg installation allows us to push a just a script to the client, without a corresponding payload. For the printers, this script is installing the printer settings via a nopkg installation. The nopkg installer package is dependent on the respective printer driver package being installed, which insures that the settings are only applied to clients who already have the driver installed. If the driver isn't found, the dependency first installs the driver and then the nopkg settings.

##Creating a nopkg Package Using printer-pkginfo

All of the relevant documentation on creating the nopkg package is available [here](https://github.com/munki/munki/wiki/Managing-Printers-With-Munki). I'll attempt to create a TL;DR version here, but see the aforementioned docs if you have more questions.

To create the nopkg package, we'll need to use the [printer-pkginfo script created by Graham Gilbert.](https://github.com/grahamgilbert/printer-pkginfo). In this documentation, we'll be using the included example-hp4100.plist file as our template.

Most of the fields are fairly self-explanatory, but I'll go through them anyways:

| address         | IP address of the printer.                                                                                                                                                                                                                                                               |
|-----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| default_catalog | The munki catalog that the nopkg settings file will go in. Should be testing.                                                                                                                                                                                                        |
| display_name    | The name that is displayed in Managed Software Center.                                                                                                                                                                                                                                   |
| location        | The physical location of the device.                                                                                                                                                                                                                                                     |
| name            | The name that is displayed in munkiAdmin.                                                                                                                                                                                                                                                |
| options         | This is the tricky part: printer options. For most printers it shouldn't be too hard, but check the CUPS configuration (localhost:631/printers/) for the default options. Otherwise, you'll have to find the printer options via the OSX printer settings or the printer console itself. |
| ppd             | The location of the driver.                                                                                                                                                                                                                                                              |
| queue_name      | The name of the printer in the print queue. This will be the printer name in CUPS.                                                                                                                                                                                                                                              |
| requires        | The package name of the driver in munkiAdmin.                                                                                                                                                                                                                                            |
| version         | The version of the settings file.                                                                                                                                                                                                                                                        |
