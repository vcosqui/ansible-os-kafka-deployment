.PHONY: *
SHELL := /bin/bash
.DEFAULT_GOAL := help


ANSIBLE_KEY_FILE ?= $(ANSIBLE_KEY_FILE) ## Location of hosts private key for ssh connection

list-inventory: ## Lists the ansible inventory
	@ansible-inventory -i kafka_azure_rm.yml --graph

ping-hosts: check-env ## Pings all hosts in inventory to verify connectivity
	@ansible all -m ping -i kafka_azure_rm.yml

install-zookeeper: check-env ## Installs a Zookeeper cluster in the inventory nodes
	@ansible-galaxy install sleighzy.zookeeper
	@ansible-playbook zookeeper.yaml -i kafka_azure_rm.yml

test-zookeeper: check-env ## Tests Zookeeper cluster status
	@ansible zookeeper_nodes -m shell -a '{ echo "stat"; sleep 1; } | telnet localhost 2181 | grep Mode' -i kafka_azure_rm.yml

install-kafka: check-env ## Installs a Kafka cluster in the inventory nodes
	@ansible-galaxy install sleighzy.kafka
	@ansible-playbook kafka.yaml -i kafka_azure_rm.yml

kafka-produce: ## produces one messages to `test` topic
	@echo "test message" |  kafkacat -b kafka1 -t test -P

kafka-consume: ## consume messages from `test` topic
	@kafkacat -b kafka1 -t test

check-env:
ifndef ANSIBLE_KEY_FILE
	$(error ANSIBLE_KEY_FILE is undefined, please set it to the path where the host priv key is present)
endif

help: ## show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 4` Make Variables `tput sgr0`───────────────────────────────\n"
	@sed -ne "/@sed/!s/\(.*\)?=\(.*\)##\(.*\)/`tput setaf 4``tput bold`\1:`tput setaf 5`\2`tput sgr0`\3/p" $(MAKEFILE_LIST)
	@printf "───────────────────────────────────────────────────────────────────────\n"