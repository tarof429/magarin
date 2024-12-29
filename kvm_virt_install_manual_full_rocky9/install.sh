#!/bin/sh

sudo virt-install \
  --virt-type=kvm \
  --name rocky-server \
  --ram  4096 \
  --vcpus=4 \
  --os-variant=rocky9 \
  --cdrom=/data/libvirt/default/boot/Rocky-9.4-x86_64-dvd.iso \
  --network=bridge=br0,model=virtio \
  --graphics vnc \
  --disk path=/data/libvirt/default/images/rocky-server.qcow2,size=20,bus=virtio,format=qcow2 \
  --disk path=/data/libvirt/default/boot/Rocky-9.4-x86_64-dvd.iso,device=cdrom
