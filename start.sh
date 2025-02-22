#!/bin/bash

# Diretório do servidor
GAME_DIR="/satisfactory-server"

# Comando para atualizar
echo "=============="
echo "Atualizando o servidor Satisfactory..."
/steamcmd/steamcmd.sh +force_install_dir "$GAME_DIR"
/steamcmd/steamcmd.sh +login anonymous +app_update 1690800 validate +quit
echo "Atualização concluída!"
echo "=============="

# Re-executar permissões
echo "=============="
echo "Gravando novas permissões..."
chmod -R 777 /steamcmd
chmod -R 777 /satisfactory-server
chmod -R 777 /satisfactory-config
chmod -R 777 /satisfactory-savegame
chown -R steam:steam /steamcmd
chown -R steam:steam /satisfactory-server
chown -R steam:steam /satisfactory-config
chown -R steam:steam /satisfactory-savegame
echo "Permissões atualizadas!"
echo "=============="

echo "=============="
echo "Validação da data e hora do servidor"
echo date
echo "=============="

# Inicia o servidor do jogo
cd "$GAME_DIR"
#./FactoryServer.sh -log -SaveGamesFolder="/satisfactory-savegame/"
./FactoryServer.sh -SaveGamesFolder="/satisfactory-savegame/"