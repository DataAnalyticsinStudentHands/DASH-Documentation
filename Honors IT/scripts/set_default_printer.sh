#!/bin/bash
defaults write org.cups.PrintingPrefs UseLastPrinter -bool False
#this needs to be false because it takes precedence over defaults

if [[ $(hostname) == "hc-laba.local" || $(hostname) == "hc-labb.local" ||
      $(hostname) == "hc-labc.local" || $(hostname) == "hc-labd.local" ||
      $(hostname) == "hc-labe.local" || $(hostname) == "hc-labf.local" ||
      $(hostname) == "hc-labg.local" || $(hostname) == "hc-labh.local" ]]
then
  lpoptions -d mcx_1
  #Lab printer 20
else
  lpoptions -d mcx_0
  #Lab printer 21
fi
