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

Note that with RockyLinux, yum is still available, but you can use `dnf` as a drop-in replacment.

```sh
dnf update
dnf upgrade
```

RockyLinux 9 doesn't let you login through the console by default. You can use virt-viewer to login through the console, which can be handy if you don't know the IP of the VM.

```sh
sudo virt-viewer --connect qemu:///system --wait rocky9-test
```

To fix this, use grubby. The command below updates the argument for all kernels.

```
grubby --update-kernel=ALL --args="console=ttyS0,115200
```


RockyLinux 9 uses NetworkManager to configure networking. Under /etc/NetworkManager/system-connections, create a file like the following:

```sh
$ sudo cat enp1s0.nmconnection 
[connection]
id=enp1s0
type=ethernet
interface-name=enp1s0
permissions=

[ipv4]
address=192.168.1.109/24
dns=8.8.8.8,8.8.4.4
gateway=192.168.1.1
method=manual
```

After making the change, restart the NetworkManager service.

```sh
sudo systemctl restart NetworkManager
```

You can view network settings by running:

```sh
nmcli -p device show enp1s0
```

## References

- https://access.redhat.com/articles/3166931