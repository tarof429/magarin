# Installing CentOS 7 using virt-install with KVM (manually)

## Introduction

CentOS 7 can be installed manually using KVM and virt-viewer.

## Pre-requisites

Since we need acces to the VM's console, install tigervnc and virt-viewer

```bash
sudo pacman -S tigervnc virt-viewer
```

Secure the vncserver. This will ask for a password. You do not need to specify a view-only pasword. As normal user, run:

```
vncpasswd
```

On your home system, setting a view-only password is optional.

Next, start vncserver (if it isn't running already)

```bash
vncserver :0
```

## Manually Instaling Linux

Next, we will install Linux manually using an ISO.

### Installing CentOS 7

First download the ISO from the cloest mirror at https://www.centos.org/download/ and copy it to /data/libvirt/boot.

Launch a VM

```sh
 sudo virt-install \
--virt-type=kvm \
--name centos7 \
--ram 2048 \
--vcpus=2 \
--os-variant=centos7.0 \
--cdrom=/data/libvirt/default/boot/CentOS-7-x86_64-Minimal-2009.iso \
--network=bridge=br0,model=virtio \
--graphics vnc \
--disk path=/data/libvirt/default/images/centos7.qcow2,size=40,bus=virtio,format=qcow2
```

virt-viewer immmediately shows the CentOS 7 install spalash screen. This is fine if we have access to the display directly. However, to connect to the display remotely, we also need to do SSH tunneling.

```sh
$ sudo virsh dumpxml centos7 |grep vnc
    <graphics type='vnc' port='5900' autoport='yes' listen='127.0.0.1'>
```

Then run do SSH tunneling from the remote machine.

```
ssh localhost -L 5900:127.0.0.1:5900
```

In another terminal, start vncviewer and set the VNC server to localhost:5900. 

```
vncviewer
```

From here, we can proceed to manually install CentOS 7.
