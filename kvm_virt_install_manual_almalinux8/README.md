# Installing AlmaLinux 8 using virt-install with KVM (manually)

## Pre-requisites

See Installing CentOS 7 using virt-install with KVM (manually).

## Steps

First download the ISO from the cloest mirror at https://mirrors.almalinux.org/isos/x86_64/8.5.html and copy it to /var/lib/libvirt/boot.

Launch a VM. To get the correct OS variant, run:

```sh
virt-install --os-variant list|grep alma
```

Then run:

```sh
 sudo virt-install \
--virt-type=kvm \
--name alma89 \
--ram 2048 \
--vcpus=2 \
--os-variant=almalinux8 \
--cdrom=/data/libvirt/default/boot/AlmaLinux-8.9-x86_64-minimal.iso \
--network=bridge=br0,model=virtio \
--graphics vnc \
--disk path=/data/libvirt/default/images/alma89.qcow2,size=40,bus=virtio,format=qcow2
```

Note that with Alma Linux, yum is still available, but you can use `dnf` as a drop-in replacment.

```sh
dnf update
```