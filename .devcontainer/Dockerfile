# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.191.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version: bionic, focal
ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Install Gcloud SDK
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
        apt-get update -y && \
        apt-get -y install --no-install-recommends \
        google-cloud-sdk \
        python3-google-auth \
        2>&1

# Install packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
        echo "deb [arch=$(uname -m)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
        apt-get update -y && sudo apt-get install packer -y

# Install Inspec
RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec