
The following steps define the connection to the DAP appliance. This is typically a one-time configuration.

In a browser, go to the Jenkins UI.

Navigate to Jenkins > Credentials > System > Global credentials (unrestricted)

On the form that appears, configure the login credentials. These are credentials for the Jenkins host to log into DAP.

Field

Description

Scope

Select Global.

Username

The username of a Jenkins host. The username of a hostmust be in the format host/<host-name> , where: 

host/ is a required prefix.

<host-name> is the network name for the Jenkins host that you declared in DAP.

For example, the username for the Jenkins host named frontend-01 is: 

 	
host/frontend-01
Password

Copy and paste the API key that was returned by DAP when you loaded the policy declaring this host.

ID

The Jenkins ID, natively provided by Jenkins.

Description

Optional. Provide a description to identify this global credential entry.

Access to the Jenkins host and to the credentials is protected by DAP.

 	
When a host attempts to authenticate with DAP, DAP can detect if the request is originating from the host presenting the request. Conjur denies connection if the requestor is not the actual host. 

Click Save.

Decide whether to set up global or folder-level access to DAP, or a combination of both.

A global configuration allows any job to use the configuration (unless a folder-level configuration overrides the global configuration).

A folder-level configuration is specific to jobs in the folder. Folder-level configurations override the global configuration. In a hierarchy of folders, each folder may inherit configuration information from its parent. The top level in such a hierarchy is the global configuration.

You may set up a global configuration and override it with folder-level configurations.

Navigate to either Jenkins > Manage Jenkins > Configure Jenkins   or Jenkins > Folder-name > Configuration.

On the form that appears, under DAP Appliance, configure the DAP connection information.

Field

Description

Inherit from parent?

This checkbox appears only on the folder level configuration window. If checked, the values set here are ignored, and values in the parent folder apply. If all folders up the hierarchy are set to inherit from their parents, the global configuration is used.

Account

The DAP organizational account that was assigned when DAP was originally configured. For example, my-org.

Appliance URL

The secure URL to DAP.  For example: https://conjur-master.example.com

DAP Auth Credentials

The host name and API key to authenticate to DAP. Select credentials previously configured, or click Add to add new values.

DAP SSL Certificate

Select none. You already imported the SSL Certificate onto the Jenkins host in Prepare the certificate

This field allows you to reference a certificate stored as a credential in Jenkins. The stored value must be a .p12 file generated using the openssl command to convert the conjur.pem file. Because openssl requires the conjur.key file for the conversion, we recommend avoiding this method.

Click Save.
