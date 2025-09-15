#!/bin/bash
# Simple recon script
TARGET="$1"
if [ -z "$TARGET" ]; then
  echo "Usage: $0 target (domain or IP)"; exit 1
fi
OUTDIR="recon/$TARGET"
mkdir -p "$OUTDIR"
echo "=== ping ===" > "$OUTDIR/ping.txt"
ping -c3 "$TARGET" >> "$OUTDIR/ping.txt" 2>&1
echo "=== nmap top100 ===" > "$OUTDIR/nmap_top100.txt"
nmap -sV --top-ports 100 "$TARGET" -oN "$OUTDIR/nmap_top100.txt" >> "$OUTDIR/nmap_top100.txt" 2>&1 || true
echo "=== headers ===" > "$OUTDIR/headers.txt"
curl -s -I "http://$TARGET" >> "$OUTDIR/headers.txt" 2>&1 || true
echo "=== gobuster_short (30s) ===" > "$OUTDIR/gobuster_short.txt"
timeout 30s gobuster dir -u "http://$TARGET" -w /usr/share/wordlists/dirb/common.txt -x php,txt -t 20 -o "$OUTDIR/gobuster_short.txt" || true
echo "=== nikto ===" > "$OUTDIR/nikto.txt"
nikto -h "http://$TARGET" -output "$OUTDIR/nikto.txt" 2>/dev/null || true
echo "Recon output saved to $OUTDIR"
