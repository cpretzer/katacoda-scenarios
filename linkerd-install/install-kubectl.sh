#! /bin/bash

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl
chmod 755 kubectl
mv kubectl /usr/bin