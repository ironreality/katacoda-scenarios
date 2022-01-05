## installing dependencies
## go (via https://github.com/travis-ci/gimme)
eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=stable bash)" \
&& export PATH=$PATH:$HOME/go/bin

apt-get update \
&& apt-get install -y apt-transport-https \
&& curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
&& echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubectl \
&& go get -u -v sigs.k8s.io/kind \
&& kind create cluster --config cluster.yaml \
&& kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml \
&& kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml \
&& alias k=kubectl \
&& kubectl patch service -n ingress-nginx ingress-nginx-controller --patch '{"spec": { "ports": [{"name":"http", "port":80, "nodePort":30000}, {"name":"https", "port":443, "nodePort":30001}]}}'
