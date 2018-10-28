#!/bin/sh

docker rm -f $(docker ps -qa)

docker volume rm $(docker volume ls -q)
docker image prune -f

cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico /host/rancher"
for dir in $cleanupdirs; do
  rm -rf $dir
done

umount $(df | awk '/kubelet/ {print $6}')

rm -rf /var/log/containers/*

echo cleaned up rancher.

