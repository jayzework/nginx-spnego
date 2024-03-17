#NGINX with SPNEGO module
Reference: [fclmann\alpine-nginx-spnego](https://github.com/fclmman/alpine-nginx-spnego)

Docker image with SPNEGO module added through NGINX dynamic modules
Nginx Image: [Here](https://hub.docker.com/_/nginx)
SPNEGO Module: [Here](https://github.com/fclmman/alpine-nginx-spnego)

To use, a keytab file is required. [See here](https://support.kaspersky.com/KWTS/6.1/en-US/206091.htm) to generate a keytab file.
On the top of the `nginx.conf` file, include to support dynamic module
```
load_module modules/spnego-http-auth-nginx-module.so;
```

Set necessary GSS AUTH on your conf files
Example:
```
auth_gss on;
auth_gss_keytab <directory_you_mount_at>;
```
Refer to SPNEGO module on top for more configuration references.
