## installing dependencies
export KUBECONFIG=/etc/kubernetes/admin.conf \
&& kubectl delete -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml; \
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml \
&& alias k=kubectl \
&& kubectl get nodes \
&& kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml \
&& echo "K8S CLUSTER HAS BEEN PROVISIONED!" && echo
