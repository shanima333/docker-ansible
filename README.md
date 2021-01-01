# Dockefile to execute ansible yaml file through a container

Files:
- site.yaml
- key file (ohio.pem)
- Dockerfile

1) build image using 

docker build -t ansible:1 .

2) create container using 

docker container run --name ansible -v $(pwd)/ansible:/ansible/playbooks/ ansible:1 site.yaml
