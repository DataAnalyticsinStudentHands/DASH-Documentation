The Honors College requires certain software packaged on its client computers to ensure the college runs smoothly. There are a couple user classes in the Honors College, each with their own lists of packages. All packages will be imported into Munki for distribution, but certain software may require some work to create a distributable package (see [Software Packaging Guide](https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000015667-software-packaging-guide)).

Classes are determined and assigned by computer. For example, the computers in SSO will be imaged and configured as "advisorcomputer", but if someone who works in SSO were to login in the computer lab, they would only be able to access software available to all lab users, since computers in the Honors computer lab are configured as "labcomputer".

In addition to software packages, each class has different restrictions and login scripts that are installed via packages.

## Manifests

Here we illustrate how the software lists and classes are managed in Munki. We have a hierarchy of manifests which controls what software and scripts are installed on the different classes of computers.

<div style="width: 480px; height: 360px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://www.lucidchart.com/documents/embeddedchart/28cc149b-ad34-4479-b628-2c8b098de765" id="30qdae92R_YY"></iframe></div>

We are using a "base" manifest which looks like follows:

### allcomputers

| Managed Installs                  | Managed Uninstalls             | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|-----------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| AdobeAir (21.0)*                  |                                | Android File Transfer (1.0)       |         | available |                      |            |
| AdobeFlashPlayer (21.0.0.213)*    |                                | Cyberduck (4.9)*                 |         |           |                      |            |
| EasyFind (4.9.3)                  |                                | Dropbox (3.16.1)*                |         |           |                      |            |
| GoogleChrome (1.29.1861.9751) *   |                                | Firefox (45.0.1)*                |         |           |                      |            |
| munkireport (2.5.3)*              |                                | GoogleDrive (1.29.1861.9751)*    |         |           |                      |            |
| muniktools (4.2.2679)*            |                                | Skype (7.25.0.356)*              |         |           |                      |            |
| munkitools_core (2.6.1.2684)*     |                                | TeamViewerQS (11.0.55321)*       |         |           |                      |            |
| munkitools_launchd (2.0.0.1969)*  |                                | VLC (2.2.2)*                     |         |           |                      |            |
| Office Installer (14.3.0)*        |                                |                                   |         |           |                      |           |            
## Computer Classes

The following is a description of the existing computer classes and the according manifest as they are implemented.

### Admin
Computers used by HonorsIT.

| Installs                        | Uninstalls               | Optional Installs                        | Updates | Catalogs  | Included Manifests   | Conditions |
|---------------------------------|--------------------------|------------------------------------------|---------|-----------|----------------------|------------|
| AutoDMG (1.5.5) *               |                          | 3T MongoChef (3.4.1)                     |         | available | facultystaffcomputer |            |
| CreateUserPkg (1.2.4)           |                          | Microsoft Remote Desktop Beta (8.2.18) * |         |           |                      |            |
| DeployStudioAdmin (1.6.15) *    |                          | screenlockgatekeeper.mobileconfig (1.0)  |         |           |                      |            |
| MunkiAdmin (1.4.2) *            |                          |                                          |         |           |                      |            |
| munkitools_admin (2.7.0) * |                          |                                          |         |           |                      |           | |


### Faculty & Staff

Faculty & Staff are University employees and student workers who do not require access to student data.
#### Computer Configuration
- Automatic login to UHSHA1 (HCShare)
- Automatic login to hc-storage (HonorsShare)
- Printers can be installed via ManagedSoftware

### Advisor

Advisors are any employees of the Honors College that require access to student data on a regular basis, this includes actual HC advising staff, as well as Recruitment and Student Services student workers.

### Lab Computers

These computers are for general purpose computing, and will be accessed by many people.

#### Computer Configuration
- Papercut is configured to start at login using a LaunchAgent, and cannot be exited.
- These computers will be connected to the Lab Printers.

| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| guestaccount.mobileconfig (1.0) |                                | Atom (1.6.0)*                    |         | available | allcomputers         |            |
| labprinters.mobileconfig (1.0)  |                                | Spotify (1.0.26.132.ga4e3ccee)*  |         |           |                      |            |
| MATLAB_R2015b (8.5.0)           |                                |                                   |         |           |                      |            |
| PaperCut Client (13.5)          |                                |                                   |         |           |                      |            |
| Sublime Text 3 (3103)*         |                                |                                   |         |           |                     | |            |

### Bonner Lab Computers

These computers are for general purpose computing, and will be accessed by people in the Bonner Base area in the Honors Gardens.

#### Computer Configuration
- These computers will be connected to the Xerox Printer in the Honors Garden Area.

| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| guestaccount.mobileconfig (1.0) |                                |                                   |         | available |   allcomputers       |            |
| gardensxerox.mobileconfig (1.0) |                                | Atom (1.6.0) *                    |         |           |                      |            |
| Sublime Text 3 (3103) *         |                                | Spotify (1.0.26.132.ga4e3ccee) *  |         |           |                      |            |


### DASH Lab Computers

These computers are for general purpose computing, and will be accessed by people in the DASH area in the Honors Gardens.

#### Computer Configuration
- These computers will be connected to the Xerox Printer in the Honors Garden Area.

| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| SourceTree (2.2.4) |                                |                                   |         | available |   bonnerlabcomputer  |            |
| gardensxerox.mobileconfig (1.0) |                                | Atom (1.6.0) *                    |         |           |                      |            |
| Sublime Text 3 (3103) *         |                                | Spotify (1.0.26.132.ga4e3ccee) *  |         |           |                      |            |

### Classroom Computers & Consulting Offices

These computers are for general purpose computing, and will be accessed by many people.






| consultingcomputer              |                          |                                   |         |           |                      |            |
|---------------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| Adobe Reader (11.0.10) *        |                          |                                   |         | available | allcomputers         |            |
| guestaccount.mobileconfig (1.0) |                          |                                   |         |           |                      ||            |

| facultystaffcomputer                         |                          |                                                   |                                  |           |                      |            |
|----------------------------------------------|--------------------------|---------------------------------------------------|----------------------------------|-----------|----------------------|------------|
| Installs                                     | Uninstalls               | Optional Installs                                 | Updates                          | Catalogs  | Included Manifests   | Conditions |
| Acrobat XI (11.0.15)                         |                          | 204podprinter.mobileconfig (1.0)                  | Acrobat Update 11.0.14 (11.0.14) | available | allcomputers         |            |
| Login_to_NAS_Honors_Share.mobileconfig (1.0) |                          | 205podprinter.mobileconfig (1.0)                  |                                  |           |                      |            |
| loginuhsa1.mobileconfig (1.0)                |                          | 206podprinter.mobileconfig (1.0)                  |                                  |           |                      |            |
| Spotify (1.0.26.132.ga4e3ccee) *             |                          | 212GCommunicationsColorPrinter.mobileconfig (1.0) |                                  |           |                      |            |
| SSD Fan Control (2.0)                        |                          | AdobeIndesignCS6 (8.0)                            |                                  |           |                      |            |
| Sublime Text 3 (3103) *                      |                          | Atom (1.6.0) *                                    |                                  |           |                      |            |
|                                              |                          | copystoragexerox.mobileconfig (1.0)               |                                  |           |                      |            |
|                                              |                          | CreativeSuite6DesignStandard (6)                  |                                  |           |                      |            |
|                                              |                          | deansareahp.mobileconfig (1.0)                    |                                  |           |                      |            |
|                                              |                          | deansareaxerox.mobileconfig (1.0)                 |                                  |           |                      |            |
|                                              |                          | gardensxerox.mobileconfig (1.0)                   |                                  |           |                      |            |
|                                              |                          | iWork09 (4.0)                                     |                                  |           |                      |            |
|                                              |                          | recruitementprinter.mobileconfig (1.0)            |                                  |           |                      |            |
|                                              |                          | Spotify (1.0.26.132.ga4e3ccee) *                  |                                  |           |                      |            |
|                                              |                          | ssoprinter.mobileconfig (1.0)                     |                                  |           |                      |            |
|                                              |                          | TeamViewerQS (11.0.55321) *                       |                                  |           |                      |            |
|                                              |                          | xeroxphasercolor.mobileconfig (1.0)               |                                  |           |                      | |           |

| advisorcomputer                |                          |                                         |         |           |                      |            |
|--------------------------------|--------------------------|-----------------------------------------|---------|-----------|----------------------|------------|
| Installs                       | Uninstalls               | Optional Installs                       | Updates | Catalogs  | Included Manifests   | Conditions |
| FileMakerPro14ARD (0.0)        | FilmMaker Pro 12 (12.0)  | CreativeSuite6DesignStandard (6)        |         | available | facultystaffcomputer |            |
|                                |                          | ssoprinter.mobileconfig (1.0)           |         |           |                      |            ||


Note: Astericks (*) indicates that the package is imported into Munki via AutoUpdater. All other packages are imported manually.
