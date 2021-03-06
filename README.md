# gcp-terraform

Manage GCP with Terraform, built with gcloud binary for authenticating connections towards GCP.

*Example ZSH function for alias terraform to use the docker image:*

```
#!/usr/local/bin/zsh

# Run Terraform commands with docker

function terraform() {
mnt="/root/terraform"

if [[ -z "$DOCKER_RAND_ID" ]]; then
  DOCKER_RAND_ID=$RANDOM
fi

if [[ -z "$TERRAFORM_VERSION" ]]; then
  TERRAFORM_VERSION=v0.12.16
fi

docker run --name "$DOCKER_RAND_ID" -it --rm \
  -v /tmp:/tmp \
  -v $(pwd):$mnt \
  -w /$mnt \
  -e TF_LOG \
  -e GOOGLE_CREDENTIALS \
  -e GOOGLE_ENCRYPTION_KEY \
  -v $HOME/.kube:/root/.kube \
  -e GOOGLE_APPLICATION_CREDENTIALS \
  frealmyr/gcp-terraform:$TERRAFORM_VERSION $kns $argv[*]
}

```

