#!/bin/sh

 sudo virt-install \
   --virt-type=kvm \
   --name rocky9-test \
   --ram  4096 \
   --vcpus=4 \
   --os-variant=rocky9 \
   --cdrom=/data/libvirt/default/boot/Rocky-9.4-x86_64-minimal.iso \
   --network=bridge=br0,model=virtio \
   --graphics vnc \
   --disk path=/data/libvirt/default/images/rocky9-test.qcow2,size=40,bus=virtio,format=qcow2
