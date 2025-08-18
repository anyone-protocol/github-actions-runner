FROM ghcr.io/actions/actions-runner:2.328.0

USER root
COPY start-docker.sh start-docker.sh
RUN chmod +x start-docker.sh

# Install Hashicorp Levant
RUN curl -L https://releases.hashicorp.com/levant/0.3.3/levant_0.3.3_linux_amd64.zip -o levant.zip
RUN unzip levant.zip -d levant
RUN mv levant/levant /usr/local/bin
RUN chmod +x /usr/local/bin/levant

# Install Hashicorp Nomad
RUN curl -L https://releases.hashicorp.com/nomad/1.9.7/nomad_1.9.7_linux_amd64.zip -o nomad.zip
RUN unzip nomad.zip -d nomad
RUN mv nomad/nomad /usr/local/bin
RUN chmod +x /usr/local/bin/nomad

# Install Hashicorp Consul
RUN curl -L https://releases.hashicorp.com/consul/1.20.5/consul_1.20.5_linux_amd64.zip -o consul.zip
RUN unzip consul.zip -d consul
RUN mv consul/consul /usr/local/bin
RUN chmod +x /usr/local/bin/consul

# Install Hashicorp Vault
RUN curl -L https://releases.hashicorp.com/vault/1.19.0/vault_1.19.0_linux_amd64.zip -o vault.zip
RUN unzip vault.zip -d vault
RUN mv vault/vault /usr/local/bin
RUN chmod +x /usr/local/bin/vault

USER runner:docker
CMD ["./start-docker.sh"]
