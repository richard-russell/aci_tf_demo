# Terraform / Cisco ACI Demo

This demo shows how Terraform can be used to create a tenant, bridge domain and some randomly-named EPGs in the Cisco ACI. Tested against the Cisco DevNet always-on ACI sandbox.

The demo illustrates two workflows:

- Local terrraform workflow, which is a quick and easy way to learn about Terraform but offers limited scope for collaboration and governance 
- Terraform Cloud workflow, where the desired Terraform source of truth is kept in a git repo mapped to a workspace in Terraform Cloud.

## How to run locally

- [Install terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) on your machine
- Clone this repo to your machine and change to the newly created directory
- Gather the URL and credentials for your APIC (you can use the [always-on ACI simulator](https://devnetsandbox.cisco.com/RM/Topology))
- Add a `creds.auto.tfvars` file with the required variables (not included in the repo as *we don't check credentials into git*). Terraform will read vars from all files with the suffix `.auto.tfvars`, but the `.gitignore` in this repo specifically excludes `creds.auto.tfvars` . The file should look like this:
```
apic_password = "<sandbox APIC password>"
apic_url      = "https://sandboxapicdc.cisco.com"
apic_user     = "admin"
name_prefix   = "<your_unique_prefix>"
```
- Initialise terraform to install the necessary providers: `terraform init`
- Run a terraform plan to preview changes: `terraform plan`
- Apply the terraform config to make the changes: `terraform apply`
- Navigate to the APIC UI to see the tenant, BD and EPGs
- Make a change to the terraform config (e.g. the naming convention of the EPGs) and rerun `terraform apply`
- Take a look at the Terraform [ACI provider documentation](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs) and add some more ACI resources 
- Destroy the ACI objects: `terraform destroy`

## How to run on Terraform Cloud
- Set up a free tier organization at [Terraform Cloud](https://app.terraform.io/) 
- Set up a github account, if you don't have one already
- Fork this repo to your github organization
- [Set up a VCS connection](https://developer.hashicorp.com/terraform/cloud-docs/vcs) from your TFC org to your github org
- Create a TFC workspace and choose version control workflow, your github VCS provider, and your fork of this repo. If this is your first workspace in this TFC org, the UI will guide you throught this.
- Create `apic_password`, `apic_url`, `apic_user` and `name_prefix` variables in your workspace, labelling the password variable as sensitive
- Start a new run from the UI (under Actions, at the top right)
- Review the plan output, and if you're happy confirm and apply it
- Make a change to your terraform code using the github UI and commit the change to main branch, which will trigger a run in the workspace
- Finally a real-world workflow: make a change to the terraform code in a git branch and raise a pull request to main, which will trigger a speculative plan in TFC, with the outcome fed back into the PR. Review the PR in github, and assuming the checks pass, click through to see the plan details in TFC. Merge the PR and watch and approve the run in TFC. This is the most common collaborative Infrastructure as Code workflow for managing cloud resources using TFC, with aprovals required from the code owner in github and the platform owner in TFC.
- Destroy the ACI objects by starting a destroy run under Worksdpace -> Settings -> Destruction and Deletion


## Disclaimer
“By using the software in this repository (the “Software”), you acknowledge that: (1) the Software is still in development, may change, and has not been released as a commercial product by HashiCorp and is not currently supported in any way by HashiCorp; (2) the Software is provided on an “as-is” basis, and may include bugs, errors, or other issues; (3) the Software is NOT INTENDED FOR PRODUCTION USE, use of the Software may result in unexpected results, loss of data, or other unexpected results, and HashiCorp disclaims any and all liability resulting from use of the Software; and (4) HashiCorp reserves all rights to make all decisions about the features, functionality and commercial release (or non-release) of the Software, at any time and without any obligation or liability whatsoever."