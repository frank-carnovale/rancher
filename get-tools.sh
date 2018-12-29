#!/bin/sh

set -e

cd /scratch

rke_ver=v0.1.14
helm_ver=v2.12.1
rancher_cli_ver=v2.0.6
kubernetes_ver=v1.13.0
kubernetes_ver=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

target=/usr/local/bin

curl -LO https://github.com/rancher/rke/releases/download/$rke_ver/rke_linux-amd64
result='not new'
if diff -q rke_linux-amd64 $target/rke; then
    cp rke_linux-amd64 $target/rke
    chmod +x           $target/rke
    result=UPDATED
fi
printf '%-30s' "rke $result"
ls -l $target/rke

curl -LO https://storage.googleapis.com/kubernetes-release/release/$kubernetes_ver/bin/linux/amd64/kubectl
result='not new'
if diff -q kubectl $target/kubectl; then
    cp kubectl $target
    chmod +x   $target/kubectl
    result=UPDATED
fi
printf '%-30s' "kubectl $result"
ls -l $target/kubectl

curl -LO https://github.com/rancher/cli/releases/download/$rancher_cli_ver/rancher-linux-amd64-$rancher_cli_ver.tar.gz
mkdir rancher
cd rancher
tar zxf ../rancher-linux-amd64-*.tar.gz
result='not new'
if diff -q rancher-*/rancher $target; then
    cp rancher-*/rancher $target
    chmod +x             $target/rancher
    result=UPDATED
fi
printf '%-30s' "rancher $result"
ls -l $target/rancher
cd ..

curl -LO https://storage.googleapis.com/kubernetes-helm/helm-$helm_ver-linux-amd64.tar.gz
mkdir helm
cd helm
tar zxf ../helm-*-linux-amd64.tar.gz
if diff -q linux-amd64/helm $target; then
    cp linux-amd64/helm     $target
    chmod +x                $target/helm
    result=UPDATED
fi
printf '%-30s' "rancher $result"
ls -l $target/rancher
if diff -q linux-amd64/tiller $target; then
    cp linux-amd64/tiller     $target
    chmod +x                  $target/helm
    result=UPDATED
fi
printf '%-30s' "tiller $result"
ls -l $target/tiller
cd ..

