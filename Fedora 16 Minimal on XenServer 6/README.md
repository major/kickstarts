## Fedora 16 Minimal on XenServer 6  
**Synopsis**  
Fedora 16 kickstart (x86_64) and a ready-to-import XenServer 6.0 template.  

**Kickstart**  
Relatively normal kickstart with a few interesting parts:  

*  DHCP networking with IPv6 enabled (but not required)  
*  SELinux is in enforcing mode  
*  extremely minimal package set  
*  a pre-grub2 style grub.conf is added at the end using whichever kernel is available at installation time  
  
**Getting it into XenServer**  
When you're ready to use this kickstart file, open XenCenter and follow these steps:  

*  VM -> New VM  
*  Choose "Red Hat Enterprise Linux 6.0 (64-bit)" and press Next  
*  Fill in a meaningful name  
*  Click "Install from URL:" and paste this URL:  
  *  http://mirror.rackspace.com/fedora/releases/16/Everything/x86_64/os/  
*  Press Next  
*  Paste into "Advanced OS boot parameters":  
  *  console=hvc0 serial ip=dhcp nogpt ks=http://rkrh.kr/2th  
*  Press Next  
*  Choose the XenServer node for the VM and press Next  
*  Choose any number of vCPU's but ensure memory is >= 2048MB, press Next  
*  Configure your storage and press Next  
*  Configure your network and press Next  
*  If you want to convert this VM as a template (recommended), uncheck the box at the bottom and press Finish  

To convert the VM to a template, right click it and choose "Convert To Template".  When you want to make VM's from it, right click the template and choose "Quick Create".  