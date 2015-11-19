README
======

Use [starpost/docker-register-etcd](https://hub.docker.com/r/starpost/docker-register-etcd/) we obtained a etcd tree containing the most up-to-date backend instance, shown below.

```sh
# etcdctl -C 192.168.0.10:4001 ls --recursive /backends
/backends
/backends/MyBackend
/backends/MyBackend/servers/1d4533cf99b3
/backends/MyBackend/servers/1d4533cf99b3/url
```

We need to have a frontend configuration for the backend to be effective.  Similar to [Traefik etcd layout](https://github.com/emilevauge/traefik/blob/master/docs/index.md#etcd), configuration as follows.

```sh
# etcdctl -C 192.168.0.10:4001 ls --recursive /frontends
/frontends
/frontends/www.examples.com
/frontends/www.examples.com/backend

# etcdctl -C 192.168.0.10:4001 get /frontends/www.examples.com/backend
MyBackend
```

Nginx will be configured with virutal host `www.examples.com` with the backend `MyBackend`.

Sample Run:
```sh
# docker run -e ETCD_HOST=192.168.0.10:4001 \
	-d --restart=always \
	-v /data/ssl:/etc/nginx/certs \
	--name=nginx-proxy starpost/nginx-proxy-etcd
```


