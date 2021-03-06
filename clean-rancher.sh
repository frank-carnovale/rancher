#!/bin/sh

ctrs=$(docker ps -qa 2>/dev/null)
if [ "$ctrs" ]; then
    echo removing containers..
    docker rm -f $ctrs
else
    echo "no containers left"
fi

vols=$(docker volume ls -q 2>/dev/null)
if [ "$vols" ]; then
    echo removing volumes..
    docker volume rm $vols
else
    echo "no volumes left"
fi

echo pruning images..
docker image prune -f

cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico /var/log/contaiers /var/log/pods"
for dir in $cleanupdirs; do
    if [ -d $dir ]; then
        echo removing $dir..
        rm -rf $dir
    fi
done

mounts=$(df | awk '/kubelet/ {print $6}')
if [ -n "$mounts" ]; then
    echo unmounting all kubelets..
    umount $mounts
fi

echo I have cleaned up the mess that rancher made.

