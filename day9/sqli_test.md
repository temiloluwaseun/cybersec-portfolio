# SQLi Test — artists.php?artist=<id>

**Target:** http://testphp.vulnweb.com/artists.php?artist=1  
**Date (UTC):** $(date -u +"%Y-%m-%d %H:%M UTC")

## Test payloads & evidence

1. Normal request
- URL: http://testphp.vulnweb.com/artists.php?artist=1
- Result: page returned HTML (artists listing). See saved copy: day9/artists_1.html

2. Single-quote probe (non-destructive)
- URL: http://testphp.vulnweb.com/artists.php?artist=1'
- Command used: curl -s -D - "http://testphp.vulnweb.com/artists.php?artist=1'" > day9/sqli_probe.txt
- Observed response (excerpt):
\`\`\`
Error: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''' at line 1
\`\`\`

## Conclusion
- **Result:** Evidence of SQL injection vulnerability (error-based).  
- **Severity:** High (user input appears to reach SQL without proper parameterization or escaping).  
- **Recommendation:** Immediate remediation actions listed below.

## Remediation (short)
1. Use parameterized queries / prepared statements for all DB access.  
2. Validate and sanitize all user input on server side (allow-listing where possible).  
3. Remove verbose DB errors from public responses (show generic messages, log details server-side).  
4. Use least-privileged DB accounts (no unnecessary SELECT/WRITE privileges).  
5. Consider a code review and run targeted vulnerability scans in a controlled environment.

