FROM ghcr.io/actions/actions-runner:2.328.0

USER root

# Install Hashicorp Levant
RUN curl -L https://releases.hashicorp.com/levant/0.4.0/levant_0.4.0_linux_amd64.zip -o levant.zip
RUN unzip levant.zip -d levant
RUN mv levant/levant /usr/local/bin
RUN chmod +x /usr/local/bin/levant

# Install Hashicorp Nomad
RUN curl -L https://releases.hashicorp.com/nomad/1.10.4/nomad_1.10.4_linux_amd64.zip -o nomad.zip
RUN unzip nomad.zip -d nomad
RUN mv nomad/nomad /usr/local/bin
RUN chmod +x /usr/local/bin/nomad

# Install Hashicorp Consul
RUN curl -L https://releases.hashicorp.com/consul/1.21.4/consul_1.21.4_linux_amd64.zip -o consul.zip
RUN unzip consul.zip -d consul
RUN mv consul/consul /usr/local/bin
RUN chmod +x /usr/local/bin/consul

# Install Hashicorp Vault
RUN curl -L https://releases.hashicorp.com/vault/1.20.2/vault_1.20.2_linux_amd64.zip -o vault.zip
RUN unzip vault.zip -d vault
RUN mv vault/vault /usr/local/bin
RUN chmod +x /usr/local/bin/vault

COPY entrypoint.sh generate-github-app-jwt.sh ./
RUN chmod +x entrypoint.sh generate-github-app-jwt.sh

USER runner:docker
ENTRYPOINT [ "./entrypoint.sh" ]
