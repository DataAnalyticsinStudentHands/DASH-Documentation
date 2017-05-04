#!/bin/bash
defaults write org.cups.PrintingPrefs UseLastPrinter -bool False
#this needs to be false because it takes precedence over defaults

if [[ $(hostname) == *"bA"* || $(hostname) == *"bB"* ||
      $(hostname) == *"bC"* || $(hostname) == *"bD"* ||
      $(hostname) == *"bE"* || $(hostname) == *"bF"* ||
      $(hostname) == *"bG"* || $(hostname) == *"bH"* ]]
then
#Lab printer 20
  lpoptions -d mcx_1
else
#Lab printer 21
  lpoptions -d mcx_0
fi
