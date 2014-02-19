set -x

function install_hive(){    
    TARBALL_URL="$1"
    USER="$2"
    # We'll use whirrs tarball install and pass it the correct url
    #install_tarball TARBALL_URL
    curl -O $TARBALL_URL
    tar -C /usr/local/ -zxf $(basename $TARBALL_URL)
    


    #sets the HIVE_HOME attribute for all users
    
    HIVE_HOME=/usr/local/$(basename $TARBALL_URL .tar.gz)

    echo "export HIVE_HOME=$HIVE_HOME" >> /etc/profile

    #sets the file permisions for the hive home correctly
    chown $USER $HIVE_HOME
    if [ $? -gt 0 ]
    then
    sudo chown $USER $HIVE_HOME
    fi

    #creates a symlink to the HIVE_HOME
    ln -s $HIVE_HOME /usr/local/hive
    #I was getting errors about this file not existing.
    touch /usr/bin/hive
    #creates an exectuable in /bin to launch hive
    cat > /usr/bin/hive <<EOF
#!/bin/sh

exec $HIVE_HOME/bin/hive \$@   
EOF
# correcting permissions on usr/bin/hive
chown $USER usr/bin/hive
if [ $? -gt 0 ]
then
sudo chown $USER usr/bin/hive
fi

sudo chmod u+x /usr/bin/hive 
}

