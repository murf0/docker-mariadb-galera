# MariaDB on Galera Cluster
A mariadb Docker image with Galera cluster capability. 

# How to use
Environment variable needed 
```
wsrep_sst_auth=<SST_REPLICATION_SQL_USER>:<PASSWORD_FOR_SQL_USER>
```

#HA Proxy
When using the tutum cloud settings the tutum.yaml stackfile can be used.
The extra environment variables for MariaDB containers setup the tcp-proxy settings. And a tiny netcat shell-script server serves status of the instance.
Additional environment variables needed: 

```
BALANCE=leastconn
EXCLUDE_PORTS=4567,4568,4444,9200
HEALTH_CHECK=check port 9200 inter 5000 fastinter 2000 rise 2 fall 2
OPTION=httpchk
TCP_PORTS=3306
```

#Know limitations
In a galera cluster when a node joins a full master drops out to do the initial sync with this new node. This takes some time during this time no new nodes that need a full sync can join the cluster.

##Mitigation
Only add new nodes when all current nodes are full masters in the 