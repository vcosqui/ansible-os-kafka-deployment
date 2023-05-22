# Kafka cluster deployment

Install a Zookeeper and a Kafka cluster using ansible

## Prerequisites
* 6 Ubuntu hosts, 3 for Zookeeper, 3 for Kafka (Tested with 18.04)
* A ssh key to connect to the hosts
* Ansible binaries installed (Tested with 2.12.10)
```shell
apt-add-repository ppa:ansible/ansible
apt update
apt install make
apt install ansible
```
* Kafkacat cli tool to test
```shell
apt install kafkacat
```

## Instructions
1. Install Azure.Azcollection inventory plugin
```shell
ansible-galaxy collection install azure.azcollection:1.11.0 && \
pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
```
2. Set the azure credentials env vars
```shell
 export AZURE_CLIENT_ID=***
 export AZURE_SECRET=***
 export AZURE_TENANT=***
 export AZURE_SUBSCRIPTION_ID=***
 
```
3. Check available inventory
```shell
make list-inventory

```
3. Set the location of the ssh private key in env var `ANSIBLE_KEY_FILE`
