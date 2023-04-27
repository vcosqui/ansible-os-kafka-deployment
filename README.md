# Kafka cluster deployment

Install a Zookeeper and a Kafka cluster using ansible

## Prerequisites
* 6 Ubuntu hosts, 3 for Zookeeper, 3 for Kafka (Tested with 18.04)
* A ssh key to connect to the hosts
* Ansible binaries installed (Tested with 2.12.10)
```shell
apt-add-repository ppa:ansible/ansible
apt update
apt install ansible
```

## Instructions
1. Edit `hosts` file to put the right ip address of your inventory.
2. Set the location of the ssh private key in env var `ANSIBLE_KEY_FILE`
3. Test connectivity with command
```shell
make ping-hosts
```
4. Install Zookeeper with command
```shell
make install-zookeeper
```
5. Test Zookeeper cluster status with command
```shell
make test-zookeeper
```