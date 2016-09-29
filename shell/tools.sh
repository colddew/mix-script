# curl encoding
iconv -l
iconv -f gb2312 -t utf-8

# format directory
tree

# format json
jq

# unicode encode/decode
native2ascii
native2ascii -reverse

# ngrok
~/Downloads/ngrok http 8888
# inspect traffic
http://localhost:4040

# dns
dig @<dns-server-ip> +trace

# list jar dependency
mvn dependency:tree -Dincludes=`<groupId>`:`<artifactId>`
