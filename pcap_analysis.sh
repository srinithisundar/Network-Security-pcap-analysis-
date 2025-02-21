#!/bin/bash

## PCAP file using the tcpdump

# Total number of packets in the pcap file 
tcpdump -tttt -r tcpdump_challenge.pcap --count

# Total number of ICMP packets in the pcap file
tcpdump -tttt -r tcpdump_challenge.pcap -n icmp --count

# ASN of the destination IP address that the endpoint was pinging
#By just filtering the icmp packets, destination address can be found
tcpdump -tttt -r tcpdump_challenge.pcap -n icmp

# To find ASN
whois 172.67.72.15 | grep -i origin

# Total number of HTTP POST requests made in the packet capture
tcpdump -tttt -r tcpdump_challenge.pcap | grep -E 'POST'

# Total number of HTTP GET or POST requests made in the packet capture
tcpdump -tttt -r tcpdump_challenge.pcap | grep -E 'GET|POST'

# Extracting the fields and excluding the date
tcpdump -r tcpdump_challenge.pcap | cut -d " " -f 4-9 | grep -E 'GET|POST'

# Get the host information in th ASCII format
tcpdump -r tcpdump_challenge.pcap host 10.0.2.10 -A 

# Find credentials within HTTP payloads
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i 'user\|pass\|login'

# Filtering just the password
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i 'pass'

# Identify commonly used TCP ports (excluding HTTP)
tcpdump -tttt -r tcpdump_challenge.pcap -n tcp and not port 80 | sort

# Valid credentials used to access the FTP server
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 and -i any port 21 -A | grep -i 'user\|pass'

# Retrieve the name of a file downloaded from the server
tcpdump -r tcpdump_challenge.pcap -i any port 21 -A | grep -i 'RETR'

# Identify unique User-Agent strings
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i 'user'

#Use google and find the malware type of that agent, I used found User-agent and found its Lumma-infostealer. Refer to 

#Extract URL accessed by TeslaBrowser User-Agent
tcpdump -tttt -r tcpdump_challenge.pcap host 10.0.2.10 -A | grep -i "User-Agent: .*TeslaBrowser/5.5" -A 50
