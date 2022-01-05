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
