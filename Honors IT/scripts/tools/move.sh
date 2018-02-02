#!/bin/sh

mkdir /Volumes/Macintosh\ HD\ 1/$1/Desktop/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Documents/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Downloads/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Pictures/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Music/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Library/Safari/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Library/Fonts/
mkdir /Volumes/Macintosh\ HD\ 1/$1/Library/FontCollections/

cp -r /Users/$1/Desktop/* /Volumes/Macintosh\ HD\ 1/$1/Desktop/
cp -r /Users/$1/Documents/* /Volumes/Macintosh\ HD\ 1/$1/Documents/
cp -r /Users/$1/Downloads/* /Volumes/Macintosh\ HD\ 1/$1/Downloads/
cp -r /Users/$1/Pictures/* /Volumes/Macintosh\ HD\ 1/$1/Pictures/
cp -r /Users/$1/Music/* /Volumes/Macintosh\ HD\ 1/$1/Music/
cp -r /Users/$1/Library/Safari/Bookmarks.plist /Volumes/Macintosh\ HD\ 1/$1/Library/Safari/
cp -r /Users/$1/Library/Fonts/* /Volumes/Macintosh\ HD\ 1/$1/Library/Fonts/
cp -r /Users/$1/Library/FontCollections/* /Volumes/Macintosh\ HD\ 1/$1/Library/FontCollections/

