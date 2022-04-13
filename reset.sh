docker stop -t=10 jenkins
docker volume rm jenkins-data
docker volume rm jenkins-docker-certs
docker rmi -f jenkins:latest
docker build -t jenkins:latest . --no-cache