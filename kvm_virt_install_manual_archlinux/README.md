# Installing ArchLinux using virt-install with KVM (manually)

## Steps

First download the ISO from https://archlinux.org/download/ and copy it to /var/lib/libvirt/boot.

Next, run `install.sh`. Example:

```sh
sh ./install.sh -n archlinux-server
```

We will install the system in BIOS mode (as opposed to UEFI mode). This is the default behavior of the the ArchLinux installer. Also we do not create a separate /boot partition. 

### Create GPT partition

Run `fdisk /dev/vda`. Type `p` to confirm the disklabel assigned to the disk. Choose `g` for GPT disklabel and `w` to write the changes to disk.

### Create BIOS boot partition

The BIOS partition must be a primary partition. Run `fdisk /dev/vda`, `n` to create a new partition, `2048` for the first sector, and `+1M` for the final size. The recommended size is 1 mebibyte.  Then change the filesystem type to BIOS boot: `t`, `4`, `w`.  

### Creating the LVM partition

Run `fdisk /dev/vda` again. Choose `n` and accept all the defaults. Before saving the changes, type `t`, `lvm`, and `w`.

### Creating the physical volume

Run `pvcreate /dev/vda2` and run `pvs` to confirm. 

### Creating the volume group

Run `vgcreate root_vg /dev/vda2` and `vgs` to confirm.

### Create the swap partition

```sh
lvcreate -L 4G -n swap root_vg
mkswap /dev/root_vg/swap
swapon /dev/root_vg/swap
```

Run `free -m` to confirm the swap space.

### Create the root partition

```sh
lvcreate -l +100%FREE -n root_lv root_vg
mkfs.xfs /dev/root_vg/root_lv
```

### Mount the partitions

```sh
mount --mkdir /dev/mapper/root_vg_root_lv /mnt
```

### Install ArchLinux

```sh
pacstrap -K /mnt base linux linux-firmware netctl
```

Generate fstab by running:

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

Set timezone.

```sh
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
```

Install additional packages.

```sh
pacman -S vim lvm2 xfsprogs grub sudo man-db man-pages which dhcpcd
```

If you forget to install dhcpcd, then you will not have an IP address on reboot unless you configure a static IP.

Edit /etc/mkinitcpio.conf, ensure HOOKS contains lvm2. The rder of the hooks matter; make sure lvm2 is loaded befoe filesystems. If you forget to add `lvm2`, then the root filesystem will not be mounted.

Rebuild initramfs.

```sh
mkinitcpio -P
```

Install grub.

```sh
grub-install --target=i386-pc /dev/vda
```

Make sure that you specify /dev/vda, which is the disk.

Generate grub.cfg

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

Set the password for the root account by running `passwd`.

Set the hostname in /etc/hostname (if desired).

Exit from the chroot by typing `exit`

Unmount /mnt by running `umount -l /mnt`

If you want to check the installation one more time, then run:

```sh
fdisk -l (shows disks)
mount /dev/mapper/root_vg-root_lv /mnt
chroot /mnt
```

Shutdown the machine by running `/sbin/shutdown -h now`

Since /etc/mkinitcpio.conf enables the fsck hook, ttyS0 will print a message saying `/usr/bin/fsck.xfs: XFS file system.` You will need to switch to a different TTY to login through the console. This is a known and expected behavior. See https://wiki.archlinux.org/title/Silent_boot for suggestions on how to change this behavior.

After the system reboots, switch to tty2 and login as root. 

To connect to the internet, you will need to enable the DHCP service.

```sh
systemctl enable dhcpcd
systemctl start dhcpcd
```

Also don't forget to edit /etc/resolv.conf so you can ping servers by hostname.

## References

https://wiki.archlinux.org/title/GRUB?utm_source=chatgpt.com
