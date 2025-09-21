# Day 11 — Mini Project 2: Home Network Device Mapping

## Objective
Map devices on a local network segment, capture open ports, and produce a device map CSV + short analysis.

## Safe commands (replace subnet with your LAN)
# Discover live hosts (ping sweep)
nmap -sn 192.168.1.0/24 -oN day11/ping_sweep.txt

# Identify open ports for a single host (quick)
nmap -Pn -sV --top-ports 100 -oN day11/<IP>_top100.txt 192.168.1.10

# Save device list as CSV (example)
# Format: IP,MAC,Hostname,OpenPorts,Vendor
# You can produce this manually or use scripts to parse nmap/arp output.

## Deliverables
- day11/ping_sweep.txt
- day11/device_map.csv (or device_map.md)
- screenshots in day11/screens/
