#!/bin/sh

/usr/bin/find /Users -name Keychains -maxdepth 3 -mindepth 1 -type d -print -exec rm -rfv {} \;
reboot