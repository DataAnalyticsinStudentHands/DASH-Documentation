#[[WIP]]

##nopkg Installation of Printer Settings

A nopkg installation allows us to push a just a script to the client, without a corresponding payload. For the printers, this script is installing the printer settings via a nopkg installation. The nopkg installer package is dependent on the respective printer driver package being installed, which insures that the settings are only applied to clients who already have the driver installed. If the driver isn't found, the dependency first installs the driver and then the nopkg settings.

##Creating a nopkg Package Using printer-pkginfo

All of the relevant documentation on creating the nopkg package is available [here](https://github.com/munki/munki/wiki/Managing-Printers-With-Munki). I'll attempt to create a TL;DR version here, but see the aforementioned docs if you have more questions.

To create the nopkg package, we'll need to use the [printer-pkginfo script created by Graham Gilbert.](https://github.com/grahamgilbert/printer-pkginfo)
