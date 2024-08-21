# Edlib 3 production setup example

This repository demonstrates a production setup for Edlib 3 using Docker
Compose. You should fork this and adapt it to your own needs.

## Prerequisites

* Docker
* Admin access on your computer or server
* Port 80 (tcp) and 443 (tcp/udp) available

## Usage

1. Clone the git repository and navigate there.

2. Add to your `/etc/hosts` or `C:\Windows\System32\Drivers\etc\hosts`

   ```
   127.0.0.1 ca.localhost
   127.0.0.1 hub.localhost
   ```

   **Note for WSL users**: you must edit the hosts file belonging to Windows,
   not WSL.

   (This step is not necessary when using real host names.)

3. Copy `.env.example` to `.env` and edit it. At minimum, the following
   variables must be changed:

   * `CONTENTAUTHOR_APP_KEY`: the cryptographic secret for Content Author
   * `CONTENTAUTHOR_LTI_SECRET`: the OAuth consumer secret for Content Author
   * `HUB_APP_KEY`: the cryptographic secret for the Hub

   `CONTENTAUTHOR_APP_KEY` and `HUB_APP_KEY` must each be 32-byte base64-encoded
   secrets, prefixed with `base64:`. The following command can be used to
   generate an appropriate secret:

   ```bash
   echo "base64:$(openssl rand -base64 32)"
   ```

   `CONTENTAUTHOR_LTI_SECRET` does not need special consideration, just type
   something random and long here.

   If you wish to change the host names, change the following:

   * `CONTENTAUTHOR_HOST`
   * `HUB_HOST`

4. Bring up the services.

   ```bash
   docker compose up -d
   ```

   This may take a long time. You can check the status with:

   ```bash
   docker compose ps
   ```

5. Navigate to the `data/caddy/data/caddy/pki/authorities/local` directory, and
   install the root certificate (`root.crt`) on your computer.

   On Windows, please follow [these instructions](windows-certificates.md).

   On macOS, open the certificate in Keychain Access, then mark it as trusted
   for all purposes.

   If successful, you will be able to visit <https://hub.localhost> and
   <https://ca.localhost> without warnings.

   (This step is not necessary when using real host names.)

6. Open <https://hub.localhost/>, or your custom domain if applicable, in your
   browser.

## Setting up an admin user account

```bash
docker compose exec hub php artisan edlib:create-admin-user you@example.com
```

## Automatic HTTPS

By default, self-signed certificates are generated for the Hub and Content
Author.

To use real certificates, change the host names as described above. The web
server will attempt to request real certificates for these from Let's Encrypt.
The host names and the web server must be reachable over the public internet, or
this won't work.

## FAQ

### Opening Content Author from the Hub gives me a certificate error, why?

You accepted the certificate in the browser for the Hub, but did not install
the actual root certificate on your computer. Install the actual root
certificate and try again.

### I messed something up, how do I reset?

* Delete the `data` directory

* Delete the containers and their volumes (**this removes all data**)

  ```bash
  docker compose down --volumes
  ```

* Get the latest versions of the Docker images

  ```bash
  docker compose pull
  ```

### May I run this without HTTPS?

No. HTTPS is required due to considerations with cookies and increasing
restrictions on whether web browsers will accept them or not. Additionally,
there are a number of surprising changes in behaviour between HTTP and HTTPS
sites. Therefore, Edlib and this example setup have been developed only with
HTTPS in mind.

### How do I run behind a reverse proxy?

Since the automatic HTTPS setup isn't appropriate for reverse proxying, it is
best to disable it, and expose the individual services for proxying.

In docker-compose.yml, remove the `web` service, then add `ports` sections to
the `contentauthor-web` and `hub-web` services:

```diff
 services:
   contentauthor-web:
     # ...
+    ports:
+      - 127.0.0.1:8080:80
     # ...

   hub-web:
     # ...
+    ports:
+      - 127.0.0.1:8081:80
     # ...
```

This exposes the Hub and Content Author services on `127.0.0.1:8080` and
`127.0.0.1:8081`, respectively.

## Reporting issues

Bugs can be reported on the [Edlib issue
tracker](https://github.com/cerpus/Edlib/issues).
