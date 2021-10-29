build:
	sudo podman build -f ./images/server1/Dockerfile -t fedora-mailserver-tom .
	sudo podman build -f ./images/server2/Dockerfile -t fedora-mailserver-jerry .
	sudo podman build -f ./images/dns/Dockerfile -t fedora-mailserver-dns .

network:
	sudo podman network create --subnet 192.168.2.0/29 mailservers-network-dns
	sudo podman network create --subnet 192.168.2.8/29 mailservers-network-toms-domain
	sudo podman network create --subnet 192.168.2.16/29 mailservers-network-jerrys-domain

iptables_rules:
	sudo iptables -F CNI-FORWARD
	sudo iptables -A CNI-FORWARD -p all -d 192.168.2.10 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A CNI-FORWARD -p all -s 192.168.2.10 -j ACCEPT
	sudo iptables -A CNI-FORWARD -p all -d 192.168.2.2 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A CNI-FORWARD -p all -s 192.168.2.2 -j ACCEPT
	sudo iptables -A CNI-FORWARD -p all -d 192.168.2.18 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -A CNI-FORWARD -p all -s 192.168.2.18 -j ACCEPT

run:
	sudo podman stop -a
	sudo podman container prune
	sudo podman run -d -p :53/tcp -p :53/udp --name=cont-fedora-mailserver-dns --network mailservers-network-dns --cap-add=CAP_NET_ADMIN -t fedora-mailserver-dns
	sudo podman run -d --hostname=tom.first-domain.com -p :53/tcp -p :53/udp -p :25 -p :8891 --name=cont-fedora-mailserver-tom --network mailservers-network-toms-domain --cap-add=CAP_NET_ADMIN -t fedora-mailserver-tom
	sudo podman run -d --hostname=jerry.second-domain.com -p :53/tcp -p :53/udp -p :25 -p :8891 -p 9900:110 -p 9901:995 --name=cont-fedora-mailserver-jerry --network mailservers-network-jerrys-domain --cap-add=CAP_NET_ADMIN -t fedora-mailserver-jerry
