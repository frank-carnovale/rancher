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
kubectl get nodes 2>/dev/null

echo -e "
____
PODS"
kubectl get pods --all-namespaces -o wide 2>/dev/null

echo -e "
________
SERVICES"
kubectl get services --all-namespaces 2>/dev/null

echo -e "
___________
DEPLOYMENTS"
kubectl get deployments --all-namespaces 2>/dev/null

#echo -e "
#______
#EVENTS"
#kubectl get events --all-namespaces -o=custom-columns=LATEST:.lastTimestamp,COUNT:.count,TYPE:.type,MESSAGE:.message --sort-by=.lastTimestamp 2>/dev/null
'

# -d ?
watch -t "$report"
