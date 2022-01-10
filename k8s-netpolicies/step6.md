Now the challenge time!

To pass this scenario's step you should modify 'redis' network policy to allow
traffic from the test pod.

**Hint:** the policy manifest is inside redis-netpolicy.yaml file. You might try
to edit it using nano or vim.

To check the redis connection login to the test pod and run the next command:

`kubectl exec -i --tty busybox  -- sh`{{execute}}

`telnet redis-leader 6379`{{execute}}

To exit from the test pod run the next commands:
`^C`{{execute ctrl-seq}}
`exit`{{execute}}
