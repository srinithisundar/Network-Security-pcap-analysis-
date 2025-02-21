#!/bin/bash

## Commands for analysing the pcap file using the tcpdump

# Installtion - Ensure tcpdump is installed. If not, install it using the command below (requires root privileges).
sudo apt-get install tcpdump

# List all available network interfaces
tcpdump -D

# Capture packets on the interface 'enp0s3' and save them to a file named 'savedfile.pcap' 
sudo tcpdump -i enp0s3 -w savedfile.pcap

# To read and analyze the pcap file
# Replace "tcpdump_file.pcap" with your actual pcap file name
tcpdump -r tcpdump_file.pcap

# Display packet contents in ASCII format (useful for inspecting payloads) 
# Note: '-i lo' is not needed when reading from a file 
tcpdump -r tcpdump_file.pcap -i lo -A 

# Capture packets without resolving hostnames (shows only IP addresses)  
tcpdump -i enp0s3 -n host <hostname or ip>

# Perform a DNS lookup to resolve a domain name to an IP address  
dig google.com

# Capture packets from a specific source IP address
tcpdump -i enp0s3 -n src <source ip>

#Capture packets going to a specific destination IP address
tcpdump -i enp0s3 -n dst <destination ip>

#Find the ASN (Autonomous System Number) for a destination IP 
#If 'whois' is not installed, install it first using: sudo apt-get install whois
whois <dest ip> | grep -i origin

#Capture packets going to a specific subnet (where the destination IP is within that subnet)  
tcpdump -i enp0s3 -n dst net <subnet>

#Find packets from a specific protocol (e.g., TCP) in the pcap file 
tcpdump -r tcpsump_file.pcap -n tcp

#Capture an exact number of packets from the pcap file (e.g., capture 5 packets)
tcpdump -r tcpdump_file.pcap -c 5

#Get the total count of the packets in the pcap file
tcpdump -r tcpsump_file.pcap --count

#Extract specific sections from the pcap file 
#'-d' is the delimiter that specifies the field separator, and '-f' is used to extract specific fields based on the delimiter  
tcpdump -r tcpsump_file.pcap | cut -d ' ' -f 9

#Sort the output in ascending order and extract fields 1 to 5 using '.' as the delimiter
tcpdump -r tcpsump_file.pcap | cut -d '.' -f 1-5 | sort

#Filter unique values (removes duplicates) and show the count of occurrences
tcpdump -r tcpsump_file.pcap | uniq -c

##Get the timestamp in the desired format

#Get the timestamp in the standard UTC format (default)  
tcpdump -tt -r tcpsump_file.pcap

#Get the timestamp in milliseconds  
tcpdump -ttt -r tcpsump_file.pcap

#Get the timestamp in the standard 'yyyymmdd' format 
tcpdump -tttt -r tcpsump_file.pcap

#Remove the timestamp from the packet listing
tcpdump -t -r tcpsump_file.pcap

##Using logical operations: combine filters using 'and' or 'or'

#Filter based on the source IP address and the port number
tcpdump -tt -r tcpsump_file.pcap -n src <source ip> and port <port number>

#Filter excluding a specific port
tcpdump -tt -r tcpsump_file.pcap -n 'dst <destination ip> and not port <port_number>

#Combine multiple filters, for example excluding ports 443 and 21
tcpdump -i enp0s3 -n 'src <source ip> and host <host name> and not (port 443 or port 21)

