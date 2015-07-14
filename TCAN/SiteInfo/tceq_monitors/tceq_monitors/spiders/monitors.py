#scrapy crawl tceq_monitors -o monitors.txt -t csv
from scrapy.spider import BaseSpider
from scrapy.selector import Selector
from tceq_monitors.items import TceqMonitorsItem, TceqMonitorInfo
from scrapy.http import Request

class TCEQSpider(BaseSpider):
    name = "tceq_monitors"
    siteID = '1'
    maxSiteId = 3
    tab = 'info'
    allowed_domains = ["http://www5.tceq.texas.gov/","http://www.tceq.state.tx.us/"]
    
    def start_requests(self):
        for i in range(self.maxSiteId):
            siteID = `i`
            tab = 'info'
            yield Request("http://www5.tceq.texas.gov/tamis/index.cfm?fuseaction=report.view_site&siteID=%s&siteOrderBy=name&showActiveOnly=0&showActMonOnly=0&formSub=1&tab=%s" % (siteID, tab),  callback=self.parse)
            tab = 'mons'
            yield Request("http://www5.tceq.texas.gov/tamis/index.cfm?fuseaction=report.view_site&siteID=%s&siteOrderBy=name&showActiveOnly=0&showActMonOnly=0&formSub=1&tab=%s" % (siteID, tab),  callback=self.monParse)
            
        return
            
    def parse(self,response):
        sel = Selector(response)
        item = TceqMonitorsItem()
        item['TCEQSiteName'] = map(unicode.strip,sel.xpath('//h2/text()').extract())
        return item
    
    def monParse(self,response):
        sel = Selector(response)
        samplers = sel.xpath("//table[contains(@id,'allSamplers')]/tr")
        items = []
        item = TceqMonitorsItem()
        for sample in samplers:
            item = TceqMonitorsItem()
            item['SamplerType'] = sample.xpath('./td[2]/text()').extract()
            item['SamplerOperator'] = sample.xpath('./td[3]/text()').extract()
            item['SamplerParams'] = sample.xpath('./td[4]/text()').extract()
            item['SamplerStatus'] = sample.xpath('./td[5]/text()').extract()
            item['SamplerDisclaimer'] = sample.xpath('./td[6]/text()').extract()
            #items.append(item)
            #item['SamplerDataOptions'] = sample.xpath('./td[7]/text()').extract()
        params = sel.xpath('//table/tr')
        for param in params:
            pars = TceqMonitorsItem()
            pars['ParamCode'] = param.xpath('./td[1]/text()').extract()
            pars['POCSegCd'] = param.xpath('./td[2]/text()').extract()
            pars['ParamName'] = param.xpath('./td[3]/text()').extract()
            pars['ParamCarrier'] = param.xpath('./td[4]/text()').extract()
            pars['ParamStatus'] = param.xpath('./td[5]/text()').extract()
        item['ParamGroup'] = pars.items()
        items.append(item)
            #print param.xpath('./td[5]/text()').extract()
            #print 'param'
        #map(unicode.strip,sel.xpath('//table//tr[2]/td/text()').extract())
        #tables = map(unicode.strip,sel.xpath('//table//tr//td/text()').extract())
        #i = 0
        #for table in tables:
        #item = TceqMonitorsItem()
            #print tables[i]
            #print table
        #    i+=1
        #item = TceqMonitorsItem()
        #item['SamplerType'] = map(unicode.strip,sel.xpath('//table//tr//td/text()').extract())
        return items

	
# start_urls = ["http://www5.tceq.texas.gov/tamis/index.cfm?fuseaction=report.view_site&siteID=%s&siteOrderBy=name&showActiveOnly=0&showActMonOnly=0&formSub=1&tab=info","http://www5.tceq.texas.gov/tamis/index.cfm?fuseaction=report.view_site&siteID=%s&siteOrderBy=name&showActiveOnly=0&showActMonOnly=0&formSub=1&tab=mons" % (siteID,siteID)]
