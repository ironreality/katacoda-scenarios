Now create a network policy allowing network traffic to 'redis' pods from 'guestbook' pods

```
cat <<EOF >redis-netpolicy.yaml
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: redis
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: redis
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: test
EOF
```{{execute}}

To allow incoming traffic from the test pod we need to select the pod using one from its
labels as the selector.

```
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: test
```

After the edit apply the network policy:

`kubectl apply -f redis-netpolicy.yaml`{{execute}}
