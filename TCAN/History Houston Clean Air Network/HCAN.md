# Introduction
This document should help to understand the technical background of a website/data environment that we know as HoustonCleanAirNetwork or HCAN. It has been established through an effort by the Honors College at the University of Houston with funding from the Houston Endowment in 2010. It is currently available under <http://www.houstoncleanairnetwork.org>.

The environment is composed of three major components:
* Data Consumption (move data from TCEQ into database)
* Data interpolation (generate grid, contour, updating tables for viewers)
* Presentation modules (javascript for Drupal)

OZone contour map web service example: http://houstoncan.airalliancehoust.netdna-cdn.com/ozone-viewer-api/contour.php?callback=callbackFunc&type=jsonp&timestamp=1422424800&bandschema=4

OZone at point web service example: http://houstoncan.airalliancehoust.netdna-cdn.com/ozone-viewer-api/point.php?callback=callbackFunc&type=json&timestamp=1422424800&latlng=30.201,-94.69

A working example of a web app using the contour map web service can be found at: http://texascleanairnetwork.org/ Under the "OZone Map" tab.

A working example of an Android app using the point web service can be found at: https://play.google.com/store/apps/details?id=edu.uh.cpl

The workflow that drives the processes under which the components operate is a as follows:
1. Pushed data from TCEQ every 15 minutes (/home/TCEQ/uploads)
2. Cron job processes that data 2 minutes later - all in TCEQ Data Consumption (/home/ibhworker/processTCEQuploads.pl)
  a - MYSQL stored procedure (processTCEQdata)
  b - processRedraws.pl (interpolations)
      i - calculates Grids and Contours (calculateGrid.php writes files and updates database)
      ii - calculateParamGrid - for parameters beyond ozone (should be basis for expansion; currently only updates database)


TODO
* Rename calculateGrid to account for contours, etc.

* We could write a bash script that would also be committed to the git repo at the top level, the purpose of which would be to automate the updating of files on the AWS server.
* Ensure that the current repo successfully replicates the current processes of the ibreathe.hnet.uh.edu server (including compiling a new .jar from java sources)
