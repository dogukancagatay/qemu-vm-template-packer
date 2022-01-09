# VM Template Builder

An example Qemu VM template building [Packer](https://www.packer.io/) project.

Currently, only Linux, MacOS and Docker builds are supported. Building QEMU image is not that straight forward for operating systems other than Linux. However, with the help of containers we can achieve cross platform.

Note that, we cannot use any Qemu acceleration when running in containers.

## Running on Linux

Make sure you have installed Qemu on your OS and run the following command.

```sh
packer build -force -var-file vars/linux.hcl template-image.pkr.hcl
```

## Running on MacOS

```sh
packer build -force -var-file vars/macos.hcl template-image.pkr.hcl
```

## Running in Container

The following command would build the container image and run Packer inside container that will build the Qemu VM image.

```sh
docker-compose up --build
```

Note that container image build takes considerably more time compared to Linux and MacOS builds, since it doesn't use any Qemu acceleration. If you are running the container on Linux, you can consider overriding `qemu_acceleration` variable as `kvm` on _vars/docker.hcl_ for faster builds.

### Customization of Command

Inside container the following command is run:

```sh
packer build -force -var-file vars/docker.hcl template-image.pkr.hcl
```

The command is customizable, you need to set the `command` key inside `docker-compose.yml`.

### Increase Visibility / Debug Logging

You can increase the level of visibility of Packer logs, by uncommenting `PACKER_LOGS=1` environment variable inside _docker-compose.yml_.

## Image Conversion

The output Qemu image (_qcow2_) can be converted to other VM platform formats. Inside `template-image.pkr.hcl` there are commented a _post-procesor_ block, can be enabled.

The following commands can also be used to convert image to other formats.

#### Hyper-V Conversion

```sh
qemu-img convert vm.qcow2 -O vhdx -o subformat=dynamic vm.vhdx
```

#### VMWare Conversion

```sh
qemu-img convert vm.qcow2 -O vmdk vm.vmdk
```

#### VirtualBox Conversion

```sh
qemu-img convert vm.qcow2 -O vdi vm.vdi
```

## Debugging

Setting environment `PACKER_LOG=1` enables detail logs and increase visibility of the process.

Additionally, Packer starts a VNC server at a port between 5900-6000 (port number is logged in logs on startup) which can be used to connect to the VM with a VNC viewer.

Both methods can be used when running Packer natively or in a container. Check Packer [documentation](https://www.packer.io/docs) for more debugging options.
