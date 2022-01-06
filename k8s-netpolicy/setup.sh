## installing dependencies
echo "Waiting for k8s start..."; while [ ! -f /etc/kubernetes/admin.conf ] ; do sleep 2; done; sleep 60; echo \
&& export KUBECONFIG=/etc/kubernetes/admin.conf \
&& kubectl delete -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml; \
&& kubectl delete ds kube-flannel-ds-amd64; \
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml \
&& alias k=kubectl \
&& echo "K8S CLUSTER HAS BEEN PROVISIONED!" && echo
