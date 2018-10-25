#!/bin/bash

API_TOKEN=`cat hetzner_crawler_api_key.txt`
AUTH_HEADER="Authorization: Bearer ${API_TOKEN}"
CONTENT_TYPE="Content-Type: application/json"

curl -s -X POST -H "${CONTENT_TYPE}" -H "${AUTH_HEADER}" -d '{"name": "crawler-test", "server_type": "cx51", "location": "nbg1", "start_after_create": true, "image": "ubuntu-18.04", "ssh_keys": ["m"]}' https://api.hetzner.cloud/v1/servers -o curl_out.txt
SERVER_ID=`cat curl_out.txt | jq '.server.id'`

for i in {1..10}
do
	sleep 5s
	STATUS=`curl -s -H "${AUTH_HEADER}" https://api.hetzner.cloud/v1/servers/${SERVER_ID} | jq '.server.status'`
	READY_STATUS='"running"'

	echo "Server status: ${STATUS}"

	if [ "$STATUS" == "$READY_STATUS" ]; then
		break
	fi
done

echo "SUCCESS"