# Origin

This repository provides everything you need to get [GeneValidator App](https://wurmlab.com/tools/genevalidator/) (or [GitHub repo](https://github.com/wurmlab/genevalidator)) up and running either in Docker Compose stack (on your local computer or on on-premise or virtual/cloud server) or in AWS ECS environment (work in progress).

# Running GeneValidatior in Docker locally/on-premises with HTTP only (without SSL)

This method will provide simple way to run Genevalidator app locally.

## Prerequisites

You need to have docker engine with docker compose plugin installed See [here](https://docs.docker.com/engine/) for more details.

## Main procedure

All you need to do is to checkout this repository, (if you checkout the main GeneValidator repo with submodule go to the `docker` directory first) and run the following command:

```bash
docker compose up -d
```

You should be able to reach the instance on [http://localhost](http://localhost). 

## Variations

If you have a hostname to use, set it up in `./nginx/local_http.conf` on the line `server_name`.

If you want to use it for several people, you should increase number of workers to run. To do this, change 1 to desired number of workers in file `docker-compose.yml` in enviroment variable `NUMWORKERS`.

# Running GeneValidator in Docker locally/on-premises with HTTPS (with HTTP)

## Prerequisites

You need to have docker engine with docker compose plugin installed See [here](https://docs.docker.com/engine/) for more details. You also need to have hostname reachable from the Internet to get certificates for. You need to make sure that ports 80 and 443 on the machine where you want to run GeneValidator are also accessible from the Internet.

## Self-signed certificates

The case of self-signed certificates are not considered here because no use-case can be found. There are plenty of guides on generating self-signed certificates on the Internet. To use self-signed certificate all you need to do is to uncomment the following line in `docker-compose.yml`
```
- 443:443 # Uncomment for SSL local setup only
```
add a volume binding your host certificate location into `proxy` container and in `./nginx/conf.d/` change `local_http.conf` -> `local_http.conf.bak`, `local_https_challenge.conf.bak` -> `local_https_challenge.conf` and `local_https_main.conf.bak` -> `local_https_main.conf`. Finally, you need to change paths to certificate and private key in the `local_https_main.conf`. And you can use it.

## Generating certificates using Let's Encrypt certbot

In `./nginx/conf.d/`, rename `local_http.conf` -> `local_http.conf.bak`, `local_https_challenge.conf.bak` -> `local_https_challenge.conf`. Also in `docker-compose.yml` you should uncomments lines which has `# Uncomment for SSL local setup only`.

Also in the files `local_https_challenge.conf`, `local_https_main.conf`and `.env` you should add your hostname instead of `<actual host for which certificate was obtained>`.

Now start the main docker stack as follows:
```bash
docker compose up -d
```

After that, certbot container should run to generate certificates. To do this, just run 
```bash
docker compose up -f docker-compose-LE.yml
```
You should see output of `certbot` and make sure that the certificate and private key was generated.

After that, you should rename `local_https_main.conf.bak` -> `local_https_main.conf` in `./nginx/conf.d/`. No need to restart docker stack as modified nginx image should automatically reload setting files if they change.

After that if you go to https://<your hostname> you should get GeneValidator.

# Running GeneValidator in AWS Elastic Container Service using HTTP only (no SSL)

See [here](AWS/) for more details.