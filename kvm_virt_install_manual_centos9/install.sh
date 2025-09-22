#!/bin/sh

HOSTNAME=""
SIZE="45"
ISO="/data/libvirt/default/boot/CentOS-Stream-9-latest-x86_64-dvd1.iso"
OS_VARIANT="centos-stream9"

usage() {
    echo "Usage: install.sh -n <hostname>"
    echo "Example: install.sh -n centos-server"
}

validate() {
    error=0

    if [ "${HOSTNAME}" = "" ]; then
        echo "Missing -n <hostname>"
        error=1
    fi

    if [ "$error" -eq 1 ]; then
        usage
        exit
    fi
}

while getopts ":hn:i:" option; do
    case $option in
        h)
            usage
            exit;;
        n)
            HOSTNAME="${OPTARG}"
            ;;
        \?)
            echo "Invalid option: ${OPTARG}"
            usage
            exit;;
   esac
done

shift $((OPTIND -1))

echo $HOSTNAME

CWD=`pwd`

validate

sudo virt-install \
   --virt-type=kvm \
   --name ${HOSTNAME} \
   --ram  4096 \
   --vcpus=4 \
   --os-variant=${OS_VARIANT} \
   --cdrom=${ISO} \
   --network=bridge=br0,model=virtio \
   --graphics vnc \
   --disk path=/data/libvirt/default/images/${HOSTNAME}.qcow2,size=40,bus=virtio,format=qcow2
