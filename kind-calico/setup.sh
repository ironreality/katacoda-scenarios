echo "Installing dependencies..."
echo "Installing go..."
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

echo "DEPS WERE INSTALLED!!!"

echo "Creating kind cluster..."
kind create cluster --config cluster.yaml
echo

echo "Installing Calico CNI..."
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
