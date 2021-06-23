#/bin/bash
if which docker >/dev/null; then
    docker image rm nginx-build-buster
    docker build -t nginx-build-buster .
    docker run --name nginx-build-buster -it -d nginx-build-buster
    docker exec nginx-build-buster bash -c "mkdir /deb ; mv /usr/src/nginx_*.deb /deb"
    docker cp nginx-build-buster:/deb .
    sleep 2
    docker rm -f nginx-build-buster
else
    podman image rm nginx-build-buster
    podman build -t nginx-build-buster .
    podman run --name nginx-build-buster -it -d nginx-build-buster
    podman exec nginx-build-buster bash -c "mkdir /deb ; mv /usr/src/nginx_*.deb /deb"
    podman cp nginx-build-buster:/deb .
    sleep 2
    podman rm -f nginx-build-buster
fi