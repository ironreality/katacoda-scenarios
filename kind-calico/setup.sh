## installing dependencies
## go (via https://github.com/travis-ci/gimme)
eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=stable bash)" \
&& export PATH=$PATH:$HOME/go/bin

apt-get --quiet update \
&& apt-get --quiet install -y apt-transport-https \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get --quiet update \
&& apt-get --quiet install -y kubectl \
&& go get -u -v sigs.k8s.io/kind \
&& kind create cluster --config cluster.yaml \
&& kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
