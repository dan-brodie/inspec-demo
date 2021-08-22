FROM ubuntu:latest

# Configure apt
ENV DEBIAN_FRONTEND=noninteractive

# Config user
ENV USERNAME=vscode
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Install helpful tooling
# (git, process tools, lsb-release; common in install instructions for CLIs)
RUN apt-get update -y && \
        apt-get -y install --no-install-recommends \
        apt-utils \
        sudo \
        git \
        procps \
        lsb-release \
        curl unzip gnupg \
        bash-completion \
        keychain \
        python3-pip \
        apt-transport-https \
        ca-certificates \
        gnupg-agent \
        software-properties-common \
        npm \
        2>&1

RUN groupadd --gid $USER_GID $USERNAME \
        && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
        && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
        && chmod 0440 /etc/sudoers.d/$USERNAME

# Install Gcloud, and Python Apis (curl and apt-utils need to be installed first)
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
        apt-get update -y && \
        apt-get -y install --no-install-recommends \
        google-cloud-sdk \
        python3-google-auth \
        2>&1

# Install precommit docs and plugins
RUN pip3 install --upgrade pre-commit detect-secrets google-api-python-client mkdocs mkdocs-material mkdocs-minify-plugin

# get tfenv instead of terraform for ease of module switching
ENV TERRAFORM_VERSION=1.0.0
RUN git clone https://github.com/tfutils/tfenv.git /home/$USERNAME/.tfenv && \
        chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.tfenv

# Install yq
RUN curl -sLo yq https://github.com/mikefarah/yq/releases/download/3.2.1/yq_linux_amd64 && \
        chmod +x yq && \
        mv yq /usr/bin

# install Powerline GO
ENV POWERLINE_VERISON=1.21.0
RUN curl -Lo powerline-go https://github.com/justjanne/powerline-go/releases/download/v${POWERLINE_VERISON}/powerline-go-linux-amd64 && \
        chmod +x powerline-go && \
        mv powerline-go /usr/bin

RUN npm install -g markdownlint-cli

# Install Docker CE CLI and vim
RUN curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
        && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" \
        && apt-get update \
        && apt-get install -y docker-ce-cli vim \
        #
        # Install Docker Compose
        && curl -sSL "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
        && chmod +x /usr/local/bin/docker-compose

# Install packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
        sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
        sudo apt-get update -y && sudo apt-get install packer -y

# Clean up
RUN apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

# Set the default shell to bash instead of sh
ENV SHELL /bin/bash

USER vscode

# Copy any devcontainer bashrc setup and activate it
ADD .bashrc_devcontainer /home/$USERNAME/.bashrc_devcontainer
RUN echo "source ~/.bashrc_devcontainer" >> /home/$USERNAME/.bashrc