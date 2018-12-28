#!/bin/sh

set -e

cd /scratch

echo rke..
rke_ver=v0.1.14
curl -LO https://github.com/rancher/rke/releases/download/$rke_ver/rke_linux-amd64

echo kubetcl..
kubernetes_ver=v1.13.0
kubernetes_ver=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO https://storage.googleapis.com/kubernetes-release/release/$kubernetes_ver/bin/linux/amd64/kubectl

echo rancher-cli..
rancher_cli_ver=v2.0.6
curl -LO https://github.com/rancher/cli/releases/download/$rancher_cli_ver/rancher-linux-amd64-$rancher_cli_ver.tar.gz
mkdir rancher
cd rancher
tar zxf ../rancher-linux-amd64-*.tar.gz
cd ..

echo helm..
helm_ver=v2.12.1
curl -LO https://storage.googleapis.com/kubernetes-helm/helm-$helm_ver-linux-amd64.tar.gz
mkdir helm
cd helm
tar zxf ../helm-*-linux-amd64.tar.gz
cd ..

ls -lR

