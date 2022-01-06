echo "Waiting until Nginx start..."; while ! curl http://localhost ; do sleep 2; done; echo "Done"
