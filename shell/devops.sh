# curl encoding
iconv -l
iconv -f gb2312 -t utf-8

# test nginx gzip compress
curl -I -H "Accept-Encoding: gzip, deflate" "https://www.plantlink.cn"

# upload image to baidu
curl -i -F 'image=@3.jpg' 'http://image.baidu.com/pictureup/uploadshitu?pos=upload&uptype=upload_pc&fm=index'
curl -i -F 'image=@3.jpg' 'http://image.baidu.com/pictureup/uploadshitu?pos=upload&uptype=upload_pc&fm=index' -L

# access through proxy server
curl -x <proxy-ip>:<proxy-port> www.baidu.com

# format directory
tree
tree -a
tree -L 3
tree d
tree tree -P '*Contain*' --prune
tree -I '*NotContain*' --prune

# format json
echo '' | jq .

# base64
echo '' | base64
echo '' | base64 -D

# hash
echo '' | md5
echo '' | shasum
# echo '' | openssl sha1
echo '' | shasum -a 256
# echo '' | openssl dgst -sha256
# alias sha256="openssl dgst -sha256"

# unicode encode/decode
native2ascii
native2ascii -reverse

# urlencode/urldecode
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

# ngrok
~/Downloads/ngrok http 8888
# inspect traffic
http://localhost:4040

# dns
dig @<dns-server-ip> +trace

# stress test
ab -n 1000 -c 100 -v 2 [-H "<header>"] <url>

# maven
# list jar dependency
mvn dependency:tree -Dincludes=<groupId>:<artifactId>

# calculate gzip compression ratio
gzip -cv <file-name> > /dev/null

# gzip
gzip x.txt
gzip -d x.txt.gz

# file system
fdisk -l
fdisk <raw-device>
mkfs -t ext3 <partition-device>
mount
mount <partition-device> <mount-point>
echo "<partition-device> <mount-point> ext3 defaults 0 0" >> /etd/fstab
umount <partition-device>
fsck -t ext3 <partition-device>
badblocks -v <partition-device>

# monitor
lsof -i tcp:port
yum install -y dstat
dstat 5
dstat --top-mem --top-io --top-cpu
yum install -y mtr
mtr -v
top -n <refresh-times>
top -Hp <pid>

# tuning
jps
jstat -gcutil <pid> [cycle]
jmap -heap <pid>
jmap -histo:live <pid>
jmap -dump:file=<dump-file>,format=b <pid>
jstack -l <pid>
jstack -m <pid>
jstack -F <pid>
jcmd

# CPU 100% & Full GC problem
# check cpu and thread
top -Hp <pid> 
# convert thread id to hex
# printf "%x\n" 10
# user thread
jstack <pid>
# vm thread
jstat -gcutil <pid> <period> <times>
jmap dump:format=b,file=<filepath> <pid>
mat

# common used
chown -R colddew[:admin] <path>
chgrp -R admin <path>
ulimit -a
find / -name <file-name>
tar -zcvf <zip-file-name>.tar.gz <zip-path>
tar -zxvf <zip-file-name>.tar.gz
df -h
du -h .
grep [-ivnc] '<search-content>' <file-name>
sort [-ntkr] <file-name>
# cat uniq.txt | sort | uniq
diff -r <first-file> <second-file> | diffstat

# conditional lookup
du -sh * | sort -nr | head
du --max-depth=1
du -lh --max-depth=1
du -h --max-depth=1 / 
find / -size +204800
find ./ -size +2048c -type f
find ./ -size -2048c
find ./ -size +100M -type f
find -type f | wc -l

# read large file
head -10000 /var/lib/mysql/slowquery.log > temp.log
tail -10000 /var/lib/mysql/slowquery.log > temp.log
sed -n '10,10000p' /var/lib/mysql/slowquery.log > temp.log

# count file quantity under current path
ls -l | grep "^-" | wc -l
# count folder quantity under current path
ls -l | grep "^d" | wc -l
# count file quantity under all path
ls -lR | grep "^-" | wc -l
# count folder quantity under all path
ls -lR | grep "^d" | wc -l

# modify created time of file
GetFileInfo <file-name>
Setfile -d "06/01/2019 01:00:00" <file-name>

# query port by pid
netstat -nap | grep <pid>
# query process by port
netstat -tunlp | grep <port>

# SecureCRT upload & download
# server receive & send
yum -y install lrzsz
rz
sz

# modify file datetime
touch -mt 201909052248 <filename>

# awk
awk '{print $4}' <log-file-name>.log | sort | uniq -c | sort -nr | head -n 10
cat <log-file-name>.log | awk '{print $(NF-2)}' | sort | uniq -c | sort -nr | head -n 10
netstat -tun | grep 6379 | awk '{print $5}' | awk -F':' '{print $1}' | sort | uniq -c

# ssh
ssh-keygen -t rsa
mv id_rsa.pub x.x.x.x_id_rsa.pub
mv x.x.x.x_id_rsa.pub root@<remote-ip>:/root
# remote machine
cd ~/.ssh
cat x.x.x.x_id_rsa.pub >> authorized_keys

# logrotate
# /etc/cron.daily/logrotate
#  /etc/logrotate.d/
# /usr/sbin/logrotate -vf /etc/logrotate.d/nginx

/usr/local/nginx/logs/www.wogoo.log
/usr/local/nginx/logs/api.wogoo.log
# /usr/local/nginx/logs/access.log
# /usr/local/nginx/logs/error.log
{
    # create 0644 nginx nginx
    daily
    rotate 30
    missingok
    dateext
    notifempty
    compress
    # delaycompress
    sharedscripts
    postrotate
        /bin/kill -USR1 `cat /usr/local/nginx/logs/nginx.pid 2>/dev/null` 2>/dev/null || true

        # [ -e /usr/local/nginx/logs/nginx.pid ] && kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`

        # if [ -f /var/run/nginx.pid ]; then
        #     kill -USR1 `cat /var/run/nginx.pid`
        # fi
    endscript
}


