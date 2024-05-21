# Installing CentOS 7 on KVM Using Kickstart

edhat-based Linux generates a kickstart file that can be used to automatically install the OS. 


First, install cdrtools.

```
pacman -S cdrtools
```

Next, install CentOS 7 manually. Once the OS is booted up, you can copy /root/anaconda-ks.cfg to your localhost. A sample is provided at anaconda-ks.cfg, which you can copy to /root/anaconda-ks.cfg.

Finally we can install the VM.

```sh
sudo virt-install \
--virt-type=kvm \
--name myvm \
--ram 4096 \
--vcpus=2 \
--os-variant=centos7.0 \
--location=/data/libvirt/default/boot/CentOS-7-x86_64-Minimal-2009.iso \
--network=bridge=br0,model=virtio \
--graphics none \
--console=pty,target_type=serial \
--disk path=/data/libvirt/default/images/myvm.qcow2,size=40,bus=virtio,format=qcow2 \
--initrd-inject=/root/anaconda-ks.cfg \
-x "ks=file:/anaconda-ks.cfg" \
--extra-args "console=ttyS0 serial"
```

This method won't ask any questions.
