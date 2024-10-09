#!/bin/sh

 sudo virt-install \
    --virt-type=kvm \
    --name almalinux9 \
    --ram  4096 \
    --vcpus=4 \
    --os-variant=almalinux9 \
    --cdrom=/data/libvirt/default/boot/AlmaLinux-9-latest-x86_64-minimal.iso \
    --network=bridge=br0,model=virtio \
    --graphics vnc \
    --disk path=/data/libvirt/default/images/almalinux9.qcow2,size=40,bus=virtio,format=qcow2
