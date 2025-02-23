#!/bin/bash
echo "============================"
echo "============================"
echo "Satisfactory Server"
echo "============================"
echo "============================"


# Diretório do servidor
GAME_DIR="/satisfactory-server"

# Comando para atualizar
echo "=============="
echo "Atualizando o servidor Satisfactory..."
/steamcmd/steamcmd.sh +force_install_dir "$GAME_DIR" +login anonymous +app_update 1690800 validate +quit
echo "Atualização concluída!"
echo "=============="
echo "============================"
echo "=============="
echo "Validação da data e hora do servidor"
date
echo "=============="
echo "============================"
echo "=============="
echo "Inicializando Game Server"
"$GAME_DIR"/FactoryServer.sh -log -SaveGamesFolder="/satisfactory-savegame/"