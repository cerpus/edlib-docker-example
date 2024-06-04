# Edlib 3 production setup example

This repository demonstrates a production setup for Edlib 3 using Docker
Compose. You should fork this and adapt it to your own needs.

## TODO

* Admin user for CA, or CA admin via hub

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
