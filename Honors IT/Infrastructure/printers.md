There are several different printers at the Honors College, but they're all HP Printers or Sharp Copiers. Printers are now a self-service operation, managed through Munki. Settings for each printer are created in Profile Manager, and deployed through Munki. Each printer has a static IP address to remove it from the DHCP Pool.

## Setup
All the printers have a web interface that can be reached via IP address. The login for the Xerox machines is admin (1111). They are configured to send alert emails to honorsit@central.uh.edu and other (e.g. Brenda Ramirez for supplies).

## Supplies
We keep supplies for printers close to the locations of the printers. But most of our stock is in Brenda Ramirez' office. Most of the printers are sending emails to Brenda Ramirez. If you notice something is missing, please get in contact with her.

When the part comes in, install it and return the empty cartridge to Brenda. We are recycling printer supplies.

## Installing a Printer on Mac

* Open Managed Software Center located in ```Applications``` -> ```Utilities```
* Select **Install** for the desired printer

## Installing a Printer on PC

* Acquire the appropriate driver from the Internet or elsewhere
* Run the installer. It will vary based on wizard but you need to set it up with the IP address of the desired printer
  * If you are installing the Copy/Storage Sharp, then after installation go to Devices and Printers (search for it)
  * Right click on the Sharp device, click printer properties, go to color management
  * Make sure the Sharp is selected, select Manual, add the Black & White profile, set it as default, remove the RGB one

## Installing and Configuring CopyStorage Sharp Printer without using ManagedSoftware
 
The CopyStorage Sharp printer will accept print jobs from computers connected to the UH network without requiring authentication so long as those computers' print drivers are set to default to black and white printing only. Here's how to do that:

On Mac:

* Download and install the proper driver for the printer add the printer to the computer (use LPD protocol).
* Open internet browser
* Type: http://localhost:631/ (this is the CUPS interface)
* Click on "Printers" then Select the Sharp MX-6070N (Copy Storage Sharp) printer
* Check both of the drop down menus and look for the "Select Default Options" menu then select it
* Select "Color" then Set "Color Mode" to "Black and White"
* At the bottom of the page, click on the "Set Default Options" button
* Enter a username and password for an account that has administrator privileges on the computer you are configuring. Once that's done, the browser should load a page that says the settings for the printer were successfully applied.
       
On Windows:

* Download and install the proper driver for the printer then add the printer to the computer (use LPD protocol).
* Open printer settings
* Find the settings for the CopyStorage Sharp printer driver > Make sure the printer is set to print in black and white by default.

## Removing a Printer from Mac

* Open Managed Software Center
* Select **Remove** for the desired printer

## Removing a Printer from PC

* Go to Devices and Printers (search for it)
* Right click the printer to be removed, click remove, enter admin password if necessary

## Contact info for Sharp Printer Support
Skelton Business  
Collin Grimes  
cgrimes@sbesharp.com  
(281)-226-3412  
equipmybiz.com  


## Printer Listings


| Printer Name    | IP Address   | DNS Name                  | Model Number  |
|-----------------|--------------|---------------------------|---------------|
| SSO Printer     | https://172.27.56.11/ | printer01.honors.e.uh.edu | HP 600 Series |
| 206 Pod Printer | https://172.27.56.12/ | printer02.honors.e.uh.edu | HP 600 Series |
| 205 Pod Printer | https://172.27.56.13/ | printer03.honors.e.uh.edu | HP 600 Series |
| 204 Pod Printer | 172.27.56.14 | printer04.honors.e.uh.edu | HP 4250 Series|
| Dean's Area HP  | http://172.27.56.15/ | printer05.honors.e.uh.edu | HP 4200 Series|
| Asst. Dean's Printer | 172.27.56.16 | printer06.honors.e.uh.edu | HP 4050 Series w/ 3rd Tray |
| BJR Printer	| 172.27.56.17 | printer07.honors.e.uh.edu | HP P2055 Series |
| Recruitment Printer | http://172.27.56.18/ | printer08.honors.e.uh.edu | HP P2055 Series |
| Little Printer | 172.27.56.19 | printer09.honors.e.uh.edu | HP P2055 Series w/ 3rd Tray |
| Lab Printer 1 | https://172.27.56.20/ | printer10.honors.e.uh.edu | HP 600 Series w/ Duplexer and 3rd Tray |
| Lab Printer 2 | https://172.27.56.21/ | printer11.honors.e.uh.edu | HP 600 Series w/ Duplexer and 3rd Tray |
| Color Printer | http://172.27.56.22/ | printer12.honors.e.uh.edu | Xerox Phaser 7400DN |
| Business Office Printer in 207B | http://172.27.56.23/ | printer13.honors.e.uh.edu | HP LaserJet M402dn |
| Communications Office Color Printer in 212G | http://172.27.56.24/ | printer14.honors.e.uh.edu | HP LaserJet Pro M452dn |
| Business Office Printer in 207A | http://172.27.56.25/ | printer15.honors.e.uh.edu | HP LaserJet M402dn |


## Copier Listings


| Printer Name    | IP Address   | DNS Name                  | Model Number  |
|-----------------|--------------|---------------------------|---------------|
| Copy Storage Sharp| https://172.27.56.7/ | copier01.honors.e.uh.edu | SHARP MX-6070N |
| Dean's Area Xerox | http://172.27.56.8/ | copier02.honors.e.uh.edu | Xerox WorkCentre 3615 |
| South Gardens Sharp | http://172.27.219.1/ | 584-s15-sgwc-prntr.honors.e.uh.edu | SHARP MX-M654N |
| Speech/Debate Xerox | http://172.27.159.207/ |  | Xerox WorkCenter 4250 |

