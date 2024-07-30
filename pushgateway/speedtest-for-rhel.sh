#!/bin/bash

# Run speedtest-cli and capture the output in JSON format
OUTPUT=$(speedtest -f json)

# Parse the JSON output using jq for download
DOWNLOAD_BANDWIDTH=$(echo $OUTPUT | jq .download.bandwidth)
DOWNLOAD_BYTES=$(echo $OUTPUT | jq .download.bytes)
DOWNLOAD_ELAPSED=$(echo $OUTPUT | jq .download.elapsed)
DOWNLOAD_LATENCY_IQM=$(echo $OUTPUT | jq .download.latency.iqm)
DOWNLOAD_LATENCY_LOW=$(echo $OUTPUT | jq .download.latency.low)
DOWNLOAD_LATENCY_HIGH=$(echo $OUTPUT | jq .download.latency.high)
DOWNLOAD_LATENCY_JITTER=$(echo $OUTPUT | jq .download.latency.jitter)

# Parse the JSON output using jq for upload
UPLOAD_BANDWIDTH=$(echo $OUTPUT | jq .upload.bandwidth)
UPLOAD_BYTES=$(echo $OUTPUT | jq .upload.bytes)
UPLOAD_ELAPSED=$(echo $OUTPUT | jq .upload.elapsed)
UPLOAD_LATENCY_IQM=$(echo $OUTPUT | jq .upload.latency.iqm)
UPLOAD_LATENCY_LOW=$(echo $OUTPUT | jq .upload.latency.low)
UPLOAD_LATENCY_HIGH=$(echo $OUTPUT | jq .upload.latency.high)
UPLOAD_LATENCY_JITTER=$(echo $OUTPUT | jq .upload.latency.jitter)

# Parse the JSON output using jq for ping
PING_JITTER=$(echo $OUTPUT | jq .ping.jitter)
PING_LATENCY=$(echo $OUTPUT | jq .ping.latency)
PING_LOW=$(echo $OUTPUT | jq .ping.low)
PING_HIGH=$(echo $OUTPUT | jq .ping.high)

# Define the Pushgateway URL
PUSHGATEWAY_URL="http://localhost:9091/metrics/job/speedtest"

# Send the data to the Pushgateway
cat <<EOF | curl --data-binary @- $PUSHGATEWAY_URL
# TYPE download_bandwidth gauge
download_bandwidth $DOWNLOAD_BANDWIDTH
# TYPE download_bytes gauge
download_bytes $DOWNLOAD_BYTES
# TYPE download_elapsed gauge
download_elapsed $DOWNLOAD_ELAPSED
# TYPE download_latency_iqm gauge
download_latency_iqm $DOWNLOAD_LATENCY_IQM
# TYPE download_latency_low gauge
download_latency_low $DOWNLOAD_LATENCY_LOW
# TYPE download_latency_high gauge
download_latency_high $DOWNLOAD_LATENCY_HIGH
# TYPE download_latency_jitter gauge
download_latency_jitter $DOWNLOAD_LATENCY_JITTER

# TYPE upload_bandwidth gauge
upload_bandwidth $UPLOAD_BANDWIDTH
# TYPE upload_bytes gauge
upload_bytes $UPLOAD_BYTES
# TYPE upload_elapsed gauge
upload_elapsed $UPLOAD_ELAPSED
# TYPE upload_latency_iqm gauge
upload_latency_iqm $UPLOAD_LATENCY_IQM
# TYPE upload_latency_low gauge
upload_latency_low $UPLOAD_LATENCY_LOW
# TYPE upload_latency_high gauge
upload_latency_high $UPLOAD_LATENCY_HIGH
# TYPE upload_latency_jitter gauge
upload_latency_jitter $UPLOAD_LATENCY_JITTER

# TYPE ping_jitter gauge
ping_jitter $PING_JITTER
# TYPE ping_latency gauge
ping_latency $PING_LATENCY
# TYPE ping_low gauge
ping_low $PING_LOW
# TYPE ping_high gauge
ping_high $PING_HIGH
EOF
