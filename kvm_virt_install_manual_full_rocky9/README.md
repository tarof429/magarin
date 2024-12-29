# Installing RockyLinux 9 using virt-install with KVM (manually)

## Pre-requisites

See Installing CentOS 7 using virt-install with KVM (manually).

## Steps

First download the ISO for RockyLinux 8 9 from the cloest mirror at https://rockylinux.org/download and copy it to /var/lib/libvirt/boot.

Launch a VM. To get the correct OS variant, run:

```sh
virt-install --os-variant list|grep -i rocky
```

The provided install.sh script already takes care of this. Just run:

```sh
sh ./install.sh
```

To attach an extra disk to the VM, first create the disk run:

```sh
sudo qemu-img create -f qcow2 /data/libvirt/default/images/rocky-server-data.qcow2 20G -o preallocation=full
```
  
Afterwards, attach the disk to the VM.

```sh
sudo virsh attach-disk --domain rocky-server /data/libvirt/default/images/rocky-server-data.qcow2 vdb --persistent --config
```

You do not have to shutdown the VM to do this.

To view the GUI at any time, run:

```sh
sudo virt-viewer --connect qemu:///system --wait rocky-server
```


## References

- https://access.redhat.com/articles/3166931