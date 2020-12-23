#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

pushd /tmp/

curl -s https://api.github.com/repos/chrislusf/seaweedfs/releases/latest \
| grep "browser_download_url.*linux_amd64\.tar\.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -

tarball="$(find . -name "*linux_amd64.tar.gz")"

tar -xzf $tarball

chmod +x weed

mv weed /usr/local/bin/

popd

location="$(which weed)"
echo "weed binary location: $location"

version="$(weed version)"
echo "weed binary version: $version"