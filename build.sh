# Set correct environment variables.
set -ex

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive
export TERM=dumb

# WORKAROUND for docker build errors
ln -s -f /bin/true /usr/bin/chfn

# Install MariaDB
apt-get install -y software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386] http://ftp.ddg.lth.se/mariadb/repo/10.1/ubuntu trusty main'

apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
add-apt-repository 'deb http://repo.percona.com/apt trusty main'
apt-get -y update
apt-get -y upgrade

apt-get install -y iproute mariadb-server galera-3 pv iputils-ping net-tools jq
# socat percona-xtrabackup
apt-get -y autoremove
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*