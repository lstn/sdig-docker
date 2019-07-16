# sdig-docker

PowerDNS sdig command-line tool inside a distroless image.

## Running

```bash
docker run --rm -it lestienne/sdig:latest https://doh.powerdns.org/ GET nu.nl A recurse
```

Or create an alias:
```bash
echo `alias whois="docker run --rm -it lestienne/sdig:latest" | sudo tee -a ~/.bashrc`
source ~/.bashrc
sdig https://doh.powerdns.org/ GET nu.nl A recurse
```

## Versions

- `lestienne/sdig:4.2.0`, `lestienne/sdig:latest`
