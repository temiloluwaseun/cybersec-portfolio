# Day 8 — Nmap Deep Dive (scan_report.md)

**Target:** testphp.vulnweb.com (44.228.249.3)
**Date:** $(date -u +"%Y-%m-%d %H:%M UTC")

## Scans run
- nmap -Pn -p- -A -sV -T4 -oA day8/nmap_full 44.228.249.3

## Key findings (summary)
- Open ports: 80/tcp — http (nginx 1.19.0).
- No other TCP services discovered on full port scan.
- OS: aggressive guesses indicate Linux (various kernel ranges) — unreliable due to only one open port.
- Network distance: ~15 hops (traceroute shown in nmap output).

## Nmap excerpt
\`\`\`
$(sed -n '1,200p' day8/nmap_full.nmap || true)
\`\`\`

## Next recommended actions
1. Web enumeration: nikto, gobuster, whatweb, manual form inspection. (Day 9)  
2. Document any input points and test for injection/XSS only with single safe probes (done for artists.php).  
3. Prepare report and remediation suggestions.

