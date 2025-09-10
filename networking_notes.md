# Networking Notes

## Wireshark Capture
- Tool: Wireshark
- Capture: Ping packets to 8.8.8.8
- Filter used: `icmp`
- Observation: Request and reply packets visible, TTL shows hops.

## Tcpdump Capture - Ping
- Command: `sudo tcpdump -i any icmp -w captures/ping_dump.pcap`
- Trigger: `ping -c 4 8.8.8.8`
- Result: Captured ICMP echo request and reply.

## Tcpdump Capture - DNS
- Command: `sudo tcpdump -i any port 53 -w captures/dns_dump.pcap`
- Trigger: `dig google.com`
- Result: Captured DNS query and response packets.
