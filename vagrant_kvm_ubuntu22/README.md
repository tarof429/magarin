# Ubuntu 22 using Vagrant on top of KVM

## Introduction

This is a variation of vagrant_kvm_centos7, using Ubuntu 22 instead. See that example if it is your first time to create VMs using Vagrant using the KVM provider.

Use the following command to add the Box for Ubuntu 22.

```sh
 vagrant box add generic/ubuntu2204 --provider libvirt
```