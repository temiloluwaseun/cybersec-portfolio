# Web Traffic Analysis — testphp.vulnweb.com

## Cover
**Target:** testphp.vulnweb.com (44.228.249.3)
**Author:** <Your name>
**Date:** $(date -u +"%Y-%m-%d %H:%M UTC")

## Methodology
Tools used: nmap, gobuster, whatweb, nikto, curl, nc.
Scope: public test target testphp.vulnweb.com (authorized testbed).

## Top Findings (summary)
1. Directory indexing exposes `/admin/` and `/CVS/` — public access to `create.sql` and CVS metadata.
2. Server technology disclosed — nginx/1.19.0 and PHP 5.6.40.
3. Missing security headers (X-Frame-Options, X-Content-Type-Options).
4. Wildcard crossdomain/clientaccesspolicy entries.
5. Limited open services — HTTP (80) and ISP SMTP proxy (25).

## Evidence (selected excerpts)
- Nmap (top 100): shows 80/tcp http (nginx 1.19.0) and 25/tcp smtp-proxy.
- WhatWeb: nginx 1.19.0, PHP 5.6.40, Title 'Home of Acunetix Art'.
- Nikto: missing security headers, wildcard crossdomain/clientaccesspolicy, potential PHP-MySQL connection string.
- Gobuster: /admin (redirects to /admin/), /404.php, /CVS/
- Admin /create.sql: DB schema for 'waspart' (forum, artists, categ, pictures tables).

## Remediation checklist
1. Disable directory indexing for /admin and /CVS.
2. Remove public SQL dumps and backups.
3. Suppress server tech leak headers and update PHP to supported version.
4. Set X-Frame-Options and X-Content-Type-Options headers.
5. Restrict crossdomain/clientaccesspolicy files.

## Appendix — commands used
nmap -Pn -sV -sC --top-ports 100 44.228.249.3
gobuster dir -u http://testphp.vulnweb.com -w /usr/share/wordlists/dirb/common.txt -x php,txt
nikto -h http://testphp.vulnweb.com
curl -s http://testphp.vulnweb.com/admin/create.sql
