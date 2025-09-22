# Installing CentOS 9 stream using virt-install with KVM (manually)

## Steps

Download the ISO for CentOS 10 from https://www.centos.org/download/ and copy it to /var/lib/libvirt/boot.

Launch a VM. To get the correct OS variant, run:

```sh
virt-install --os-variant list|grep centos
```

The provided install.sh script already takes care of this. Just run:

```sh
sh ./install.sh
```

