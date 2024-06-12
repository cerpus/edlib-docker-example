# Installing self-signed root certificates on Windows

1. Open Edge. Go to **Settings**.

   ![](img/c1.png)

2. Click **Privacy, search, and services** in the left-hand pane, then scroll
   down to Security, and choose **Manage certificates**.

   ![](img/c2.png)

3. Select the **Trusted Root Certification Authorities** tab, then hit
   **Import**.

   ![](img/c3.png)

4. Click **Next** after being greeted by the wizard.

   ![](img/c4.png)

5. Hit **Browse**, pick the `root.crt` file in
   `data/caddy/data/caddy/pki/authorities/local`. Click **Next**.

   ![](img/c5.png)

6. Do not change any setting on the Certificate Store step. Click
   **Next**.

   ![](img/c6.png)

7. Thank the wizard and click **Next**.

   ![](img/c7.png)

8. A security warning will pop up, asking if you're really sure you
   want to do the thing you just did. Hit **Yes**.

   ![](img/c8.png)

9. A dialogue pops up, telling you the import was successful. Click
   **OK**.

   ![](img/c9.png)

10. Verify the "Caddy Local Authority" certificate is in the list.

   ![](img/c10.png)

11. Restart Edge or any other web browser you have running. Navigating to
    <https://hub.localhost> should now work.
