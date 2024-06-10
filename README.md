# Edlib 3 production setup example

This repository demonstrates a production setup for Edlib 3 using Docker
Compose. You should fork this and adapt it to your own needs.

## Prerequisites

* Docker
* Admin access on your computer or server
* Port 80 (tcp) and 443 (tcp/udp) available

## Getting access to private packages

1. [Create a personal access token on GitHub][1]. It must have `read:packages`
   permissions.

2. Log in with your GitHub username and newly generated access token (**not**
   your password):

   ```bash
   docker login ghcr.io
   ```

3. Test that you have all the necessary access using this command (the image
   should download):

   ```bash
   docker pull --platform=linux/amd64 ghcr.io/cerpus/edlib-hub:php-latest
   ```

## Usage

1. Clone the git repository and navigate there.

2. Add to your `/etc/hosts` or `C:\Windows\System32\Drivers\etc\hosts`

   ```
   127.0.0.1 ca.localhost
   127.0.0.1 hub.localhost
   ```

   **Note for WSL users**: you must edit the hosts file belonging to Windows,
   not WSL.

   (This is not necessary when using real host names.)

3. Bring up the services.

   ```bash
   docker compose up -d
   ```

   This may take a long time. You can check the status with:

   ```bash
   docker compose ps
   ```

4. Navigate to the `data/caddy/data/caddy/pki/authorities/local` directory and
   install the root certificates that have been automatically generated in this
   directory on your computer.

   You will need to look up how this works on your operating system. If
   successful, you will be able to visit <https://hub.localhost> and
   <https://ca.localhost> without warnings.

   (This is not necessary when using real host names.)

5. Open <https://hub.localhost/>, or your custom domain if applicable, in your
   browser.

## Setting up an admin user account

```bash
docker compose exec hub php artisan edlib:create-admin-user you@example.com
```

## Environment variables

For a local setup, you do not have to customise anything, but for a live
environment, you will want to change these:

* `CONTENTAUTHOR_HOST`: the host name for Content Author (defaults to
  `ca.localhost`).
* `CONTENTAUTHOR_KEY`: the OAuth consumer key for Content Author.
* `CONTENTAUTHOR_SECRET`: the OAuth consumer secret for Content Author.
* `HUB_HOST`: the host name for the Hub (defaults to `hub.localhost`).

It is **critical** to not be using the default key/secret in a live
environment. The databases are not exposed on the network, so using the
defaults is fine for these.

You can add these in a `.env` file, which Docker will read, e.g.:

```
CONTENTAUTHOR_KEY=contentauthor
HUB_HOST=hub.edlib.example.com
# more stuff ...
```

## Automatic HTTPS

By default, self-signed certificates are generated for the Hub and Content
Author.

To use real certificates, change the host names as described above. The web
server will attempt to request real certificates for these from Let's Encrypt.
The hostnames and the web server must be reachable over the public internet, or
this won't work.

## FAQ

### Opening Content Author from the Hub gives me a certificate error, why?

You accepted the certificate in the browser for the Hub, but did not install
the actual root certificate on your computer. Install the actual root
certificate and try again.

### I messed something up, how do I reset?

* Delete the contents of `data`

* ```bash
  docker compose down --volumes
  ```

### May I run this without HTTPS?

No. HTTPS is required due to considerations with cookies and increasing
restrictions on whether web browsers will accept them or not. Additionally,
there are a number of surprising changes in behaviour between HTTP and HTTPS
sites. Therefore, Edlib and this example setup have been developed only with
HTTPS in mind.


[1]: https://github.com/settings/tokens/new?scopes=read:packages&description=Edlib%20packages
