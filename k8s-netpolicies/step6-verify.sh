#!/bin/bash

kubectl exec -i --tty busybox -- nc -z -w 3 redis-leader 6379 && echo "done"
