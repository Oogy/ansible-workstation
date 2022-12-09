{
  "builders": [
    {
      "type": "proxmox",
      "proxmox_url": "",
      "insecure_skip_tls_verify": true,
      "username": "{{user `username`}}",
      "password": "{{user `password`}}",

      "node": "my-proxmox",
      "network_adapters": [
        {
          "bridge": "vmbr0"
        }
      ],
      "disks": [
        {
          "type": "scsi",
          "disk_size": "5G",
          "storage_pool": "local-lvm",
          "storage_pool_type": "lvm"
        }
      ],

      "iso_file": "local:iso/Fedora-Server-dvd-x86_64-29-1.2.iso",
      "http_directory": "config",
      "boot_wait": "10s",
      "boot_command": [
        "<up><tab> ip=dhcp inst.cmdline inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ks.cfg<enter>"
      ],

      "ssh_username": "root",
      "ssh_timeout": "15m",
      "ssh_password": "packer",

      "unmount_iso": true,
      "template_name": "fedora-29",
      "template_description": "Fedora 29-1.2, generated on {{ isotime \"2006-01-02T15:04:05Z\" }}"
    }
  ]
}

