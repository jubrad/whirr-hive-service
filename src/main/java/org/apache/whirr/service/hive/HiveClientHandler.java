package org.apache.whirr.service.hive;

import static org.apache.whirr.RolePredicates.role;
import static org.jclouds.scriptbuilder.domain.Statements.call;
import java.io.IOException;
import static java.lang.System.*;

import org.apache.whirr.Cluster;
import org.apache.whirr.Cluster.Instance;


// these are needed to get the version config working
import org.apache.whirr.ClusterSpec;
import org.apache.whirr.RolePredicates;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;

import org.apache.whirr.service.ClusterActionEvent;
import org.apache.whirr.service.ClusterActionHandlerSupport;
import org.apache.whirr.service.FirewallManager.Rule;


public class HiveClientHandler extends ClusterActionHandlerSupport {

    public static final String ROLE = "hive-client";


    protected Configuration getConfiguration(ClusterSpec clusterSpec) throws IOException {
        return getConfiguration(clusterSpec, "whirr-hive-default.properties");
    }


    @Override public String getRole() {
        return ROLE;
    }
    
    @Override
    protected void beforeBootstrap(ClusterActionEvent event) throws IOException, InterruptedException{
        // brings in the configuration file which will determine which hive version
        ClusterSpec clusterSpec = event.getClusterSpec();
        Configuration conf = getConfiguration(clusterSpec);
        
        // the version is changed in the tarbal_url config so we just need to pull that down
        
//ignore        String tarballUrl= prepareRemoteFileUrl(event,conf.getString("whirr.hive.tarball.url"));
        String tarballUrl=conf.getString("whirr.hive.tarball.url");
        String user=conf.getString("whirr.cluster-user");
        addStatement(event,call("install_hive",tarballUrl,user));
    }

    protected void beforeConfigure(ClusterActionEvent event) throws IOException, InterruptedException{
/** this might be needed to find hadoop master, but I doubt it
    could also be used to find hive metatstore when that role is 
    built
        String hadoopMasterAddress = hadoop.getPrivateAddress().getHostAddress();
    }
**/
    addStatement(event, call("configure_hive_client"));
    }
}

