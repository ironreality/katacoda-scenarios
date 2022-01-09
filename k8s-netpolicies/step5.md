Now create a network policy for our frontend application.
We need to allow traffic to the frontend pods from our ingress-controller i.e. nginx.

Let's view what labels has nginx - it's deployed in ingress-nginx namespace:

`kubectl get pods -n ingress-nginx --show-labels`{{execute}}

Label **app.kubernetes.io/name=ingress-nginx** seems reasonable to match the
nginx's traffic.

Now create a network policy allowing network traffic to 'frontend' pods from 'ingress-nginx-controller' pods:

```
cat <<EOF >frontend-netpolicy.yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: guestbook
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: ingress-nginx
EOF
```{{execute}}

Now apply the network policy again:

`kubectl apply -f frontend-netpolicy.yaml`{{execute}}

To check out Guestbook open this URL: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

We can open Guestbook and that's fine but it's just our browser's cash. Trying to refresh the page you see - despite we've created the network policy we can't open Guestbook's index page anymore. What's wrong here? The issue is our nginx which was deployed into another namespace which is 'ingress-nginx'. And we should reflect that in our frontend's network policy.

Now re-create the frontend's network policy:

```
cat <<EOF >frontend-netpolicy.yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: frontend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: guestbook
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          app.kubernetes.io/name: ingress-nginx
      podSelector:
        matchLabels:
          app.kubernetes.io/name: ingress-nginx
EOF
```{{execute}}

The difference between the two network policy variants is namespaceSelector subsection of the ingress rule:

```
namespaceSelector:
  matchLabels:
    app.kubernetes.io/name: ingress-nginx
```

Now apply the network policy:

`kubectl apply -f frontend-netpolicy.yaml`{{execute}}

Check the Guestbook again: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/
Congratulations! It's refreshable again.


