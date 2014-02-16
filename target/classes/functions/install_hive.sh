set -x

function install_hive(){    
    TARBALL_URL="$1"
    # We'll use whirrs tarball install and pass it the correct url
    install_tarball TARBALL_URL
    

    #sets the HIVE_HOME attribute for all users
    
    HIVE_HOME=/usr/local/${basename TARBALL_URL .tar.gz}



    echo "export HIVE_HOME=$HIVE_HOME" >> ~root/.bashrc
    echo "export HIVE_HOME=$HADOOP_HOME" >> /etc/profile



    #creates a symlink to the HIVE_HOME
    ln -s $HIVE_HOME /usr/local/hive

    #creates an exectuable in /bin to launch hive
    cat > /bin/hive <<EOF
#!/bin/sh

exec $HIVE_HOME/bin/hive $@
    
EOF 
}
