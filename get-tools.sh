#!/bin/sh

set -e

cd /scratch
[ -z "$(ls -A)" ] || { echo 'work dir non-empty; bailing' && exit 1; }

rke_ver=v0.1.14
helm_ver=v2.12.1
rancher_cli_ver=v2.0.6
kubernetes_ver=v1.13.0
kubernetes_ver=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

target=/usr/local/bin

curl -sLO https://github.com/rancher/rke/releases/download/$rke_ver/rke_linux-amd64
result='not new'
if ! diff -q rke_linux-amd64 $target/rke; then
    cp rke_linux-amd64       $target/rke
    chmod +x                 $target/rke
    result=UPDATED
fi
printf '%-10s %-10s %-10s ' rke $rke_ver "$result"
ls -l $target/rke

curl -sLO https://storage.googleapis.com/kubernetes-release/release/$kubernetes_ver/bin/linux/amd64/kubectl
result='not new'
if ! diff -q kubectl $target/kubectl; then
    cp kubectl       $target
    chmod +x         $target/kubectl
    result=UPDATED
fi
printf '%-10s %-10s %-10s ' kubectl $kubernetes_ver "$result"
ls -l $target/kubectl

curl -sLO https://github.com/rancher/cli/releases/download/$rancher_cli_ver/rancher-linux-amd64-$rancher_cli_ver.tar.gz
mkdir rancher
cd rancher
tar zxf ../rancher-linux-amd64-*.tar.gz
result='not new'
if ! diff -q rancher-*/rancher $target; then
    cp rancher-*/rancher       $target
    chmod +x                   $target/rancher
    result=UPDATED
fi
printf '%-10s %-10s %-10s ' rancher $rancher_cli_ver "$result"
ls -l $target/rancher
cd ..

curl -sLO https://storage.googleapis.com/kubernetes-helm/helm-$helm_ver-linux-amd64.tar.gz
mkdir helm
cd helm
tar zxf ../helm-*-linux-amd64.tar.gz
result='not new'
if ! diff -q linux-amd64/helm $target; then
    cp linux-amd64/helm       $target
    chmod +x                  $target/helm
    result=UPDATED
fi
printf '%-10s %-10s %-10s ' helm $helm_ver "$result"
ls -l $target/rancher
result='not new'
if ! diff -q linux-amd64/tiller $target; then
    cp linux-amd64/tiller       $target
    chmod +x                    $target/helm
    result=UPDATED
fi
printf '%-10s %-10s %-10s ' tiller $helm_ver "$result"
ls -l $target/tiller
cd ..

