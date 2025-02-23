# Satisfactory Server Game

## Liberação do Firewall 

### Windows

```ps1
New-NetFirewallRule -DisplayName "Allow Satisfactory default inbound ports UDP" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol UDP -LocalPort 15000,15777,7777
```

```ps1
New-NetFirewallRule -DisplayName "Allow Satisfactory default inbound ports TCP" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 15000,15777,7777
```

### Linux

## Build

```sh
docker build --file dockerfile -t satisfactory-server-image --no-cache=true .
```

## Execução do container

### Versão 1.0

```sh
docker run -d `
  -p 7777:7777/udp `
  -p 7777:7777/tcp `
  -p 15000:15000/udp `
  -p 15000:15000/tcp `
  -p 15777:15777/udp `
  -p 15777:15777/tcp `
  -v E:\SATISFACTORY_SERVER_CONTAINER:/satisfactory/ `
  -v E:\SATISFACTORY_SAVE_FILES:/home/steam/.config/Epic/FactoryGame/Saved/SaveGames `
  --name satisfactory `
  satisfactory-server-image
```

### Versão 2.0

```sh
docker run -d `
  -p 7777:7777/udp `
  -p 7777:7777/tcp `
  -p 15000:15000/udp `
  -p 15000:15000/tcp `
  -p 15777:15777/udp `
  -p 15777:15777/tcp `
  -v E:\SATISFACTORY_SERVER_DOCKER\server:/satisfactory/ `
  -v E:\SATISFACTORY_SERVER_DOCKER\savegame:/satisfactory-savegame `
  -v E:\SATISFACTORY_SERVER_DOCKER\home:/home/steam/.config/Epic `
  --name satisfactory `
  satisfactory-server-image
```

```sh
docker run -d -p 7777:7777/udp -p 7777:7777/tcp -p 15000:15000/udp -p 15000:15000/tcp -p 15777:15777/udp -p 15777:15777/tcp -v E:\SATISFACTORY_SERVER_DOCKER\server:/satisfactory/ -v E:\SATISFACTORY_SERVER_DOCKER\savegame:/satisfactory-savegame -v E:\SATISFACTORY_SERVER_DOCKER\home:/home/steam/.config/Epic --name satisfactory satisfactory-server-image
```

## Versão 3.0

### Linux

```sh
docker run -d \
  -p 7777:7777/udp \
  -p 7777:7777/tcp \
  -p 15000:15000/udp \
  -p 15000:15000/tcp \
  -p 15777:15777/udp \
  -p 15777:15777/tcp \
  -v E:\\SATISFACTORY_SERVER_CONTAINER/home:/home \
  -v E:\\SATISFACTORY_SERVER_CONTAINER/satisfactory:/satisfactory \
  -v E:\\SATISFACTORY_SERVER_CONTAINER/satisfactory-savegame:/satisfactory-savegame \
  --name satisfactory \
  satisfactory-server-image:latest
```

### Windows

```sh
docker build --file Dockerfile -t satisfactory-server-image .
```

```sh
docker build --file Dockerfile -t satisfactory-server-image --no-cache=true .
```

```sh
docker build --file Dockerfile -t satisfactory-server-image:1.0.0 --no-cache=true .
```

```sh
docker run -d --restart no --name satisfactory-server `
  -p 7777:7777/udp -p 7777:7777/tcp `
  -p 15000:15000/udp -p 15000:15000/tcp `
  -p 15777:15777/udp -p 15777:15777/tcp `
  -v "E:\SATISFACTORY_SERVER_CONTAINER\satisfactory-server:/satisfactory-server" `
  -v "E:\SATISFACTORY_SERVER_CONTAINER\satisfactory-savegame:/satisfactory-savegame" `
  satisfactory-server-image
```

```sh
docker run -d --restart no --name satisfactory-server `
  -p 7777:7777/udp -p 7777:7777/tcp `
  -p 15000:15000/udp -p 15000:15000/tcp `
  -p 15777:15777/udp -p 15777:15777/tcp `
  satisfactory-server-image
```