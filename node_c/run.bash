#!/bin/bash

python3 peer_node.py \
	  --name C --listen 192.168.122.147 5003 \
	  --peers A@192.168.122.80:5001 B@192.168.122.189:5002 D@192.168.122.176:5004  \
	  --logger 192.168.122.15 5000 \
	  --offset-ms 600 \

