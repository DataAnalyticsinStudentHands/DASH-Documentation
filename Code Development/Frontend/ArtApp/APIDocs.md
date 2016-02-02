# Art App API Documentation

All paths are relative to the location of the Art App webservice, currently at `https://housuggest.org:8443/ArtApp`. Authentication to the webservice is handled via BASIC authentication.

##Artwork `/artobjects/`
### GET
Retrieve JSON Array of artwork objects.
####response `application/json`
JSON array of artwork objects. [Example](https://gist.github.com/CarlSteven/6c237b4b3238e89dedf8)
#### query parameters
##### updated (optional)
- Date String
- Returns only art objects updated after this date.
- Format: `2015-08-27T19:40:47.710`

## Tours `/tours/` 
### GET
Retrieve JSON Array of tour objects. 
####response `application/json`
JSON array of tour objects. [Example](https://gist.github.com/CarlSteven/b4617e0e35f50787e24e)
#### query parameters
##### updated (optional)
- Date String
- Returns only tours updated after this date.
- Format: `2015-08-27T19:40:47.710`