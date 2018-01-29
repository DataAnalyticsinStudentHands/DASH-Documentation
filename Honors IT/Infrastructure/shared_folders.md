The Honors College infrastructure operates with two shared network spaces:

## 1. HC Share

This is a service offered through UH IT using a Windows Shared Folder that is mounted via Samba.

The mount point is `\\uhsa1\HCShare`

The HC Share is automatically mounted on staff, advisor, faculty and student service computers.

To test connections, use Finder -> Command+K and use the following address:

`smb://uhsa1/HCShare`

Access to the shared folders inside the HCShare folder is managed via Active Directory. You need a Windows Computer running "Administrative Tools -> Active Directory Users & Computers" to configure permissions.

Here is a list of the folders inside HCShare:

The access to each of those folders is handled via group permissions. The group "HC Admins" + a administrator from UH IT should have always full control for each of the folders.

| Group Name  | Department/Security Group/Supergroup| Member Description | Access to Folder
|-----------------|--------------|---------------------------|
| 1. HC Admins| Security Group | Honors College Admins |
| 2. HC Admissions     | Admissions |Admissions staff | ? (should have access to "Admissions" shared folder) |
| 3. HC Advising     | Advising |Advising staff | ? (should have read access to "Advising" shared folder) |
| 4. HC Authenticated Students | Supergroup | HC student workers who are not SSO | -- |
| 5. HC Authenticated Users | Supergroup | authenticated users who are non-students |--|
| 6. HC Authorized SSO | Student Services | SSO student workers with special permissions| write access to "Student Services" shared folder |
| 7. HC Business Office | College Business Office| College Business Office staff | write access to "College Business Office" shared folder |
| 8. HC Communications | Communications | Communications staff | read access to "Communications Active" shared folder |
| 9. HC Communications | Communications | Communications staff with special permissions| write access to "Communications Active" shared folder |
| 10. HC Development | Development | Development staff | write access to "Development" shared folder |
| 11. HC DASH | DASH Program | DASH members | -- |
| 12. HC Faculty | Faculty | All Honors Faculty | -- |
| 13. HC Fulbright | Security Group | group working on Fulbright scholars | write access  to "Fulbright" scholarship shared folder |
| 14. HC Health Professions | Health Professions Program | -- |
| 15. HC Houston Scholars | Security Group | group working on Houston Scholars | write access to "Houston Scholars" shared folder |
| 16. HC IT | IT | Honors IT students and staff|  -- |
| 17. HC Policy Debate | Policy Debate Program | staff for the Policy Debate Program | write access to "Policy Debate" shared folder |
| 18. HC Recruitment | Recruitment | Recruitment staff | write access to "Recruitment" shared folder |
| 19. HC Research | Office of Undergraduate Research | Office of Undergraduate Research staff| write access to "Research" shared folder |
| 20. HC Student Services | Student Services | SSO student workers | read access to "Student Services" shared folder |
| 21. HC Students | Security Group| All Honors College Students | -- |
| 22. HC Writing Fellows | Writing Fellows | Writing Fellows students workers | --|


## 2. Honors Share

This is a network share that we provide via our own hardware (Syncology NAS).
It can be accessed via Samba or Mac File Sharing
