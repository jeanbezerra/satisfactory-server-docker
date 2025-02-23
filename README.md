# Satisfactory Server Game

## Liberação de Portas no Firewall 

### Liberação de portas para Windows via PowerShell

```ps1
New-NetFirewallRule -DisplayName "Allow Satisfactory default inbound ports UDP" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol UDP -LocalPort 15000,15777,7777
```

```ps1
New-NetFirewallRule -DisplayName "Allow Satisfactory default inbound ports TCP" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 15000,15777,7777
```

## Build Docker Image

```sh
docker build --file Dockerfile -t satisfactory-server-image .
```

```sh
docker build --file Dockerfile -t satisfactory-server-image --no-cache=true .
```

```sh
docker build --file Dockerfile -t satisfactory-server-image:1.0.0 --no-cache=true .
```

## Run Container

```sh
docker run -d --restart no --name satisfactory-server `
  -p 7777:7777/udp -p 7777:7777/tcp `
  -p 15000:15000/udp -p 15000:15000/tcp `
  -p 15777:15777/udp -p 15777:15777/tcp `
  -v "E:\SATISFACTORY_SERVER_CONTAINER\satisfactory-server:/satisfactory-server" `
  -v "E:\SATISFACTORY_SERVER_CONTAINER\satisfactory-savegame:/home/steam/.config/Epic/FactoryGame/Saved/SaveGames" `
  satisfactory-server-image
```