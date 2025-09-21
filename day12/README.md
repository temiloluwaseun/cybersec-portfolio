# Day 12 — Traffic Analysis: IO Graphs and Packet Loss

## Objective
Capture network traffic (tcpdump/Wireshark), generate IO graphs, inspect retransmissions and packet loss, and save screenshots + notes.

## Capture command (example)
sudo tcpdump -i <iface> -w day12/capture.pcap

## Wireshark tasks
1. Open day12/capture.pcap in Wireshark.
2. Use "Statistics → I/O Graphs" to generate traffic over time.
3. Use "Statistics → Summary" and "Statistics → Conversations" to find retransmits and packet loss.
4. Export graphs/screenshots to day12/screens/ and document findings in day12/analysis.md.

## Deliverables
- day12/capture.pcap
- day12/screens/io_graph.png
- day12/analysis.md
