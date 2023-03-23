.PHONY: default all clean

default: all

all:
	docker compose up -d
	sudo sysctl -p
	sudo ovs-vsctl add-br ovsbr
	sudo ovs-docker add-port ovsbr eth1 R1 --ipaddress=172.20.0.2/16
	sudo ovs-docker add-port ovsbr eth1 R2 --ipaddress=172.20.0.3/16
	sudo ovs-docker add-port ovsbr eth1 R3 --ipaddress=172.20.0.4/16

clean:
	docker compose down
	sudo ovs-vsctl del-br ovsbr
	docker network prune -f
	sudo systemctl restart docker