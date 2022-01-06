#!/bin/bash

set -o errexit
set -o nounset

echo "Installing dependencies..."
## go (via https://github.com/travis-ci/gimme)
eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=stable bash)" \
&& export PATH=$PATH:$HOME/go/bin
echo

## kubectl
apt-get update \
&& apt-get install -y apt-transport-https \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubectl \
&& go get -u -v sigs.k8s.io/kind
echo

echo "Creating configuration for the kind cluster..."
# kind cluster configuration
cat>cluster.yaml<<EOF
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

echo "Creating kind cluster..."
kind create cluster --config cluster.yaml
echo

echo "Installing Calico CNI..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
