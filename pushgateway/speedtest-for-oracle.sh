#!/bin/bash

# Run speedtest-cli and capture the output in JSON format
OUTPUT=$(speedtest-cli --json)

# Parse the JSON output using jq
DOWNLOAD=$(echo $OUTPUT | jq .download)
UPLOAD=$(echo $OUTPUT | jq .upload)
PING=$(echo $OUTPUT | jq .ping)
SERVER=$(echo $OUTPUT | jq -r .server.host)

# Print parsed results for debugging
echo "Download: $DOWNLOAD"
echo "Upload: $UPLOAD"
echo "Ping: $PING"
echo "Server: $SERVER"

# Define the Pushgateway URL
PUSHGATEWAY_URL="http://localhost:9091/metrics/job/speedtest"

# Send the data to the Pushgateway
cat <<EOF | curl --data-binary @- $PUSHGATEWAY_URL
# TYPE download_speed gauge
download_speed $DOWNLOAD
# TYPE upload_speed gauge
upload_speed $UPLOAD
# TYPE ping_latency gauge
ping_latency $PING
EOF
