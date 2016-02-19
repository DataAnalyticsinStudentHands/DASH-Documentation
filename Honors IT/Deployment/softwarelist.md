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

| allcomputers              |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| AdobeAir                  |                          | Dropbox                           |         | available |                      |            |
| AdobeFlashPlayer          |                          | Firefox                           |         |           |                      |            |
| EasyFind                  |                          | Skype                             |         |           |                      |            |
| GoogleChrome              |                          | VLC                               |         |           |                      |            |
| munkireport               |                          |                                   |         |           |                      |            |
| muniktools                |                          |                                   |         |           |                      |            |
| munkitools_core           |                          |                                   |         |           |                      |            |
| munkitools_launchd        |                          |                                   |         |           |                      |            |
| Office Installer          |                          |                                   |         |           |                      |            |
| Silverlight               |                          |                                   |         |           |                      |            |

| labcomputer               |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| guestaccount.mobileconfig |                          | Atom                              |         | available | allcomputers         |            |
| labprinters.mobileconfig  |                          | Spotify                           |         |           |                      |            |
| PaperCut Client           |                          |                                   |         |           |                      |            |
| Sublime Text 3            |                          |                                   |         |           |                      |            |

| bonnerlabcomputer         |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| guestaccount.mobileconfig | labprinters.mobileconfig | Atom                              |         | available | allcomputers         |            |
| gardensxerox.mobileconfig | PaperCut Client          | Spotify                           |         |           |                      |            |
| Sublime Text 3            |                          |                                   |         |           |                      |            |

| consultingcomputer        |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| Adobe Reader XI           |                          |                                   |         | available | allcomputers         |            |
| guestaccount.mobileconfig |                          |                                   |         |           |                      |            |

| facultystaffcomputer      |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| Acrobat XI                |                          | 204podprinter.mobileconfig        |         | available | allcomputers         |            |
| loginuhsa1.mobileconfig   |                          | 205podprinter.mobileconfig        |         |           |                      |            |
| Spotify                   |                          | 206podprinter.mobileconfig        |         |           |                      |            |
| SSD Fan Control           |                          | AdobeIndesignCS6                  |         |           |                      |            |
|                           |                          | Atom (1.2.4)                      |         |           |                      |            |
| Sublime Text 3            |                          | copystoragexerox.mobileconfig     |         |           |                      |            |
|                           |                          | deansareahp.mobileconfig          |         |           |                      |            |
|                           |                          | deansareaxerox.mobileconfig       |         |           |                      |            |
|                           |                          | gardensxerox.mobileconfig         |         |           |                      |            |
|                           |                          | recruitementprinter.mobileconfig  |         |           |                      |            |
|                           |                          | Spotify                           |         |           |                      |            |
|                           |                          | ssoprinter.mobileconfig           |         |           |                      |            |
|                           |                          | TeamViewerQS                      |         |           |                      |            |
|                           |                          | xeroxphasercolor.mobileconfig     |         |           |                      |            |

| advisorcomputer           |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| FileMakerPro14ARD         |                          | screenlockgatekeeper.mobileconfig |         | available | facultystaffcomputer |            |

| admincomputer             |                          |                                   |         |           |                      |            |
|---------------------------|--------------------------|-----------------------------------|---------|-----------|----------------------|------------|
| Installs                  | Uninstalls               | Optional Installs                 | Updates | Catalogs  | Included Manifests   | Conditions |
| AutoDMG                   |                          | screenlockgatekeeper.mobileconfig |         | available | facultystaffcomputer |            |
| CreateUserPkg             |                          |                                   |         |           |                      |            |
| DeploystudioAdmin         |                          |                                   |         |           |                      |            |
| MunkiAdmin                |                          |                                   |         |           |                      |            |
| munkitools_admin          |                          |                                   |         |           |                      |            |
