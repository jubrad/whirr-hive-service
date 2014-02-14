function configure_hive_client(){


    source /etc/profile

    #these hardcoded values should probably be removed later

    
    #configuration file to overwrite hive defaultas
     #it's entirely empty for now, but hopefully more #functionality will be added shortly
    
    cat > $HIVE_HOME/hive-site.xml <<EOF

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>     
<configuration>
</configuration>

EOF

    #Installing hive entirely on name node with local metadata
    #these are used to setup hadoop fs dirs for hive 

    hadoop fs -mkdir /tmp
    hadoop fs -chmod a+w /tmp
    hadoop fs -mkdir /user/hive/warehouse
    hadoop fs -chmod a+w /user/hive/warehous
}
