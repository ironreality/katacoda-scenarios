We're installing some dependencies in the background:

- [kind](https://kind.sigs.k8s.io/) (k8s cluster distribution)
- nginx
- Guestbook sample web app
- a test pod running shell

**The cluster provisioning takes from 4 to 7 minutes.**

Wait until Guestbook is deployed - all the pods should be **READY** and in **Running** state.

Now create network policies for 'frontend' and 'redis' pods.
