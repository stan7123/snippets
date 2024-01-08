Prepare your SSL certificate for the domain where application will be available. 
You can generate self-signed certificate for testing on localhost using following steps:

```
./create_certificate.sh
```

When using cURL or other tools for requests, you will get errors that the certificate is not valid.
To make errors disappear you can:
1. Add `--insecure` or `-k` to cURL requests.
2. Install self-signed certificate into system with:
```bash
sudo cp selfsignCA.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

Note: Browsers need additional steps to treat self-signed certificate as trusted.
