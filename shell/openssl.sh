# generate public/private key without password
openssl genrsa -out wogoo_private_key.pem 2048
# openssl rsa -in wogoo_private_key.pem -text
openssl pkcs8 -in wogoo_private_key.pem -topk8 -out wogoo_private_key_pkcs8.pem -inform PEM -outform PEM -nocrypt
# openssl pkcs8 -topk8 -inform PEM -outform DER -in wogoo_private_key.pem -nocrypt > wogoo_private_key.der
openssl rsa -in wogoo_private_key.pem -pubout -out wogoo_public_key.pem

# generate public/private key with password
# openssl genrsa -aes256 -passout pass:123456 -out wogoo_private_key.pem 2048
# openssl genrsa -aes256 -passout stdin -out wogoo_private_key.pem 2048
# openssl pkcs8 -in wogoo_private_key.pem -topk8 -out wogoo_private_key_pkcs8.pem -inform PEM -outform PEM
# openssl pkcs8 -in wogoo_private_key.pem -passin pass:123456 -topk8 -out wogoo_private_key_pkcs8.pem
# openssl rsa -in wogoo_private_key.pem -passin pass:123456 -pubout -out wogoo_public_key.pem
# openssl rsa -in wogoo_private_key.pem -passin stdin -pubout -out wogoo_public_key.pem
# openssl rsa -in wogoo_private_key.pem -pubout -out wogoo_public_key.pem

# generate self signed certificate
openssl genrsa -out server.key 1024
openssl req -new -key server.key -out server.csr
openssl x509 -req -in server.csr -out server.crt -signkey server.key -days 3650
