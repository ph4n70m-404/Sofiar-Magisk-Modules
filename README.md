# Sofiar-SigSpoof
Curently only works on MSM Xtended XR 7.0, Evolution X 5.9, Bliss 14.5, and Spark vFlare.   
Might take requests on what roms to add support for.

# Installation
To install you can:
- use the online installer normally
- use an offline installer that supports your rom and version
- place one of the supported zips in /sdcard/sigspoof
- use debug mode to install an unsupported zip

# Debug mode
**Debug mode skips all rom and version checks**  
**Anything you install with debug mode will come with no support**  
Debug mode is intended to be used to test the precompiled spoofing patches on a rom before adding it to the installer. It will install a test.zip in /sdcard/sigspoof aslong as there is also a debug.txt file in /sdcard/sigspoof. You can use this to install your own precompiled spoofing patches aslong as they follow the same format as my precompiled zips. You can also use it to install older no longer supported versions from legacy builds.

# Changelog
**v4**  
cleaned up the code  
added debug mode  
changed where it downloads from  
added offline installer stuff  
started on version checking  
offline installer for archival and support for older versions added  
what versions the offline installer supports is now the release page  

**v3**  
Cleaned up the code  
Made it an online installer so its a smaller download  

**v2**  
Added support for Spark vFlare and Bliss 14.5  

**v1**  
Only supported MSM Xtended XR 7.0 and Evolution X 5.9  
