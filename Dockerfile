FROM google/cloud-sdk:alpine
LABEL name="terraform & kubectl"
ENV TERRAFORM_VERSION=0.13.5
ENV KUBECTL_VERSION=v1.19.0
ENV KUBECONFIG=/home/.kube/config
VOLUME ["/data"]
WORKDIR /data
RUN apk update && \
  apk add ca-certificates bash wget && \
  update-ca-certificates
RUN apk add --update nodejs
RUN apk --update --no-cache add openssl && \
  wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
  unzip terraform.zip -d /bin && \
  rm -rf terraform.zip /var/cache/apk/*
ADD "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" "/usr/local/bin/kubectl"
RUN set -x && \
    chmod +x /usr/local/bin/kubectl && \
    adduser kubectl -Du 2342 -h /home
USER kubectl