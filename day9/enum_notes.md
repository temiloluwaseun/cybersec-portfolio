# Day 9 — Service & Web Enumeration Notes

**Target:** testphp.vulnweb.com (44.228.249.3)
**Date:** $(date -u +"%Y-%m-%d %H:%M UTC")

## Tools & scans run
- nmap -Pn -p- -A -sV -T4 -oA day8/nmap_full 44.228.249.3
- nikto -h http://testphp.vulnweb.com -output day9/nikto.txt
- gobuster dir -u http://testphp.vulnweb.com -w /usr/share/wordlists/dirb/big.txt -x php,txt,bak,inc -o day9/gobuster.txt
- manual curl probes (artists.php, admin/create.sql)
- recon scripts: day10/recon.py produced whois, whatweb, curl_headers outputs

## Key findings
1. **Open services**
   - 80/tcp — http (nginx 1.19.0). No other TCP services discovered.

2. **Web app findings**
   - Directory index /admin/ exposes `create.sql` (DB schema saved at day9/create.sql).
   - `/CVS/` index exposes repo metadata (Entries, Repository, Root).
   - Gobuster discovered many endpoints including: `/admin/`, `/CVS/`, `/artists.php`, `/login.php`, `/signup.php`, `/product.php`, `/search.php`, `/cart.php`, `/guestbook.php`, `/pictures/`, `/vendor/`, and an `index.bak`.
   - `artists.php?artist=1` returns HTML; a single-quote probe `artists.php?artist=1'` returned a SQL error (see day9/sqli_probe.txt and day9/sqli_test.md).

3. **Server disclosures / misconfigs**
   - Header leak: `X-Powered-By: PHP/5.6.40` (EOL). (See day8/http_headers.txt)
   - Missing security headers: `X-Frame-Options`, `X-Content-Type-Options`. (Nikto)
   - Wildcard `clientaccesspolicy.xml` and `crossdomain.xml` entries (Nikto).

4. **Fingerprint**
   - favicon MD5: `50c42a3edaaa2fa00445ac77f1b1a715` (day8).

## Risk assessment (quick)
- **High**: error-based SQLi evidenced by DB error on single-quote probe.
- **Medium**: public DB schema / repo metadata exposure; outdated PHP.
- **Medium**: missing security headers and wildcard crossdomain files increase attackability.

## Recommended next steps
1. Keep current POC evidence (day9/sqli_test.md), avoid further destructive testing externally.
2. Use Gobuster results to identify other user-controlled parameters (e.g., product.php?id=) and test with single-quote probes (one at a time, document results).
3. Remove public SQL dumps and disable directory indexing for admin/CVS directories.
4. Suppress `X-Powered-By`, upgrade PHP, add `X-Frame-Options: DENY` and `X-Content-Type-Options: nosniff`.
5. Perform a secure code review to fix SQL injection (use parameterized queries/prepared statements) and sanitize inputs.

## Evidence files (in repo)
- day8/nmap_full.*  
- day8/http_headers.txt  
- day9/nikto.txt  
- day9/gobuster.txt  
- day9/create.sql  
- day9/artists_1.html  
- day9/sqli_probe.txt, day9/sqli_test.md  
- day10/whois.txt, day10/whatweb.txt, day10/curl_headers.txt, day10/report.html

