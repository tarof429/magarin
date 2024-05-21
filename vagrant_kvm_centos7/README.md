# CentOS 7 using Vagrant on top of KVM

## Introduction

Instead of using VirtualBox, you can use KVM to provision VMs.

As a pre-requisite, you need to set up your machine for libvirt and a storage pool called 'default'.

## Usage

Install Vagrant plugins.

```sh
export VAGRANT_DISABLE_STRICT_DEPENDENCY_ENFORCEMENT=1 
vagrant plugin install vagrant-mutate
vagrant plugin install vagrant-libvirt
```

Next, install the Vagrant box for CentOS/7.

```sh
vagrant box add centos/7 --provider libvirt
```

Finally you can bring up the machine.

```sh
vagrant up
```

The usual vagrant commands all work here.

## References

- https://www.adaltas.com/en/2018/09/19/kvm-vagrant-archlinux/

- https://wiki.archlinux.org/title/Vagrant

- https://bbs.archlinux.org/viewtopic.php?id=292146
