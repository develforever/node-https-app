#!/bini/bash


if [ ! -f certs/rootCA.crt ]; then
    openssl genpkey -algorithm RSA -out certs/rootCA.key -pkeyopt rsa_keygen_bits:4096
    openssl req -x509 -new -nodes -key certs/rootCA.key -sha256 -days 3650 -out certs/rootCA.crt -config root_ca.conf
fi

openssl genpkey -algorithm RSA -out certs/server.key -pkeyopt rsa_keygen_bits:2048
openssl req -new -key certs/server.key -out certs/server.csr -config server.conf

openssl x509 -req -in certs/server.csr -CA certs/rootCA.crt -CAkey certs/rootCA.key -CAcreateserial -out certs/server.crt -days 825 -sha256 -extfile server.conf -extensions v3_req

