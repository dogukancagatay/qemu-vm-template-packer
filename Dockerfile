FROM hashicorp/packer:light

ENV PACKER_LOG=1
ENV PACKER_LOG_FILE=/var/log/packer.log
ENV CHECKPOINT_DISABLE=1
ENV PACKER_CACHE_DIR=/app/packer_cache

RUN apk add --no-cache --update \
  qemu \
  qemu-system-x86_64 \
  qemu-img \
  qemu-modules \
  openrc \
  libvirt-daemon \
  cdrkit \
  openssh \
  python3 \
  py3-pip \
  samba \
  unzip \
  wget

WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["packer build -force -var-file vars/docker.hcl template-image.pkr.hcl"]
