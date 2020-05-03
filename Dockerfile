FROM google/cloud-sdk:280.0.0-alpine AS gcloud

FROM alpine:3.11

ARG VERSION
ENV TERRAFORM_URL="https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip"

RUN apk add --update --no-cache python3 git \
    && wget -O /tmp/terraform.zip ${TERRAFORM_URL}  \
    && unzip /tmp/terraform.zip -d /bin \
    && rm -rf /tmp/terraform.zip /var/cache/apk/*

COPY --from=gcloud /google-cloud-sdk/lib /usr/lib/google-cloud-sdk/lib
COPY --from=gcloud /google-cloud-sdk/bin/gcloud /usr/lib/google-cloud-sdk/bin/gcloud

ENTRYPOINT ["/bin/terraform"]
