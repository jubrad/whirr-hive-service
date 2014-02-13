set -x

function install_hive(){
    #curls and unpacks set version of hive to usr/local
    curl -O http://www.dsgnwrld.com/am/hive/stable/hive-0.11.0.tar.gz
    tar -C /usr/local/ -zxf hive-0.11.0.tar.gz
    #sets the HIVE_HOME attribute for all users
    echo "export HIVE_HOME=/usr/local/hive-0.11.0" >> /etc/profile

    #adds hive to the path
    echo "PATH=$HIVE_HOME/bin:$PATH" >> /etc/profile

}
