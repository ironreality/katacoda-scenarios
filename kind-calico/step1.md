We're installing some dependencies in the background:

- docker
- kind
- Calico CNI

Verify that kind is installed correctly: `kind --version`{{execute}}

Let's check our cluster's pods: `kubectl get pods --all-namespaces`{{execute}}
