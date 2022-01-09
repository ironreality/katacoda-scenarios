Now let's create our first network policy.

Do you remember that any kubernetes object has its labels? :)
When we create a network policy we're effectively defining firewall rules. One main difeerence between "traditional" firewall rules and Kubernetes network policies is that k8s network policies attach their rules using our pods' labels. Let's take a look on our Gustbook pods' labels before we go further:

`kubectl get pods --show-labels`{{execute}}

Notice the 'app' labels - their value is 'redis' for the redis pods and
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

To attach the policy rules to the redis pods we used pod's labels as 'selector':

```yaml
spec:
  podSelector:
    matchLabels:
      app: redis
```

To check the network policy is applied let's login to our test pod and connect to the redis one more time:

`kubectl exec -i --tty busybox  -- sh`{{execute}}

`telnet redis-leader 6379`{{execute}}

As you can see - we cannont connect to the redis anymore. The network policy
works.

Now exit the test pod: `exit`{{execute}}
