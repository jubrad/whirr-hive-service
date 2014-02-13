set -x

function install_hive(){
    curl -O http://www.dsgnwrld.com/am/hive/stable/hive-0.11.0.tar.gz
    tar -C /usr/local/ -zxf hive-0.11.0.tar.gz
    echo "export HIVE_HOME=/usr/local/hive-0.11.0" >> /etc/profile
}
