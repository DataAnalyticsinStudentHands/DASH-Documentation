# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html
#http://www5.tceq.texas.gov/tamis/index.cfm?fuseaction=report.view_site&siteID=335&siteOrderBy=name&showActiveOnly=0&showActMonOnly=0&formSub=1&tab=mons


from scrapy.item import Item, Field

class TceqMonitorsItem(Item):
    #from basic
    TCEQSiteName = Field()
    EPASiteNumber = Field()
    CAMS = Field()
    ActivationData = Field()
    State = Field()
    County = Field()
    City = Field()
    Address = Field()
    ZIP = Field()
    Latitude = Field()
    Longitude = Field()
    Elevation = Field()
    OwnedBy = Field()
#    pass

#class TceqBasicMonitorsItem(Item):
    #from monitors
    SamplerType = Field()
    SamplerOperator = Field()
    SamplerParams = Field()
    SamplerStatus = Field()
    SamplerDisclaimer = Field()
    #SamplerDataOptions = Field() buried a bit too much on site
    ParamGroup = Field()
    ParamCode = Field()
    POCSegCd = Field()
    ParamName = Field()
    ParamCarrier = Field()
    ParamStatus = Field()
    pass

class TceqMonitorInfo(Item):
    SiteInfo = Field()
    MonInfo = Field()
    pass