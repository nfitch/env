env
===

Development Environment

openssl aes-128-cbc -in ./home.b64 -out /tmp/home.tar.gz -d -a -pass stdin
tar -xvf /tmp/home.tar.gz
