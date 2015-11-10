#!/bin/sh
T=$(curl -s -H "Authorization: $TUTUM_AUTH" -H "Accept: application/json" $TUTUM_SERVICE_API_URL | jq '.' | grep ENV_TUTUM_IP_ADDRESS | grep -v ${TUTUM_IP_ADDRESS} | awk -F\" '{print $4}' | awk -F\/ '{print $1}')
CLUSTER=""
for Y in $T; do
    CLUSTER="${CLUSTER}${Y},"
done
CLUSTER="${CLUSTER%?}"
NODE_ADDR=$(echo ${TUTUM_IP_ADDRESS} | awk -F\/ '{print $1}')

VOLUME_HOME="/var/lib/mysql"

if [ "x${CLUSTER}" = "x" ]; then
    echo "I'm alone Bootstrap Cluster (Throw away container if this is not the first container)"
    if [ ! -d $VOLUME_HOME/mysql ]; then
        mysql_install_db > /dev/null 2>&1
        /create_mariadb_admin_user.sh
    fi
    /usr/bin/mysqld_safe --wsrep_node_address="${NODE_ADDR}" \
        --wsrep_node_incoming_address="${NODE_ADDR}" \
        --wsrep_new_cluster --wsrep_cluster_address="gcomm://"
else
    echo "I'm not first! My buddies: ${CLUSTER}"
    /usr/bin/mysqld_safe --wsrep_node_address="${NODE_ADDR}" \
        --wsrep_node_incoming_address="${NODE_ADDR}" \
        --wsrep_cluster_address="gcomm://${CLUSTER}"
fi