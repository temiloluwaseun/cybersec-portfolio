# Day 8 — Advanced Recon & Automation

## Objective
Automate passive + active recon steps and save outputs into day8/ for later analysis.

## Commands run (example)
1. Passive
   - whois: `whois testphp.vulnweb.com > day8/whois.txt`
   - dig: `dig +noall +answer ANY testphp.vulnweb.com @8.8.8.8 > day8/dig.txt`
   - theHarvester: `theharvester -d testphp.vulnweb.com -l 200 -b google > day8/theharvester.txt`

2. Active
   - full nmap: `nmap -Pn -p- -A 44.228.249.3 -oN day8/nmap_full.txt`
   - whatweb: `whatweb http://testphp.vulnweb.com > day8/whatweb.txt`

## Notes
- Save all outputs in the day8/ directory. Keep commands reproducible.
