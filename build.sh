# Set correct environment variables.

# WORKAROUND for docker build errors
RUN ln -s -f /bin/true /usr/bin/chfn

LC_ALL=C DEBIAN_FRONTEND=noninteractive

# Install MariaDB
apt-get -y update
apt-get install -y software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
add-apt-repository 'deb http://mirror.netcologne.de/mariadb/repo/10.0/ubuntu trusty main'
add-apt-repository 'deb http://repo.percona.com/apt trusty main'
apt-get -y update

apt-get install -y iproute mariadb-galera-server-10.1 galera-3 rsync netcat-openbsd socat pv iputils-ping net-tools percona-xtrabackup

mv /usr/bin/xtrabackup /usr/bin/xtrabackup_51
ln -sf /usr/bin/xtrabackup_55 /usr/bin/xtrabackup