We're installing some dependencies in the background:

- [kind](https://kind.sigs.k8s.io/) (k8s cluster distribution)
- CNI with network policy support ([Cilium](https://cilium.io/))
- nginx as ingress-controller

**The cluster provisioning takes from 4 to 7 minutes.**

After the cluster is deployed let's check our cluster's pods: `kubectl get pods --all-namespaces`{{execute}}
