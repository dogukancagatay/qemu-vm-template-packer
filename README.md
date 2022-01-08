# Build Qemu from Container

Even if [Packer](https://www.packer.io/) is a cross platform tool, building QEMU image is not that easy and straight forward for operating systems other than Linux. However, with the help of containers we can achieve cross platform build even on CI/CD pipelines.

This is a demonstration of cross platform building Qemu images with containers.

Note that, we cannot use any Qemu acceleration when running in container.

## Running in Container

The following command would build the container image and run Packer inside container that will build the Qemu VM image.

```sh
docker-compose up --build
```

### Customization of Command

Inside container the following command is run:

```sh
packer build -force -var-file vars/docker.hcl template-image.pkr.hcl
```

The command is customizable, you need to set the `command` key inside `docker-compose.yml`.

### Increase Visibility / Debug Logging

You can increase the level of visibility of Packer logs, by uncommenting `PACKER_LOGS=1` environment variable inside _docker-compose.yml_.

## Running on Linux

Make sure you have installed Qemu on your OS and run the following command.

```sh
packer build -force template-image.pkr.hcl
```

## Running on MacOS

```sh
packer build -force -var-file vars/macos.hcl template-image.pkr.hcl
```

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
