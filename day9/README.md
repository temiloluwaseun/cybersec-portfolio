# Day 9 — Web Vulnerability Scanning Basics

## Objective
Use automated and manual tests to identify common web vulnerabilities (SQLi, XSS) on a safe test target.

## Automated scan
- Nikto: `nikto -h http://testphp.vulnweb.com -output day9/nikto.txt`

## Manual tests
1. SQLi testing (safe checks):
   - Visit `http://testphp.vulnweb.com/artists.php?artist=1` and then `?artist=1'` to look for SQL errors.
   - Record findings in `day9/sqli_test.md`.

2. XSS testing (safe checks):
   - Test input fields with `<script>alert(1)</script>` and capture screenshots in `day9/screens/`.

## Deliverables
- nikto.txt
- sqli_test.md (describe the request, response, and whether an error or payload reflected)
- screenshots in day9/screens/
