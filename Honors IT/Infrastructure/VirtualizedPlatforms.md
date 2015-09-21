The Honors College's main servers are virtualized for redundancy, efficiency and speed. The entire system is hosted on a Mac Mini located in the Honors College Library Locations and uses VMWare's vSphere free hypervisor (ESXi) as a type 1 hypervisor. The system is made up of three virtual machines, described below.

## List

## 1. HC-Deployment

HC-Deployment is a Mac OS X virtual machine that controls OS deployment, software updates, and computer management.

### HC-Deployment Virtual Machine Settings

| Component  | Value  |
|---|---|
| Memory  | 4312 MB  |
| CPUs  | 4 cores  |
| VMCI Device | Unrestricted  |
| Base Image | Yosemite.iso  |
| Hard Disk Size | >80GB  |

### HC-Deployment Services

| Services  | Program  |
|---|---|
| OS Deployment	| DeployStudio |
| Software Installation/Upgrade	| Munki, AutoPkgr |
| Device Management	Server.app | Profile Manager |

## 2. HC-Papercut

HC-Papercut is a Mac OS X virtual machines that control the shared printer queues for the Honors College and tracks student usage of the computer lab. It runs Papercut NG, a Java application for print management.

### HC-Papercut VM Settings

| Component  | Value  |
|---|---|
| Memory  | 4312 MB  |
| CPUs  | 4 cores  |
| VMCI Device | Unrestricted  |
| Base Image | Yosemite.iso  |
| Hard Disk Size | >80GB  |

### HC-Papercut Services

| Services  | Program  |
|---|---|
| Print Queue Monitoring/Management	| Papercut NG |

## 3. HC-Managment

HC-Management is a Windows 8.1 Pro virtual machine that is used to control the ESXi host and perform Active Directory administration, such as adding users to shares or modifying student access groups.

### HC-Management VM Settings

| Component  | Value  |
|---|---|
| Memory  | 4312 MB  |
| CPUs  | 4 cores  |
| VMCI Device | Unrestricted  |
| Base Image | SW_DVD5_Win_Pro_8.1_64BIT_English_MLF_X18-96634.ISO  |
| Hard Disk Size | 50 GB  |

### HC-Management Services

| Services  | Program  |
|---|---|
| vSphere/ESXi Host Control	| vSphere Client |
| VM Backups | Veeam Free Edition |
| Active Directory Operations | Windows Remote Server Administration Tools for Windows 8.1 |
| Password Manager | Thycotic Secret Server 8.8 Express Edition |

## Accessing the Virtual Machines

The virtual machines should be accessed through Microsoft Remote Desktop or Apple Remote Desktop. To make changes to the ESXi host, use the Windows vSphere client, either by logging into the HC-Management virtual machine. If HC-Management is no longer available, then use any Windows computer on the UH internal network, connect to 172.27.56.2 and install the vSphere client.

<div style="width: 640px; height: 480px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:640px; height:480px" src="https://www.lucidchart.com/documents/embeddedchart/2a9f5b91-65a2-460b-a40f-0e00f890da06" id="75TcRTG5p9d1"></iframe></div>

## Backup

All of the virtual machines are backed up manually using Veeam, which integrates with vSphere to freeze VM's and compress them to ZIP files, which are then copied to the VM Backups share on the Synology NAS. There are also ZIP files for the initial starting states of the servers with all of the software installed and configured, in case something completely breaks the VM.
