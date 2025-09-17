# Source: https://gist.github.com/6955a3fa05665c6b8bb7a3a48ebbdd23

##########################################
# DevSpace                               #
# Development Environments in Kubernetes #
# https://youtu.be/nQly_CEjJc4           #
##########################################

# Referenced videos:
# - How To Create Virtual Kubernetes Clusters With vcluster By loft: https://youtu.be/JqBjpvp268Y
# - Argo CD - Applying GitOps Principles To Manage Production Environment In Kubernetes: https://youtu.be/vpWQeoaiRM4
# - Flux CD v2 With GitOps Toolkit - Kubernetes Deployment And Sync Mechanism: https://youtu.be/R6OeIgb7lUI
# - K3d - How to run Kubernetes cluster locally using Rancher k3s: https://youtu.be/mCesuGk-Fks
# - Kustomize - How to Simplify Kubernetes Configuration Management: https://youtu.be/Twtbg6LFnAg

#########
# Setup #
#########

git clone https://github.com/vfarcic/devspace-demo.git

cd devspace-demo

# Please watch https://youtu.be/mCesuGk-Fks if you are not familiar with k3d
# Feel free to use any other Kubernetes platform
k3d cluster create --config k3d.yaml

ls -1

# Please watch https://youtu.be/Twtbg6LFnAg if you are not familiar with Kustomize
ls -1 kustomize

ls -1 kustomize/base

ls -1 kustomize/overlays/dev

################################
# Initializing dev environment #
################################

# Install the CLI by following the instructions in https://devspace.sh/docs/getting-started/installation

devspace init

# Select `Kustomize` as a mechanism to deploy this project.
# Set `kustomize/overlays/dev` as the path
# Set the container image (e.g. `vfarcic/devops-toolkit`)
# Select `existing Dockerfile` as the way to build images
# Select any port or press the enter key to use the default `8080`

cat devspace.yaml

# Open `devspace.yaml` in your favorite editor
# Set the value of `dev.replacePods[].replaceImage` to `klakegg/hugo:0.78.2-alpine`

############################
# Creating dev environment #
############################

kubectl create namespace dev

devspace use namespace dev

devspace dev

ls -1

cat config.toml

# Change config.toml using your favorite editor

cat config.toml

hugo server --port 80

# Press ctrl+c

exit

# Open `devspace_start.sh` in your favorite editor
# Replace `devspace list ports` with `hugo server --port 80`

devspace dev

# Change config.toml using your favorite editor

# ctrl+c

exit

#######################
# Additional features #
#######################

devspace list ports

devspace list profiles

# devspace deploy --profile production

devspace ui

# ctrl+c

devspace help

#########################
# Destroying everything #
#########################

devspace purge --all

kubectl --namespace dev get all

rm devspace.yaml

k3d cluster delete devops-toolkit
