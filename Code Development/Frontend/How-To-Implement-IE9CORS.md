AngularJS IE9 CORS
===

Due to the way that IE9 implements CORS, the CORS allow headers (`Access-Control-Allow-Origin` or `Access-Control-Allow-Methods`) that we have applied in the JAVA backends. [There is an approach](https://andywalpole.me/#!/blog/139831/angularjs-cors-support-internet-explorer-9) that uses XDomain library to circumvent IE9 CORS issue by using a proxy on HouSuggest. The proxy has been implemented and is located at: `https://housuggest.org:8443/CORS/index.html`.

The contents of the proxy file can be viewed in [this gist](https://gist.github.com/CarlSteven/94be32b8059919174267).

#### How To Add Support for IE9 CORS in an AngularJS App

Add the following code to the `<head>` tag of the index.html:
```
<!--[if lte IE 9]>
    <script src="http://cdn.rawgit.com/jpillora/xdomain/0.7.3/dist/xdomain.min.js" slave="https://www.housuggest.org:8443/CORS/index.html"></script>
<![endif]-->
``` 