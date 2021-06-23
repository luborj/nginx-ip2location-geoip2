#/bin/bash
if which docker >/dev/null; then
    CONTAINERS=docker
else
    CONTAINERS=podman
fi

$CONTAINERS image rm nginx-build-buster
$CONTAINERS build -t nginx-build-buster .
$CONTAINERS run --name nginx-build-buster -it -d nginx-build-buster
$CONTAINERS exec nginx-build-buster bash -c "mkdir /deb ; mv /usr/src/nginx_*.deb /deb"
$CONTAINERS cp nginx-build-buster:/deb .
sleep 2
$CONTAINERS