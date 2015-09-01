# Honors College User/Computer Classes

The Honors College requires certain software packaged on its client computers to ensure the college runs smoothly. There are three classes of users in the Honors College, each with their own lists of packages. All packages will be imported into Munki for distribution, but certain software may require some work to create a distributable package.

Classes are determined and assigned by computer. For example, the computers in SSO will be imaged and configured as "Advisor" computers, but if someone who works in SSO were to login in the computer lab, they would only be able to access software available to all lab users, since computer in there are configured as "Lab Computer".

In addition to software, each class has different restrictions and login scripts.

### Advidsor

Advisors are any employee of the Honors College that requires access to student data on a regular basis, this includes actual HC advising staff, as well as Recruitment and Student Services student workers.

#### Software List
- Microsoft Office 2011
- Adobe Reader
- Adobe Acrobat Pro
- EasyFind (Allows for efficient searching of SMB shares, such as UHSA1)
- **FileMaker Pro (The Honors College's student data is stored in FileMaker)**
- Google Chrome
- Mozilla Firefox
- Adobe Flash Player
- Spotify
- Sublime Text 3
- Dropbox
- VLC

#### Computer Configuration
- These users will be administrators of the computers they commonly use. For exapmle, SSO will have administrator rights on all of the SSO computers, but advisors will only administrator rights on the computer in their office.

### Faculty & Staff

Faculty & Staff are University employees and student workers who do not require access to student data.

#### Software List
- Microsoft Office 2011
- Adobe Reader
- Adobe Acrobat Pro
- EasyFind (Allows for efficient searching of SMB shares, such as UHSA1)
- Google Chrome
- Mozilla Firefox
- Adobe Flash Player
- Spotify
- Sublime Text 3
- Dropbox
- VLC

#### Computer Configuration
- These users will be administrators of the computers they commonly use. For exapmle, SSO will have administrator rights on all of the SSO computers, but advisors will only administrator rights on the computer in their office.

### Lab Computers, Classroom Computers & Consulting Offices

These computers are for general purpose computing, and will be accessed by many people.

#### Software List
- Microsoft Office 2011
- Adobe Reader
- Google Chrome
- Mozilla Firefox
- Adobe Flash Player
- Silverlight
- Papercut Client (Manages Printing)
- Sublime Text 3

#### Computer Configuration
- These users will **not** be administrators.
- Papercut is configured to start at login using a LaunchAgent, and cannot be exited.
- These computers will be connected to the Lab Printers.
