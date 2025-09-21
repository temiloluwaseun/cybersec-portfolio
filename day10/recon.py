#!/usr/bin/env python3
"""
Threaded recon: simple example that runs curl/whois/whatweb concurrently and writes an HTML report.
"""
import subprocess
import threading
import queue
import os
import html

TARGET_DOMAIN = "testphp.vulnweb.com"
TARGET_IP = "44.228.249.3"
OUTDIR = "day10"
os.makedirs(OUTDIR, exist_ok=True)

tasks = [
    ("whois", ["whois", TARGET_DOMAIN]),
    ("whatweb", ["whatweb", f"http://{TARGET_DOMAIN}"]),
    ("curl_headers", ["curl", "-sI", f"http://{TARGET_DOMAIN}"]),
]

results = {}
q = queue.Queue()
for name, cmd in tasks:
    q.put((name, cmd))

def worker():
    while not q.empty():
        name, cmd = q.get()
        try:
            out = subprocess.check_output(cmd, stderr=subprocess.STDOUT, timeout=60).decode(errors="ignore")
        except Exception as e:
            out = f"ERROR: {e}"
        results[name] = out
        with open(os.path.join(OUTDIR, f"{name}.txt"), "w") as f:
            f.write(out)
        q.task_done()

threads = []
for _ in range(min(4, q.qsize())):
    t = threading.Thread(target=worker)
    t.daemon = True
    t.start()
    threads.append(t)

q.join()

# Simple HTML report
html_report = ["<html><head><meta charset='utf-8'><title>Recon Report</title></head><body>"]
html_report.append(f"<h1>Recon Report: {html.escape(TARGET_DOMAIN)}</h1>")
for name in results:
    html_report.append(f"<h2>{html.escape(name)}</h2><pre>{html.escape(results[name])}</pre>")
html_report.append("</body></html>")
with open(os.path.join(OUTDIR, "report.html"), "w") as f:
    f.write("\n".join(html_report))

print(f"Recon done. Report: {OUTDIR}/report.html")
