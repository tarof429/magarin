# Installing Ubuntu 22 using Cloud init

Another method for automated installation involves using the Cloud Init image. The example below installs Ubuntu 22.

1. First install some packages.

```sh
pacman -S cloud-init cloud-image-utils
```

You also need to install mkpasswd2. This package is used to generate the hashed password. See https://aur.archlinux.org/mkpasswd2-git.

2. Next, download the latest LTS cloud init image for Ubuntu 22. Jammy Jellyfish is at https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img. 

```sh
wget https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img
```

3. Move it to /data/libvirt/default/boot

```sh
sudo mv ubuntu-22.04-server-cloudimg-amd64.img /data/libvirt/default/boot/
```

4. Create VMs using the script `create_ubuntu_kvm.sh` which is a thin wrapper around virt-install to use cloud-init. For example:

```sh
sh ./create_seeded_ubuntu_vm.sh  -n test-ubuntu -i 192.168.1.30 -u ubuntu -p pass123 -s 40G
```

5. You can login with user `ubuntu`. The VM will already have your public key so there is no need to type in a password if using SSH.

6. You might want to update packages by running `apt update` and `apt upgrade`.
