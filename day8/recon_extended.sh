#!/usr/bin/env bash
# Usage: ./recon_extended.sh <target> <ip>
TARGET="$1"
IP="$2"
OUTDIR="day8"
mkdir -p "$OUTDIR"

# Passive
whois "$TARGET" > "$OUTDIR/whois.txt" 2>&1 || true
dig +noall +answer ANY "$TARGET" @8.8.8.8 > "$OUTDIR/dig.txt" 2>&1 || true
which theharvester >/dev/null 2>&1 && theharvester -d "$TARGET" -l 200 -b google > "$OUTDIR/theharvester.txt" 2>&1 || echo "theHarvester not installed" > "$OUTDIR/theharvester.txt"

# Active
whatweb "http://$TARGET" > "$OUTDIR/whatweb.txt" 2>&1 || true
nmap -Pn -p- -A "$IP" -oN "$OUTDIR/nmap_full.txt" || true

echo "Day8 recon saved to $OUTDIR"
