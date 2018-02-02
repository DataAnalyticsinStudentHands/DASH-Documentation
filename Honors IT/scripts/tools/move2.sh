#!/bin/sh

cp -r /Volumes/Macintosh\ HD\ 1/$1/Desktop/* /Users/$1/Desktop/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Documents/* /Users/$1/Documents/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Downloads/* /Users/$1/Downloads/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Pictures/* /Users/$1/Pictures/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Music/* /Users/$1/Music/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Library/Safari/Bookmarks.plist /Users/$1/Library/Safari/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Library/Fonts/* /Users/$1/Library/Fonts/
cp -r /Volumes/Macintosh\ HD\ 1/$1/Library/FontCollections/* /Users/$1/Library/FontCollections/

chown -R $1 /Users/$1
