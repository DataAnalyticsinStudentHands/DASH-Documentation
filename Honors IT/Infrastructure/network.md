The Honors College has computers in several different locations, which have different network structures and names. All our computers are getting their IP addresses via DHCP, only printers/copiers and servers are using static IP addresses.

## M.D. Anderson Library

| Subnet | Network Speed |
|---|---|
|172.27.56.*|100 Mbps|

The IT office has a 1Gbps Switch between the NAS, ESXi Server, FileMaker Server and the IT Computer, with open ports for high-speed imaging. However, it has a 100 Mbps uplink to the rest of UH's network.

## Honors Gardens

| Subnet | Network Speed |
|---|---|
|172.27.218.*|100 Mbps|
|172.27.219.*|100 Mbps|

The Honors Gardens has two different subnets, which presents some difficulties when attempting to netboot from a deployment server. In addition, when looking for computers using remote desktop, scans must be done on each subnet individually.

## Static IP addresses (DNS) List

| IP Address | DNS |
|---|---|
| 172.27.56.1 | larry.honors.e.uh.edu |
| 172.27.56.2 | moe.honors.e.uh.edu |
| 172.27.56.3 | curly.cougarnet.uh.edu |
| 172.27.56.5 | hc-papercut.cougarnet.uh.edu & hc-papercut.honors.e.uh.edu |
| 172.27.56.6 | hc-management.cougarnet.uh.edu & hc-management.honors.e.uh.edu |
| 172.27.56.7 | copier01.honors.e.uh.edu |
| 172.27.56.8 | copier02.honors.e.uh.edu |
| 172.27.56.11 | printer01.honors.e.uh.edu |
| 172.27.56.12 | printer02.honors.e.uh.edu |
| 172.27.56.13 | printer03.honors.e.uh.edu |
| 172.27.56.14 | printer04.honors.e.uh.edu |
| 172.27.56.15 | printer05.honors.e.uh.edu |
| 172.27.56.16 | printer06.honors.e.uh.edu |
| 172.27.56.17 | printer07.honors.e.uh.edu |
| 172.27.56.18 | printer08.honors.e.uh.edu |
| 172.27.56.19 | printer09.honors.e.uh.edu |
| 172.27.56.20 | printer10.honors.e.uh.edu |
| 172.27.56.21 | printer11.honors.e.uh.edu |
| 172.27.56.22 | printer12.honors.e.uh.edu |
| 172.27.56.23 | printer13.honors.e.uh.edu |
| 172.27.56.24 | printer14.honors.e.uh.edu |
| 172.27.56.25 | printer15.honors.e.uh.edu |
| 172.27.56.30 | printer20.honors.e.uh.edu |


Not used right now, but reserved:

| IP Address | DNS |
|---|---|
| 172.27.56.9 | copier03.honors.e.uh.edu
| 172.27.56.10 | copier04.honors.e.uh.edu
| 172.27.56.25 | printer15.honors.e.uh.edu
| 172.27.56.26 | printer16.honors.e.uh.edu
| 172.27.56.27 | printer17.honors.e.uh.edu
| 172.27.56.28 | printer18.honors.e.uh.edu
| 172.27.56.29 | printer19.honors.e.uh.edu


To do:

Name:            hc-storage.cougarnet.uh.edu
Address: 172.27.56.197
Should use 172.27.56.4


## Activating Network Jacks

Most rooms only have one network jack activated. However, one can file a work order with UH IT at https://ssl.uh.edu/wtsc_apps/infotech/tickets/case-management/index.php. They require the number of the jack, so make a note of it before going to file the request.
