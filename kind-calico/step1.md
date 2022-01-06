We're installing some dependencies in the background:

- kind (k8s cluster distribution)
- Container Network Interface (CNI) supporting NetworkPolicies
- nginx

**The cluster provisioning takes from 4 to 7 minutes.**

After the cluster is deployed let's check our cluster's pods: `kubectl get pods --all-namespaces`{{execute}}
