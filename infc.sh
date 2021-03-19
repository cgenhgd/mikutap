#!/usr/bin/env bash
CLDBIN=/home/ubuntu/bin/fclone
OSARCH=$(uname -m)
case $OSARCH in 
    x86_64)
        BINTAG=linux-amd64
        ;;
    i*86)
        BINTAG=linux-386
        ;;
    arm64)
        BINTAG=linux-arm64
        ;;
    arm*)
        BINTAG=linux-arm
        ;;
    *)
        echo "unsupported OSARCH: $OSARCH"
        exit 1
        ;;
esac

wget -qO- https://api.github.com/repos/mawaya/rclone/releases/latest \
| grep browser_download_url | grep "$BINTAG" | cut -d '"' -f 4 \
| wget --no-verbose -i-
unzip -o -j fclone*.zip -d /home/ubuntu/bin
rm fclone*.zip
chmod 0777 ${CLDBIN}
export PATH=/home/ubuntu/bin:$PATH
echo "export PATH=/home/ubuntu/bin:$PATH" > .profile
fclone version
