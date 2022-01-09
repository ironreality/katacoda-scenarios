Now let's create our first network policy.

Do you remember that any kubernetes object has its labels? :)

When we create a network policy we're effectively defining firewall rules. The main difference between "traditional" firewall rules and Kubernetes network policies is that k8s network policies attach their firewall rules using our pods' labels.

Let's take a look on our Gustbook pods' labels before we go further:

`kubectl get pods --show-labels`{{execute}}

Notice the 'app' labels in 'LABELS' column - their value is 'redis' for the redis pods and
'guestbook' for the frontend pods.

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
          app: guestbook
EOF
```{{execute}}

To attach the policy rules to the redis pods we used pod's labels as selector:

```yaml
spec:
  podSelector:
    matchLabels:
      app: redis
```

spec.ingress section defines matching for the incoming traffic we'd like to allow:
```
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: guestbook
```

Now apply the network policy:

`kubectl apply -f redis-netpolicy.yaml`{{execute}}

To check the network policy is applied let's login to our test pod and connect to the redis one more time:

`kubectl exec -i --tty busybox  -- sh`{{execute}}

`telnet redis-leader 6379`{{execute}}

As you can see - we cannont connect to the redis anymore. The network policy
works.

Also it does mean the **network policy works as kind of whitelisting rule - it
blocks any traffic except that we've allowed explicitly in the network policy manifest**

Now stop the telnet process and exit the test pod:
`^C`{{execute ctrl-seq}}
`exit`{{execute}}
