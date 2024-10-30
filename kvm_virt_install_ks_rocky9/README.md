# Installing Rocky 9 on KVM Using Kickstart

## Steps

1. Download the latest Rocky cloud init image from https://rockylinux.org/download and move it to /data/libvirt/default/boot

```sh
sudo mv Rocky-9-GenericCloud-Base.latest.x86_64.qcow2 /data/libvirt/default/images
```

Now install Rocky.

```sh
sh ./install.sh -n test -i 192.168.1.201
```