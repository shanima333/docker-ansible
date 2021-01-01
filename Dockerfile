FROM alpine:3.8

RUN apk update && apk upgrade

RUN \
apk add \
curl \
python \
py-pip \
py-boto \
py-dateutil \
py-httplib2 \
py-jinja2 \
py-paramiko \
py-setuptools \
py-yaml \
openssh-client \
bash \
tar && \
pip install --upgrade pip

RUN pip install ansible 
 
RUN mkdir /etc/ansible /ansible

RUN \
    echo "[amazon]" >> /etc/ansible/hosts && \
    echo "3.21.156.96  ansible_user="ec2-user" ansible_port=2222 ansible_ssh_private_key_file="ohio.pem"" >> /etc/ansible/hosts

RUN mkdir /ansible/playbooks

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

WORKDIR /ansible/playbooks

ENTRYPOINT ["ansible-playbook"]
