# Art App API Documentation

All paths are relative to the location of the Art App webservice, currently at `https://housuggest.org:8443/ArtApp`. Authentication to the webservice is handled via BASIC authentication.

## Tours `/tours/` 
### GET
Retrieve JSON Array of tour objects. The key `artwork_included` field includes the ids of artwork included in the tour, separated by commas.
####response `application/json`
JSON array of tour objects. [Example](https://gist.github.com/CarlSteven/b4617e0e35f50787e24e)
#### query parameters
##### updated (optional)
- Date String
- Returns only tours updated after this date.
- Format: `2015-08-27T19:40:47.710`

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

## Artwork Images
Artwork image file names are retrieved as a part of the Artwork JSON object. The `image` field contains just the file name. The actual URL of the image is generated using the following: `http://housuggest.org/images/ARtour/` + `artwork.id/` + `artwork.image`
 
To retrieve artwork image thumbnails, use the following:  `http://housuggest.org/images/ARtour/` + `artwork.id/` + `artwork.image` + `_thumb` + `file_extension`

### Example Art Object:
```
  {
    "artwork_id": 1,
    ...
    "image": "manual.png",
    ...
  }
```

Image URL: `http://housuggest.org/images/ARtour/1/manual.png`
Image Thumbnail URL: `http://housuggest.org/images/ARtour/1/manual_thumb.png`