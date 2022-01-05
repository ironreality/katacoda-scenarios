## installing dependencies
kubectl delete -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml \
&& kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
