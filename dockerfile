# Usar a imagem base do Ubuntu 24.04 LTS
FROM ubuntu:24.04



# Atualizar pacotes e instalar dependências necessárias
RUN apt update && apt install -y \
    wget curl lib32gcc-s1 bzip2 unzip tzdata \
    && ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && echo "America/Sao_Paulo" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt clean

# Criar usuário steam com home, mas sem login
RUN useradd -m -s /usr/sbin/nologin steam

# Criar diretórios necessários e definir permissões
RUN mkdir -p /steamcmd 
RUN mkdir -p /satisfactory-server
RUN mkdir -p /satisfactory-config
RUN mkdir -p /satisfactory-savegame

RUN chown -R steam:steam /steamcmd
RUN chown -R steam:steam /satisfactory-server
RUN chown -R steam:steam /satisfactory-config
RUN chown -R steam:steam /satisfactory-savegame

# Definir os diretórios
VOLUME /satisfactory-server
VOLUME /satisfactory-scripts
VOLUME /satisfactory-savegame

# Baixar e instalar o SteamCMD
RUN cd /steamcmd \
    && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz \
    && tar -xvzf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz \
    && chown -R steam:steam /steamcmd

# Copiar o script de inicialização e ajustar permissões
COPY start.sh /satisfactory-scripts/start.sh
RUN chmod 755 /satisfactory-scripts/start.sh 
RUN chown steam:steam /satisfactory-scripts/start.sh

# Expor as portas do servidor
EXPOSE 7777/udp 15000/udp 15777/udp

# Definir usuário padrão
USER steam

# Definir o diretório de trabalho
WORKDIR /satisfactory-server

# Comando para iniciar o servidor
CMD ["/bin/bash", "/satisfactory-scripts/start.sh"]