#!/bin/bash

python3 peer_node.py \
	  --name D --listen 192.168.122.176 5004 \
	  --peers A@192.168.122.80:5001 B@192.168.122.189:5002 C@192.168.122.147:5003 \
	  --logger 192.168.122.15 5000 \
	  --offset-ms 600 \

