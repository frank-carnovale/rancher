:

report='
date

echo -e "
__________
CONTAINERS"
docker ps

echo -e "
_____
NODES"
kubectl get nodes

echo -e "
____
PODS"
kubectl get pods --all-namespaces
'

watch "$report"
