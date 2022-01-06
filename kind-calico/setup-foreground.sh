date; echo "Waiting until Nginx start..."; while ! curl --silent http://localhost > /dev/null; do sleep 5; done; date; echo "Done"
