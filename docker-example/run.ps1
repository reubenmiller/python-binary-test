[cmdletbinding()]
Param()
$IMAGE = "armel:jessie"
docker build -t $IMAGE .

if ($LASTEXITCODE -ne 0) {
    Write-Warning "Failed to build image: $IMAGE"
    return
}

# docker run -it -v "$(pwd):/root/build" $IMAGE python3.7 -c "import urllib.request; print(urllib.request.urlopen('http://google.com').read())"

Write-Host "Creating exodus script"
docker run -it -v "$(pwd):/root/build" $IMAGE /bin/bash -c 'exodus --add /usr/lib/arm-linux-gnueabi/libssl.so.1.1 --add /usr/lib/arm-linux-gnueabi/libcrypto.so.1.1 --add /usr/local/lib/python3.7 --add /usr/lib/python3.7 $(which python3.7)'

$DEPLOY_IMAGE = "${IMAGE}test1"

Write-Host "Installing exodus script in a new docker image"
docker build -t $DEPLOY_IMAGE -f Dockerfile.test1 .

if ($LASTEXITCODE -ne 0) {
    Write-Warning "Failed to build image: $DEPLOY_IMAGE"
    return
}

docker run -it $DEPLOY_IMAGE python3.7 -c "import urllib.request; print(urllib.request.urlopen('http://google.com').read())"