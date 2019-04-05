#!/bin/sh

function scriptcontents {
cupsenable Lab_Printer_at_20
cupsenable Lab_Printer_at_21
}

echo "***
$0 | $(whoami) | $(date)" >> /usr/local/honors/honors_log.log
scriptcontents 1>> /usr/local/honors/honors_log.log 2>> /usr/local/honors/honors_log.log
