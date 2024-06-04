# Edlib 3 production setup example

This repository demonstrates a production setup for Edlib 3 using Docker
Compose. You should fork this and adapt it to your own needs.

## Prerequisites

* Docker
* Admin access on your computer

## Getting access to private packages

1. [Create a personal access token on GitHub][1]. It must have `read:packages`
   permissions.

2. Log in with your GitHub username and newly generated access token (**not**
   your password):

   ```
   docker login ghcr.io
   ```

3. Test that you have all the necessary access using this command:

   ```
   docker pull ghcr.io/cerpus/edlib-hub:php-latest
   ```

## Usage

1. Add to your `/etc/hosts` or `C:\Windows\System32\Drivers\etc\hosts`

   ```
   127.0.0.1 ca.localhost
   127.0.0.1 edlib.localhost
   ```

   Alternatively, use the `CONTENTAUTHOR_HOST` and `HUB_HOST` environment
   variables to host Edlib on a domain of your choosing. Note that the web
   server will attempt to request TLS certificates from Let's Encrypt for the
   host you specify:

2. Bring up the services.

   ```bash
   docker compose up -d
   ```

3. Navigate to the `caddy/data/caddy/data` directory and install the root
   certificate (if using default hosts) on your machine.

4. Open <https://hub.localhost/> in your browser.

## Setting up a user account

```
docker compose exec hub php artisan edlib:create-admin-user you@example.com
```

## Security considerations

* For a live production environment, generate new keys for Content Author and
  the Hub. Security relies on these keys being unique and secret.

## TODO

* Grant access to CA admin via hub
* Icon downloading (containers must accept self-signed certs, if any)


[1]: https://github.com/settings/tokens/new?scopes=read:packages&description=Edlib%20packages
