#!/bin/bash

## PCAP file using the tcpdump

# Total number of packets in the pcap file packet capture 
tcpdump -tttt -r tcpdump_challenge.pcap --count
Refer to ![no_of_packets.png](./screenshots/no_of_packets.png)
	
# Total number of ICMP packets in the pcap file packet capture
tcpdump -tttt -r tcpdump_challenge.pcap -n icmp --count
Refer to ![no_of_packets.png](./screenshots/no_of_packets.png)

# ASN of the destination IP address that the endpoint was pinging
#By just filtering the icmp packets, destination address can be found
tcpdump -tttt -r tcpdump_challenge.pcap -n icmp
Refer to ![no_of_packets.png](./screenshots/no_of_packets.png)

# To find ASN
whois 172.67.72.15 | grep -i origin
Refer to ![getandpostreqs.png](./screenshots/getandpostreqs.png)

# Total number of HTTP POST requests made in the packet capture
tcpdump -tttt -r tcpdump_challenge.pcap | grep -E 'POST'
Refer to ![cut.png](./screenshots/cut.png)

# Total number of HTTP GET or POST requests made in the packet capture
tcpdump -tttt -r tcpdump_challenge.pcap | grep -E 'GET|POST'
Refer to ![cut.png](./screenshots/cut.png)

# Extracting the fields and excluding the date
tcpdump -r tcpdump_challenge.pcap | cut -d " " -f 4-9 | grep -E 'GET|POST'
Refer to ![cut.png](./screenshots/cut.png)

# Get the host information in th ASCII format
tcpdump -r tcpdump_challenge.pcap host 10.0.2.10 -A 
Refer to ![userinfo.png](./screenshots/userinfo.png)

# Credentials found in the pcap file within the payloads of the HTTP packets
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i 'user\|pass\|login'
Refer to ![userinfo.png](./screenshots/userinfo.png) and ![credentials.png](./screenshots/credentials.png)

# Filtering just the password
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i 'pass'

# TCP port which are most used and well-known in the capture other than http port 80
tcpdump -tttt -r tcpdump_challenge.pcap -n tcp and not port 80 | sort
Refer to ![filterport.png](./screenshots/filterport.png)

# Valid credentials the endpoints used to access the file sharing server for sharing a file
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 and -i any port 21 -A | grep -i 'user\|pass'
Refer to ![ftp_cred.png](./screenshots/ftp_cred.png)

# Name of file retrieved from the server
tcpdump -r tcpdump_challenge.pcap -i any port 21 -A | grep -i 'RETR'

# Unique User-agent found in the user list of http requests
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i 'user'
Refer to ![unique_user.png](./screenshots/unique_user.png)

#Use google and find the malware type of that agent, I used found User-agent and found its Lumma-infostealer. Refer to 
Refer to ![OSINT.png](./screenshots/OSINT.png)

#URL that the endpoint tried to connect to the User-Agent: TeslaBrowser
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i "User-Agent: .*TeslaBrowser/5.5" -A 50
Refer to ![urltoconnect.png](./screenshots/urltoconnect.png)