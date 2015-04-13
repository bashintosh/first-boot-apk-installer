# first-boot-apk-installer

By default Android will parse all APKs present in /data/app during the initial boot however some applications might need to be installed manually.

This simple code allows Android ROM developers to batch-install an arbitrary number of APKs on OS first boot, running in background with no user interaction required.


**Usage**

- Configure Init to properly run the script on boot by adding a service entry to your **init.rc** OR **init.vendor.rc**:

```
service firstboot /system/etc/init.d/InitFirstBoot
    class main
    user root
    group root
    oneshot
```

- Deploy the first-boot-apk-installer repository into the assigned locations /system and /data
- Deploy your APKs into the directory /data/.execonce

**Notes**

- You will need to modify/rebuild the raw images of ramdisk.img, system.img and your userdata archive
- The script deletes itself and the APKs under /data/.execonce when completed

Tested on Android Jelly Bean 4.3.1

Code released under GPLv3
