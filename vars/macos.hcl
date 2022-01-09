headless         = false
qemu_accelerator = "hvf"

iso_url           = "http://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
iso_checksum      = "http://cloud-images.ubuntu.com/releases/focal/release/SHA256SUMS"
iso_checksum_type = "file"

cpus      = "2"
memory    = "2048"
disk_size = "128000"

boot_wait           = "1m"
use_default_display = true
