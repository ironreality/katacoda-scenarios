By default Kubernets doesn't run any netwrok policies.

It does mean in the default k8s setup we can access **any pod from any pod** without any restriction.

Let's check it - we'll spawn a shell in a test pod and connect to our Guestbook's
redis service:

`kubectl run -i --tty busybox --image=busybox -- sh`{{execute}}

`telnet redis-leader 6379`{{execute}}

As you can see - we can connect to the redis using telnet.

Now exit the test pod: `exit`{{execute}}
