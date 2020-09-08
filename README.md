# oci-arch-cross-tenancies

You might have business and technical reasons to privately peer your virtual networks in the cloud and ensure that your network traffic never traverses the public internet. For example, you might want private connectivity within a region and within your organization, or with a cooperating organization.

This repository shows how to configure cross-region private connectivity by using a transit LPG between two OCI tenancies.

## Terraform Provider for Oracle Cloud Infrastructure
The OCI Terraform Provider is now available for automatic download through the Terraform Provider Registry. 
For more information on how to get started view the [documentation](https://www.terraform.io/docs/providers/oci/index.html) 
and [setup guide](https://www.terraform.io/docs/providers/oci/guides/version-3-upgrade.html).

* [Documentation](https://www.terraform.io/docs/providers/oci/index.html)
* [OCI forums](https://cloudcustomerconnect.oracle.com/resources/9c8fa8f96f/summary)
* [Github issues](https://github.com/terraform-providers/terraform-provider-oci/issues)
* [Troubleshooting](https://www.terraform.io/docs/providers/oci/guides/guides/troubleshooting.html)

## Clone the Module
Now, you'll want a local copy of this repo. You can make that with the commands:

    git clone https://github.com/oracle-quickstart/oci-arch-cross-tenancies.git
    cd oci-arch-cross-tenancies
    ls

## Prerequisites
First off, you'll need to do some pre-deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

Secondly, create a `terraform.tfvars` file and populate with the following information:

```
# Authentication to Tenancy A - Region 01 and Region 02
tenancy_ocid_a         = "tenancy ocid region A"
user_ocid_a            = "user ocid region A"
fingerprint_a          = "user fingreprint A"
private_key_path_a     = "private_key_path_region A"
region_01_a            = "ap-mumbai-1" (you can select any other region)
region_02_a            = "us-ashburn-1" (you can select any other region)
compartment_ocid_a     = "compartment ocid A"
compartment_name_a     = "compartment name A"

# Authentication to Tenancy B Region 01
tenancy_ocid_b     = "tenancy ocid region B"
user_ocid_b        = "user ocid region B"
fingerprint_b      = "user fingreprint B"
private_key_path_b = ""private_key_path_region B""
region_01_b        = "us-ashburn-1" (you can select any other region)
compartment_ocid_b = "compartment ocid B"
compartment_name_b = "compartment name B"

# SSH Keys
ssh_public_key  = "/ssh-keys/key.pub"

# Home Region
home_region_a = "us-phoenix-1"
home_region_b = "us-ashburn-1"

````

Deploy:

    terraform init
    terraform plan
    terraform apply

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy

## Web Application Architecture

![](./images/cross-region.png)


## Reference Archirecture

- [Configure cross-region private connectivity between tenancies](https://docs.oracle.com/en/solutions/xregion-pvt-connectivity-oci/index.html)
