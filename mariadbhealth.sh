#!/bin/sh
ncat -lk -p 9200 --sh-exec "/etc/mysql/clustercheck.sh"