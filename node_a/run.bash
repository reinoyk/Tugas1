#!/bin/bash

python3 peer_node.py \
	  --name A --listen 192.168.122.80 5001 \
	  --peers B@192.168.122.189:5002 C@192.168.122.147:5003  D@192.168.122.176:5004  \
	  --logger 192.168.122.15 5000 \
	  --offset-ms 600 \
	  --initiate-broadcast --msg "Hello from A"

