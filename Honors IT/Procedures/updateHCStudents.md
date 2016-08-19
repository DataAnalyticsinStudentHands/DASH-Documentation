## Update HC Students group in AD

Every summer we need to clean out the AD group HC Students (we have a limited license for Papercut and it is good practice).

We will receive an Excel sheet with all new and continuing Honors student PS IDs.

The Excel sheets needs to be converted into a csv file and run against the following Powershell Script from an account that has administrative rights for Honors AD groups.

```#
# Find cougarnet ID from PeopleSoftID &
# Add User to HC Students Group - PowerShell Script
#

$userIDs = Import-CSV ‘filetoImport.csv‘
$group = get-adgroup -Identity "HC Students"

foreach($userID in $userIDs)
{
    Get-ADUser -Filter "EmployeeID -eq $($userID.EmployeeID)" -Properties SAMAccountName | % {
    $_.SamAccountName
        Add-ADGroupMember -Identity $group -Members $_.SamAccountName

    }
}
```
