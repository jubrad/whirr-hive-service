package org.apache.whirr.service.hive;

import static org.apache.whirr.RolePredicates.role;
import static org.jclouds.scriptbuilder.domain.Statements.call;

import java.io.IOException;

import org.apache.whirr.Cluster;
import org.apache.whirr.Cluster.Instance;
import org.apache.whirr.service.ClusterActionEvent;
import org.apache.whirr.service.ClusterActionHandlerSupport;
import org.apache.whirr.service.FirewallManager.Rule;


public class HiveClientHandler extends ClusterActionHandlerSupport {

    public static final String ROLE = "hive-client";

    @Override public String getRole() {
        return ROLE;
    }
    
    @Override
    protected void beforeBootstrap(ClusterActionEvent event) throws IOException, InterruptedException{
        addStatement(event,call("install_hive"));
    }

    protected void beforeConfigure(ClusterActionEvent event) throws IOException, InterruptedException{
/** this might be needed to find hadoop master, but I doubt it
    could also be used to find hive metatstore when that role is 
    built



        Instance hadoop = cluster.getInstanceMatching(role(hadoop-master.ROLE));
        String hadoopMasterAddress = hadoop.getPrivateAddress().getHostAddress();
    }
**/
    addStatement(event, call("configure_hive_client"));
    }
}

