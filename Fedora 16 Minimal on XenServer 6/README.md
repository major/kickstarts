## Fedora 16 Minimal on XenServer 6
**Synopsis**
Fedora 16 kickstart (x86_64) and a ready-to-import XenServer 6.0 template.

**Kickstart**
Relatively normal kickstart with a few interesting parts:
* DHCP networking with IPv6 enabled (but not required)
* SELinux is in enforcing mode
* extremely minimal package set
* a pre-grub2 style grub.conf is added at the end using whichever kernel is available at installation time

**XenServer Template**
Import this template via XenCenter or via the xe command line utilities on a XenServer 6 machine.

Stuff to watch for:
* there's no storage attached to the template - add your own after import
* 2GB RAM is required for anaconda to fully load (due to the big initramfs)
* boot options
  * console is on hvc0
  * serial console is enabled (no graphics)
  * GPT partitioning is disabled (GPT causes issues under XenServer)
  * kickstart network device is set to eth0
  * kickstart URL is set to pull the latest kickstart from this repository
