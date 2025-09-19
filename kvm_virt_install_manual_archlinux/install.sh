#!/bin/sh

#!/bin/sh

HOSTNAME=""
SIZE="45"
ISO="/data/libvirt/default/boot/archlinux-x86_64.iso"

usage() {
    echo "Usage: install.sh -n <hostname>"
    echo "Example: install.sh -n archlinux-server"
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
   --os-variant=archlinux \
   --cdrom=/data/libvirt/default/boot/archlinux-x86_64.iso \
   --network=bridge=br0,model=virtio \
   --graphics vnc \
   --console=pty,target_type=serial \
   --disk path=/data/libvirt/default/images/${HOSTNAME}.qcow2,size=${SIZE},bus=virtio,format=qcow2
