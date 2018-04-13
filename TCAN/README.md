# Texas Clean Air Network (TCAN)

This is documentation related to the Texas Clean Air project within DASH.

For detailed documentation we refer to the individual project github wikis:

1. [TCAN Hadoop implementation](https://github.com/TexasCleanAirNetwork/TCAN_Hadoop/wiki)
2. [Old OzoneMap](https://github.com/DataAnalyticsinStudentHands/OldOzoneMap) This is the historical first implementation of the OzoneMap.

## Archived Data

Our data archive is located on the NAS that is attached to the hnet [virtual servers](https://github.com/DataAnalyticsinStudentHands/DASH-Documentation/tree/master/DASH%20Server%20Infrastructure).

The archived data drive is munted under /archive

### data - ozonemap

This is data that has been used with the original [Ozonemap](https://github.com/DataAnalyticsinStudentHands/OldOzoneMap) App
It also contains the TCEQ data dumps.

* generatedcontour - contour data produced by old ozonemap app (years ca. 2009 - 2017)
* gridData - grid pont data produced by old ozonemap (years ca. 2009 - 2017)
* other_db_tables - the DB tables for ibh_sites and ibh_parameters (as used with the old ozonemap)
* statewide - the orginal pulled TCEQ data (years ca. 2000 - late 2013)
* statewide_datadumps - raw csv files for pulled TCEQ data (years ca. 2000 - late 2013)
* statewide_datadumps_db - DB data dumps in csv format from the ibh data tables of the pulled TCEQ data (years ca. 2000 - 2011)
* statewide_datadumps_db_newformat - DB data dumps in csv format from the ibh data tables of the pulled TCEQ data (years ca. 2013 - 2017)

### data - tcequploads

Data pushed from TCEQ to us (years late 2013 - 2016)

### data - epidemiology

DB data dump used in an development stage for data visualizations of local data (for instance some old crime data).

### www

This is just various archived web development code.

### VMs

Archived VMs.

