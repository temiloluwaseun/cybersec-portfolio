# DVWA — Day 3 Report
**Date:** 2025-10-10

## Environment
- DVWA running in Docker container `dvwa` (host port 80).
- Logged in as `admin`. DVWA security set to **low**. PHPIDS disabled.

## Activities attempted
- Confirmed container status and port mapping.
- Attempted automated SQLi with sqlmap on `/vulnerabilities/sqli/`:
  - sqlmap did not find an injectable parameter with the initial run (redirected to /login earlier).
  - Tried merging cookies and increasing `--level`/`--risk` (no exploit discovered in this run).
- Manual tests attempted:
  - Reflected XSS payload `"<script>alert('xss')</script>"` — tested via curl, but responses were redirected to login (no saved PoC).
  - Command injection payload `127.0.0.1; echo day3done` — tested via curl; response was redirected to login or not saved (no PoC).
- Troubleshooting steps performed:
  - Tried saving cookies via curl login; `cookies.txt` initially empty and later attempts did not produce the expected saved page bodies.
  - Determined browser-captured requests (Copy as cURL / Burp) are the most reliable way to capture PoC if automated curl fails due to CSRF/session handling.

## Results / Status
- Lab baseline restored (container restarted).
- No persistent exploitation PoC files captured in the repo during this session (attempts redirected).
- Day 3 objectives (recon + basic SQLi/XSS/Command Injection testing) were attempted; further exploitation can proceed tomorrow using Burp-captured requests or by ensuring authenticated cookies are passed to attack tools.

## Next steps (Day 4)
1. Use Burp -> **Copy as cURL** (or save raw request) for the module that returns successful server-side output.  
2. Run `sqlmap -r request.txt` (or replay via curl) to extract DB if SQLi proves viable.  
3. Capture at least one confirmed PoC (request file + screenshot) for each vuln type tested.  
4. Save all PoCs in `~/cybersec-projects/portfolio/dvwa-day3/pocs/`.

