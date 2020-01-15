#!/bin/bash

for f in *; do mv "$f" "$(sed 's/[^0-9A-Za-z_.]/_/g' <<< "$f")"; done
