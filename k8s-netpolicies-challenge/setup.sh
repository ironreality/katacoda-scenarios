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
&& curl -L --remote-name-all https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz{,.sha256sum} \
&& sha256sum --check cilium-linux-amd64.tar.gz.sha256sum \
&& sudo tar xzvfC cilium-linux-amd64.tar.gz /usr/local/bin \
&& rm cilium-linux-amd64.tar.gz{,.sha256sum} \
&& cilium install \
&& kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml \
&& kubectl patch service -n ingress-nginx ingress-nginx-controller --patch '{"spec": { "ports": [{"name":"http", "port":80, "nodePort":30000}, {"name":"https", "port":443, "nodePort":30001}]}}' \
&& kubectl apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/kubernetes-engine-samples/main/guestbook/all-in-one/guestbook-all-in-one.yaml -f ingress.yaml \
&& kubectl run -i --tty busybox --image=busybox --labels app=test -- sh \
&& echo "K8S CLUSTER HAS BEEN PROVISIONED!" && echo
