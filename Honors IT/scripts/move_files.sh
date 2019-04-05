#!/bin/sh

scp /Users/$1/* $1@$2:/Users/$1/
scp -r /Users/$1/Desktop/* $1@$2:/Users/$1/Desktop/
scp -r /Users/$1/Documents/* $1@$2:/Users/$1/Documents/
scp -r /Users/$1/Downloads/* $1@$2:/Users/$1/Downloads/
scp -r /Users/$1/Pictures/* $1@$2:/Users/$1/Pictures/
scp -r /Users/$1/Music/* $1@$2:/Users/$1/Music/
scp -r /Users/$1/Public/* $1@$2:/Users/$1/Public/
scp -r /Users/$1/Library/Safari/Bookmarks.plist $1@$2:/Users/$1/Library/Safari/
scp -r /Users/$1/Library/Fonts/* $1@$2:/Users/$1/Library/Fonts/
scp -r /Users/$1/Library/FontCollections/* $1@$2:/Users/$1/Library/FontCollections/
