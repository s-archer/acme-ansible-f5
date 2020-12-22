# acme-ansible-f5

This playbook assumes you have an AWS environment already deployed. I deploy https://github.com/s-archer/autows201b with Terraform, before deploying this playbook.

You need to update the vars in the main.yaml and update the filter string in aws_ec2.yaml inventory, so Ansible can find the 'bigips' in your AWS environment.

You also need to determine iof you want to use the staging (recommended for testing, before moving to production) or production Let's Encrypt servers.  See: https://letsencrypt.org/docs/staging-environment/

When running the playbook, it will perform the following tasks:

-   re/deploy a basic AS3 declaration that should provide HTTP access to NGINX app.
-   it will then pause and wait for you to check HTTP works (and HTTPS does not).  Hit enter to continue.
-   generate a new RSA private key to create an account with Let's Encrypt.
-   create an account with Let's Encrypt, using your private key and accept the Terms & Conditions.
-   generates an RSA private key for your application.
-   generates a CSR matching your CN from the RSA private key for your application.
-   creates a Let's Encrypt ACME challenge for your CN using the CSR.
-   re/deploy an AS3 declaration that includes an iRule that will respond to the Let's Encrypt ACME challenge to your domain.
-   send ACME request to Let's Encrypt to request validation of the challenge, and if successful, get the signed certificate in response.
-   re/deploy an AS3 declaration that should provide HTTPS access to NGINX app using a valid (or staging) Let's Encrypt signed certificate.

