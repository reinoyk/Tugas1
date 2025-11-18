#!/bin/bash

python3 peer_node.py \
	  --name B --listen 192.168.122.189 5002 \
	  --peers A@192.168.122.80:5001 C@192.168.122.147:5003  D@192.168.122.176:5004  \
	  --logger 192.168.122.15 5000 \
	  --offset-ms 600 \

