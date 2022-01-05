We're installing some dependencies in the background:

- docker
- kind
- Calico CNI

Verify that kind is installed correctly: `kind --version`{{execute}}

And, poke around the cluster: `kubectl get pods --all-namespaces`{{execute}}

Lastly, We can delete our cluster: `kind delete cluster && unset KUBECONFIG`{{execute}}
