#!/bin/bash
defaults write org.cups.PrintingPrefs UseLastPrinter -bool False
#this needs to be false because it takes precedence over defaults

if [[ $(hostname) == *"ba"* || $(hostname) == *"bb"* ||
      $(hostname) == *"bc"* || $(hostname) == *"bd"* ||
      $(hostname) == *"be"* || $(hostname) == *"bf"* ||
      $(hostname) == *"bg"* || $(hostname) == *"bh"* ]]
then
  lpoptions -d mcx_1
  #Lab printer 20
else
  lpoptions -d mcx_0
  #Lab printer 21
fi
