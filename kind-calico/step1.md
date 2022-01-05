We're installing some dependencies in the background:

- go
- docker
- kubectl
- kind

Verify that kind is installed correctly: `kind --version`{{execute}}

Let's define our cluster:

```
cat <<EOF > cluster.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 30000
    hostPort: 80
    listenAddress: "127.0.0.1"
    protocol: TCP
  - containerPort: 30001
    hostPort: 443
    listenAddress: "127.0.0.1"
    protocol: TCP
  - containerPort: 30002
    hostPort: 15021
    listenAddress: "127.0.0.1"
    protocol: TCP
EOF
```{{execute}}

Now, we can pass this config file to the create our desired cluster (and give it a custom name):

`kind create cluster --config cluster.yaml`{{execute}}

And, poke around the cluster: `kubectl get all --all-namespaces`{{execute}}

Then, let's use Calico's YAML for our demo purposes: `kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml`{{execute}}

Lastly, We can delete our cluster: `kind delete cluster && unset KUBECONFIG`{{execute}}
