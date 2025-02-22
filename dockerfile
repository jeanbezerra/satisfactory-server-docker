# Usar a imagem base do Ubuntu 24.04 LTS
FROM ubuntu:24.04

# Atualizar pacotes e instalar dependências necessárias
RUN apt update && \
    apt install -y wget curl lib32gcc-s1 bzip2 unzip && \
    apt clean

# Instale dependências e configure o timezone para GMT-3 (São Paulo)
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# Criar usuário steam com home, mas sem login
RUN useradd -m -s /usr/sbin/nologin steam

# Criar diretórios
RUN mkdir -p /steamcmd
RUN mkdir -p /satisfactory-server
RUN mkdir -p /satisfactory-config
RUN mkdir -p /satisfactory-savegame

# Alterar permissões
RUN chown -R steam:steam /steamcmd
RUN chown -R steam:steam /satisfactory-server
RUN chown -R steam:steam /satisfactory-config
RUN chown -R steam:steam /satisfactory-savegame

# Definir o diretório de trabalho
WORKDIR /satisfactory-server

# Baixar e instalar o SteamCMD para baixar o servidor
RUN cd /steamcmd && wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && tar -xvzf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz
RUN chmod -R 777 /steamcmd
RUN chown -R steam:steam /steamcmd

# Copie o script de inicialização
COPY start.sh /home/steam/start.sh
RUN chmod -R 777 /home/steam/start.sh
RUN chown -R steam:steam /home/steam/start.sh

# Definir os diretórios
VOLUME ["/steamcmd"]
VOLUME ["/home"]
VOLUME ["/satisfactory-server"]
VOLUME ["/satisfactory-config"]
VOLUME ["/satisfactory-savegame"]


# Expor as portas necessárias para o servidor
EXPOSE 7777/udp
EXPOSE 7777/tcp
EXPOSE 15000/udp
EXPOSE 15000/tcp
EXPOSE 15777/udp
EXPOSE 15777/tcp

# Definir usuário padrão
USER steam

# Inicialização do servidor
CMD ["bash", "/home/steam/start.sh"]