TCAN Documentation Scrapy
==================

This is a repository to keep information related to the incomplete attempt to use scrapy to get the monitor information.
To make it work, we need to go into the spider and have it loop through the sites and get the information nested properly. This is difficult because the sites have tabs that are called differently and we already need to have it loop through the total number of sites, where the id in the url is not the same as the CAMS, etc. (we think a range of up to 350 gets them all, but need an if to exclude empty cases and a count to make sure we got them all.



