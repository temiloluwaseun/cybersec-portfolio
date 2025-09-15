# linux_cheats.md

## Processes
ps aux | less
top
htop        # if installed
kill <pid>
kill -9 <pid>

## Files & permissions
ls -la
chmod 640 secret.txt
chown user:group file

## Search & text processing
find / -type f -name "*.conf" 2>/dev/null
grep -R "TODO" ~/projects
awk '{print $1}' file.csv | head
sed -n '1,60p' file.txt

## Networking
ip a
ip route
ss -tulpn
nc -vz example.com 80

