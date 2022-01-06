By default Kubernets doesn't run any netwrok policies.

It does mean we can access **any pod from any pod** without any restriction.

Let's check it - we'll spawn a shell in a pod and connect to our Guestbook's
frontend service:

`kubectl run -i --tty busybox --image=busybox -- sh`{{execute}}

`curl frontend`{{execute}}

As you can see - we can curl Guestbook's index page.

Now exit the test pod: `exit`{{execute}}
