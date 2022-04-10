# Attention, this makefile will install jenkins in the cleanest possible version.
# Read carefully before running.

TARGET=runjenkins
run:
	docker rm -f $(docker ps -a -q)
	docker volume rm $(docker volume ls -q)
	docker rmi -f jenkins:latest
run:
	docker build -t jenkins:latest . --no-cache
run:
	docker run --name jenkins --rm --detach \
      --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
      --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
      --publish 8080:8080 --publish 50000:50000 \
      --volume jenkins-data:/var/jenkins_home \
      --volume jenkins-docker-certs:/certs/client:ro \
      --mount type=bind,source=/Users/bernardo/git/groovy/backup/,target=/srv/backup \
      jenkins:latest