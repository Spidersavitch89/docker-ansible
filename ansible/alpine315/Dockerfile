# pull base image
FROM alpine:3.15

ARG ANSIBLE_VERSION_ARG "2.9.27"
ENV ANSIBLE_VERSION ${ANSIBLE_VERSION_ARG}

# Labels.
LABEL maintainer="will@willhallonline.co.uk" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="willhallonline/ansible" \
    org.label-schema.description="Ansible inside Docker" \
    org.label-schema.url="https://github.com/willhallonline/docker-ansible" \
    org.label-schema.vcs-url="https://github.com/willhallonline/docker-ansible" \
    org.label-schema.vendor="Will Hall Online" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa willhallonline/ansible:2.9-alpine-3.14"

RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 && \
    apk --no-cache add \
        sudo \
        python3\
        py3-pip \
        openssl \
        ca-certificates \
        sshpass \
        openssh-client \
        rsync \
        tree \
        nano \
        iputils \
        iproute2 \
        bind-tools \
        tmux \
        tshark \
        zsh \
        fzf \
        bash \
        openssh \
        libc6-compat \
        curl \
        git && \
    apk --no-cache add --virtual build-dependencies \
        python3-dev \
        libffi-dev \
        musl-dev \
        gcc \
        cargo \
        openssl-dev \
        libressl-dev \
        build-base && \
    pip install --upgrade pip wheel && \
    pip install --upgrade cryptography cffi && \
    pip install ansible==${ANSIBLE_VERSION} && \
    pip install mitogen ansible-lint jmespath && \
    pip install --upgrade pywinrm && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    rm -rf /root/.cargo

# Install Terraform
ENV TERRAFORM_VERSION 1.0.10
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install and configure Oh-my-zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -t Powerlevel10k \
    -p ansible \
    -p alias-finder \
    -p 'history-substring-search' \
    -p tmux \
    -p zsh-interactive-cd \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'
# Install Powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

RUN git clone https://github.com/Naereen/nanorc.git ~/.nano/ && \
    ln -s ~/.nano/.nanorc ~/.nanorc

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

# Asnible Collection installs
RUN ansible-galaxy collection install cisco.ios && \
    ansible-galaxy collection install arista.eos && \
    ansible-galaxy collection install ansible.windows && \
    ansible-galaxy collection install chocolatey.chocolatey && \
    ansible-galaxy collection install community.aws && \
    ansible-galaxy collection install community.digitalocean && \
    ansible-galaxy collection install community.docker && \
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install community.grafana && \
    ansible-galaxy collection install community.hashi_vault && \
    ansible-galaxy collection install community.kubernetes && \
    ansible-galaxy collection install community.mongodb && \
    ansible-galaxy collection install community.mysql && \
    ansible-galaxy collection install community.network && \
    ansible-galaxy collection install community.postgresql && \
    ansible-galaxy collection install community.vmware && \
    ansible-galaxy collection install pfsensible.core && \