We're installing some dependencies in the background:

- [kind](https://kind.sigs.k8s.io/) (k8s cluster distribution)
- nginx as ingress-controller

**The cluster provisioning takes from 4 to 7 minutes.**

After the cluster is deployed let's check our cluster's pods: `kubectl get pods --all-namespaces`{{execute}}
Now, let's deploy a sample app called Guestbook

`kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/kubernetes-engine-samples/main/guestbook/all-in-one/guestbook-all-in-one.yaml -f ingress.yaml`{{execute}}

Now wait until Guestbook is deployed - all the pods should be **READY** and in **Running** state: `kubectl get pods`{{execute}}

Let's deploy a test pod to check network connections:

`kubectl run -i --tty busybox --image=busybox --labels app=test -- sh`{{execute}}
