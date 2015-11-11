#!/bin/sh
T=$(curl -s -H "Authorization: $TUTUM_AUTH" -H "Accept: application/json" $TUTUM_SERVICE_API_URL | jq '.' | grep ENV_TUTUM_IP_ADDRESS | grep -v ${TUTUM_IP_ADDRESS} | awk -F\" '{print $4}' | awk -F\/ '{print $1}' | sort -u)
CLUSTER=""
for Y in $T; do
    CLUSTER="${CLUSTER}${Y},"
done
CLUSTER="${CLUSTER%?}"
NODE_ADDR=$(echo ${TUTUM_IP_ADDRESS} | awk -F\/ '{print $1}')

VOLUME_HOME="/var/lib/mysql"

if [ "x${CLUSTER}" = "x" ]; then
    echo "I'm alone Bootstrap Cluster (Throw away container if this is not the first container)"
else
    echo "I'm not alone! My buddies: ${CLUSTER}"
fi
/usr/bin/mysqld_safe --wsrep_node_address="${NODE_ADDR}" --wsrep_node_incoming_address="${NODE_ADDR}" --wsrep_cluster_address="gcomm://${CLUSTER}"