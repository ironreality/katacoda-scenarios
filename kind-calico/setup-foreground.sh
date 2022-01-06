while ! curl --silent http://localhost > /dev/null; do echo "Waiting until Nginx start..."; sleep 2; done; echo "Done"
