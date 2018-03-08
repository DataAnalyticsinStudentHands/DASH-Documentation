#!/bin/bash
defaults write org.cups.PrintingPrefs UseLastPrinter -bool False
#this needs to be false because it takes precedence over defaults

shopt -s nocasematch

name=$(hostname)

if [[ "$name" == "hc-laba.local" || "$name" == "hc-labb.local" ||
      "$name" == "hc-labc.local" || "$name" == "hc-labd.local" ||
      "$name" == "hc-labe.local" || "$name" == "hc-labf.local" ||
      "$name" == "hc-labg.local" || "$name" == "hc-labh.local" ]]
then
  lpoptions -d mcx_1
  #Lab printer 20
else
  lpoptions -d mcx_0
  #Lab printer 21
fi

shopt -u nocasematch
