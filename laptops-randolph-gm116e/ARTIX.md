# Artix Linux

**Key boot parameters:**
1.  `fbcon=font:TER16x32` = force framebuffer early
2.  Removed `quiet splash`
3.  Built-in gpu fixes: `enable_dc=0 enable_fbc=0

`splash + high res background + early fbcon` = blank screen on Gemini Lake. 
Arch works because it defaults to text mode. Artix s6 iso tries to do fancy plymouth/splash and the i915 framebuffer never comes up.

Steps to patch the ISO so it boots clean text on J4125:

### *Rebuild Artix s6 Net Installer: Text-only, no splash*

#### *1. Edit kernel params - remove splash, force fbcon*
File: `artix-iso/profiles/artix-s6-netinstall/profiledef.sh`

Change to this:
kernel_params=("i915.modeset=1" "i915.enable_dc=0" "i915.enable_fbc=0" "intel_idle.max_cstate=1" "fbcon=font:TER16x32" "loglevel=4")
max_cstate=1`

#### *2. Remove the high-res background / plymouth*
File: `artix-iso/profiles/artix-s6-netinstall/airootfs/etc/s6/service/plymouth/run`
If that file exists, delete it or comment it out. 

Also remove plymouth from packages:
File: `artix-iso/profiles/artix-s6-netinstall/packages.x86_64`
Remove: `plymouth` `artix-plymouth-theme`

#### *3. Make getty show immediately*
File: `artix-iso/profiles/artix-s6-netinstall/airootfs/etc/s6/services/agetty-tty1/run`
Make sure it looks like:
#!/bin/execlineb -P
agetty --noclear 38400 tty1 linux
`--noclear` stops it from blanking the screen before i915 is ready.

#### *4. Build it*
sudo mkarchiso -v artix-iso/profiles/artix-s6-netinstall/
You’ll get: `out/artix-s6-netinstall-xxx.iso`

Flash it and it should boot straight to a big text console on J4125.

