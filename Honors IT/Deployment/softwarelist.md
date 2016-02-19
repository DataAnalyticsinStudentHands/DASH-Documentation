## Honors College User/Computer Classes and Munki

The Honors College requires certain software packaged on its client computers to ensure the college runs smoothly. There are three classes of users in the Honors College, each with their own lists of packages. All packages will be imported into Munki for distribution, but certain software may require some work to create a distributable package.

Classes are determined and assigned by computer. For example, the computers in SSO will be imaged and configured as "advisor" computers, but if someone who works in SSO were to login in the computer lab, they would only be able to access software available to all lab users, since computer in there are configured as "Lab Computer".

In addition to software, each class has different restrictions and login scripts.

### Advidsor

Advisors are any employee of the Honors College that requires access to student data on a regular basis, this includes actual HC advising staff, as well as Recruitment and Student Services student workers.

#### Computer Configuration
These users will be administrators of the computers they commonly use. For exapmle, SSO will have administrator rights on all of the SSO computers, but advisors will only administrator rights on the computer in their office.

### Faculty & Staff

Faculty & Staff are University employees and student workers who do not require access to student data.

#### Computer Configuration
These users will be administrators of the computers they commonly use.

### Lab Computers

These computers are for general purpose computing, and will be accessed by many people.

#### Computer Configuration
- These users will **not** be administrators.
- Papercut is configured to start at login using a LaunchAgent, and cannot be exited.
- These computers will be connected to the Lab Printers.

### Classroom Computers & Consulting Offices

These computers are for general purpose computing, and will be accessed by many people.

## Manifests

Here we illustrate how the software lists and classes are managed in Munki. We have a hierarchy of manifests that controlled what software and scripts are installed on the different classes of computers.

<div style="width: 480px; height: 360px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://www.lucidchart.com/documents/embeddedchart/28cc149b-ad34-4479-b628-2c8b098de765" id="30qdae92R_YY"></iframe></div>

| allcomputers                    |                                |                                   |         |           |                      |            |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| AdobeAir (19.0.0.213)           |                                | Dropbox (3.12.5)                  |         | available |                      |            |
| AdobeFlashPlayer (20.0.0.306)   |                                | Firefox (40.0.3)                  |         |           |                      |            |
| EasyFind (4.9.3)                |                                | Skype (7.10.0.777)                |         |           |                      |            |
| GoogleChrome (47.0.2526.80)     |                                | VLC (2.2.1)                       |         |           |                      |            |
| muniktools (4.0.2413)           |                                |                                   |         |           |                      |            |
| munkitools_core (2.2.4.2431)    |                                |                                   |         |           |                      |            |
| munkitools_launchd (2.0.0.1969) |                                |                                   |         |           |                      |            |
| Office Installer (14.3.0)       |                                |                                   |         |           |                      |            |
| Silverlight (5.1.40416.0)       |                                |                                   |         |           |                      |            |

| labcomputer                     |                                |                                   |         |           |                      |            |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| guestaccount.mobileconfig (1.0) |                                | Atom (1.2.4)                      |         | available | allcomputers         |            |
| labprinters.mobileconfig (1.0)  |                                | Spotify (1.0.10.107.gd0dfca3a)    |         |           |                      |            |
| PaperCut Client (13.5)          |                                |                                   |         |           |                      |            |
| Sublime Text 3 (3065)           |                                |                                   |         |           |                      |            |

| bonnerlabcomputer               |                                |                                   |         |           |                      |            |
|---------------------------------|--------------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls                     | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| guestaccount.mobileconfig (1.0) | labprinters.mobileconfig (1.0) | Atom (1.2.4)                      |         | available | allcomputers         |            |
| gardensxerox.mobileconfig (1.0) | PaperCut Client (13.5)         | Spotify (1.0.10.107.gd0dfca3a)    |         |           |                      |            |
| Sublime Text 3 (3065)           |                                |                                   |         |           |                      |            |

| consultingcomputer              |                          |                                   |         |           |                      |            |
|---------------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| Adobe Reader XI                 |                          |                                   |         | available | allcomputers         |            |
| guestaccount.mobileconfig (1.0) |                          |                                   |         |           |                      |            |

| facultystaffcomputer            |                          |                                        |         |           |                      |            |
|---------------------------------|--------------------------|----------------------------------------|---------|-----------|----------------------|------------|
| Installs                        | Uninstalls               | Optional Installs                      | Updates | Catalogs  | Included Manifests   | Conditions |
| Acrobat XI                      |                          | 204podprinter.mobileconfig (1.0)       |         | available | allcomputers         |            |
| loginuhsa1.mobileconfig (1.0)   |                          | 205podprinter.mobileconfig (1.0)       |         |           |                      |            |
| Spotify (1.0.10.107.gd0dfca3a)  |                          | 206podprinter.mobileconfig (1.0)       |         |           |                      |            |
| SSD Fan Control (2.0)           |                          | AdobeIndesignCS6 (8.0)                 |         |           |                      |            |
| Sublime Text 3 (3065)           |                          | Atom (1.2.4)                           |         |           |                      |            |
|                                 |                          | copystoragexerox.mobileconfig (1.0)    |         |           |                      |            |
|                                 |                          | deansareahp.mobileconfig (1.0)         |         |           |                      |            |
|                                 |                          | deansareaxerox.mobileconfig (1.0)      |         |           |                      |            |
|                                 |                          | gardensxerox.mobileconfig (1.0)        |         |           |                      |            |
|                                 |                          | recruitementprinter.mobileconfig (1.0) |         |           |                      |            |
|                                 |                          | Spotify (1.0.10.107.gd0dfca3a)         |         |           |                      |            |
|                                 |                          | ssoprinter.mobileconfig (1.0)          |         |           |                      |            |
|                                 |                          | TeamViewerQS (10.0.47374)              |         |           |                      |            |
|                                 |                          | xeroxphasercolor.mobileconfig (1.0)    |         |           |                      |            |

| advisorcomputer                |                          |                                         |         |           |                      |            |
|--------------------------------|--------------------------|-----------------------------------------|---------|-----------|----------------------|------------|
| Installs                       | Uninstalls               | Optional Installs                       | Updates | Catalogs  | Included Manifests   | Conditions |
| FileMakerPro14ARD (14.0.1.175) |                          | screenlockgatekeeper.mobileconfig (1.0) |         | available | facultystaffcomputer |            |

| admincomputer                |                          |                                        |         |           |                      |            |
|------------------------------|--------------------------|----------------------------------------|---------|-----------|----------------------|------------|
| Installs                     | Uninstalls               | Optional Installs                      | Updates | Catalogs  | Included Manifests   | Conditions |
| AutoDMG (1.5.3)              |                          | screenlockgatekeeper.mobileconfig (1.0)|         | available | facultystaffcomputer |            |
| CreateUserPkg (1.2.4)        |                          |                                        |         |           |                      |            |
| DeploystudioAdmin (1.6.15)   |                          |                                        |         |           |                      |            |
| MunkiAdmin (1.3.0)           |                          |                                        |         |           |                      |            |
| munkitools_admin (2.3.0.2519)|                          |                                        |         |           |                      |            |
