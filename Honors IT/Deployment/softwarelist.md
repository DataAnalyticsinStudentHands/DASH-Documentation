The Honors College requires certain software packaged on its client computers to ensure the college runs smoothly. There are three classes of users in the Honors College, each with their own lists of packages. All packages will be imported into Munki for distribution, but certain software may require some work to create a distributable package (see [Software Packaging Guide](https://honorscollege.freshservice.com/solution/categories/1000023134/folders/1000035508/articles/1000015667-software-packaging-guide)).

Classes are determined and assigned by computer. For example, the computers in SSO will be imaged and configured as "advisor" computers, but if someone who works in SSO were to login in the computer lab, they would only be able to access software available to all lab users, since computers in the Honors computer lab are configured as "Lab Computer".

In addition to software packages, each class has different restrictions and login scripts that can be installed via packages.

## Advidsor

Advisors are any employee of the Honors College that requires access to student data on a regular basis, this includes actual HC advising staff, as well as Recruitment and Student Services student workers.

### Computer Configuration
These users will be administrators of the computers they commonly use. For exapmle, SSO will have administrator rights on all of the SSO computers, but advisors will only administrator rights on the computer in their office.

## Faculty & Staff

Faculty & Staff are University employees and student workers who do not require access to student data.

### Computer Configuration
These users will be administrators of the computers they commonly use.

## Lab Computers

These computers are for general purpose computing, and will be accessed by many people.

### Computer Configuration
- These users will **not** be administrators.
- Papercut is configured to start at login using a LaunchAgent, and cannot be exited.
- These computers will be connected to the Lab Printers.

## Classroom Computers & Consulting Offices

These computers are for general purpose computing, and will be accessed by many people.

# Manifests

Here we illustrate how the software lists and classes are managed in Munki. We have a hierarchy of manifests that controlled what software and scripts are installed on the different classes of computers.

<div style="width: 480px; height: 360px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://www.lucidchart.com/documents/embeddedchart/28cc149b-ad34-4479-b628-2c8b098de765" id="30qdae92R_YY"></iframe></div>

| allcomputers                    |                                |                                   |         |           |                      |            |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| AdobeAir (19.0.0.213)           |                                | Android File Transfer (1.0)       |         | available |                      |            |
| AdobeFlashPlayer (20.0.0.306)   |                                | Cyberduck (4.8.3)                 |         |           |                      |            |
| EasyFind (4.9.3)                |                                | Dropbox (3.14.7)                  |         |           |                      |            |
| GoogleChrome (49.0.2623.75)     |                                | Firefox (44.0.2)                  |         |           |                      |            |
| munkireport (2.5.3)             |                                | GoogleDrive (1.28.1549.1322)      |         |           |                      |            |
| muniktools (4.1.2627)           |                                | Skype (7.21.0.350)                |         |           |                      |            |
| munkitools_core (2.5.1.2627)    |                                | TeamViewerQS (11.0.55321)         |         |           |                      |            |
| munkitools_launchd (2.0.0.1969) |                                | VLC (2.2.2)                       |         |           |                      |            |
| Office Installer (14.3.0)       |                                |                                   |         |           |                      ||            |              

| labcomputer                     |                                |                                   |         |           |                      |            |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| guestaccount.mobileconfig (1.0) |                                | Atom (1.2.4)                      |         | available | allcomputers         |            |
| labprinters.mobileconfig (1.0)  |                                | Spotify (1.0.24.104.g92a22684)    |         |           |                      |            |
| MATLAB_R2015b (8.5.0)           |                                |                                   |         |           |                      |            |
| PaperCut Client (13.5)          |                                |                                   |         |           |                      |            |
| Sublime Text 3 (3103)           |                                |                                   |         |           |                     | |            |

| bonnerlabcomputer               |                                |                                   |         |           |                      |            |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| gardensxerox.mobileconfig (1.0) | labprinters.mobileconfig (1.0) | Atom (1.2.4)                      |         | available | allcomputers         |            |
| Sublime Text 3 (3103)           | PaperCut Client (13.5)         | Spotify (1.0.24.104.g92a22684)    |         |           |                      ||            |

| consultingcomputer              |                          |                                   |         |           |                      |            |
|---------------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| Adobe Reader (11.0.10)          |                          |                                   |         | available | allcomputers         |            |
| guestaccount.mobileconfig (1.0) |                          |                                   |         |           |                      ||            |

| facultystaffcomputer                         |                          |                                                   |         |           |                      |            |
|----------------------------------------------|--------------------------|---------------------------------------------------|---------|-----------|----------------------|------------|
| Installs                                     | Uninstalls               | Optional Installs                                 | Updates | Catalogs  | Included Manifests   | Conditions |
| Acrobat XI (11.0.0)                          |                          | 204podprinter.mobileconfig (1.0)                  |         | available | allcomputers         |            |
| Login_to_NAS_Honors_Share.mobileconfig (1.0) |                          | 205podprinter.mobileconfig (1.0)                  |         |           |                      |            |
| loginuhsa1.mobileconfig (1.0)                |                          | 206podprinter.mobileconfig (1.0)                  |         |           |                      |            |
| Spotify (1.0.24.104.g92a22684)               |                          | 212GCommunicationsColorPrinter.mobileconfig (1.0) |         |           |                      |            |
| SSD Fan Control (2.0)                        |                          | AdobeIndesignCS6 (8.0)                            |         |           |                      |            |
| Sublime Text 3 (3103)                        |                          | Atom (1.2.4)                                      |         |           |                      |            |
|                                              |                          | copystoragexerox.mobileconfig (1.0)               |         |           |                      |            |
|                                              |                          | CreativeSuite6DesignStandard (6)                  |         |           |                      |            |
|                                              |                          | deansareahp.mobileconfig (1.0)                    |         |           |                      |            |
|                                              |                          | deansareaxerox.mobileconfig (1.0)                 |         |           |                      |            |
|                                              |                          | gardensxerox.mobileconfig (1.0)                   |         |           |                      |            |
|                                              |                          | iWork09 (4.0)                                     |         |           |                      |            |
|                                              |                          | recruitementprinter.mobileconfig (1.0)            |         |           |                      |            |
|                                              |                          | Spotify (1.0.24.104.g92a22684)                    |         |           |                      |            |
|                                              |                          | ssoprinter.mobileconfig (1.0)                     |         |           |                      |            |
|                                              |                          | TeamViewerQS (11.0.55321)                         |         |           |                      |            |
|                                              |                          | xeroxphasercolor.mobileconfig (1.0)               |         |           |                      | |           |

| advisorcomputer                |                          |                                         |         |           |                      |            |
|--------------------------------|--------------------------|-----------------------------------------|---------|-----------|----------------------|------------|
| Installs                       | Uninstalls               | Optional Installs                       | Updates | Catalogs  | Included Manifests   | Conditions |
| FileMakerPro14ARD (0.0)        | FilmMaker Pro 12 (12.0)  | CreativeSuite6DesignStandard (6)        |         | available | facultystaffcomputer |            |
|                                |                          | ssoprinter.mobileconfig (1.0)           |         |           |                      |            ||

| admincomputer                |                          |                                         |         |           |                      |            |
|------------------------------|--------------------------|-----------------------------------------|---------|-----------|----------------------|------------|
| Installs                     | Uninstalls               | Optional Installs                       | Updates | Catalogs  | Included Manifests   | Conditions |
| AutoDMG (1.5.5)              |                          | 3T MongoChef (3.2.3)                    |         | available | facultystaffcomputer |            |
| CreateUserPkg (1.2.4)        |                          | Microsoft Remote Desktop Beta (8.2.18)  |         |           |                      |            |
| DeployStudioAdmin (1.6.15)   |                          | screenlockgatekeeper.mobileconfig (1.0) |         |           |                      |            |
| MunkiAdmin (1.4.1)           |                          |                                         |         |           |                      |            |
| munkitools_admin (2.5.1.2627)|                          |                                         |         |           |                      |           | |

Note: Astericks (*) indicates that the package is imported into Munki via AutoUpdater. All other packages are imported manually.
