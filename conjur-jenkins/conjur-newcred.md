
These steps assume that the credential is declared as a variable in DAP and that the value is loaded into DAP.

Decide whether to define the variable at the Global Configuration level or at a folder level. In the Jenkins UI, navigate to the desired location.

Credentials defined globally may be referenced by any Jenkins pipeline code or project.

Credentials defined at the folder level may be referenced only by pipeline code or projects in that folder.

Click ConjurSecret.

Complete the form that appears.

Field

Description

Scope

Select an appropriate value for your use case.

Variable Path

The complete Conjur ID of the variable. This includes the policy path where the variable is defined.

For example, if a variable named db_password is defined in a policy hierarchy identified as databases/oracle, the variable path is: 

 	
databases/oracle/db_password
ID

An ID to use in Jenkins to reference this variable. It does not need to match the name in DAP.

Description

Optionally provide a description of this secret.

Click Save.
