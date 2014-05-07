android_vendor_pac
==================

We will not be accepting pull requests on pac github so please do not send hoping that you will be the exception. You will be contacted and told to use gerrit.


Instructions for sending to Gerrit
====================================


    sudo apt-get install git-review
    git clone https://github.com/PAC-man/android_vendor_pac
    cd android_vendor_pac
    <make edits>
    git add -A
    git commit -m "Message"
    git-review


Register at [PAC-man Gerrit](http://review.pac-rom.com) and use the username that you registered under with git-review. Make sure to add your ssh keys to your Gerrit profile.

The git-review package will only have to be installed once.

If you are going to make extra additions, just repeat steps, but instead of using
 **git commit -m** use **git commit --amend**. Gerrit will recognize it as a new patch-set.

To view the status of your and others patches, visit [PAC-man Code Review](http://review.pac-rom.com/).


Files to Edit
==============


1. [Dependencies](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/dependencies)
   - We use cm dependencies when ever possible. If you must use other remotes please be prepared to answer why and try to limit them as much as possible.
   - We use PIC (https://github.com/Pinky-Inky-and-Clyde) for proprietary repos. This is done to allow for all vendor files to be pulled from the same place. If your vendor files are not on PIC, please submit your vendor files via pull request to the appropriate repository. Please keep commit history by using remotes and merges.
   - Keep the file free of white spaces and formated to look like the rest of the devices dependencies files. Yes we are all OCD.

2. [Product MK files](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/products)
   - Found in the Products directory.
   - Easiest if you copy most from other .mk files just fill in the device specific areas correctly. Make sure you using the correct resolutions.
   - If you are using your own device overlays don't forget to create the files. If you add them in the .mk then you must create them or they will not be functional.

3. [VendorProp](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/vendorsetup.sh)
   - Self explanatory.
   - Keep alphabetical.

4. [Contributors](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/CONTRIBUTORS.mkdn)
   - Keep alphabetical.
   - Don't forget to change the total devices at the bottom.

5. [Nightly](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/nightly.xml)/[Weekly](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/weekly.xml).xml
   - [Nightly](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/nightly.xml) - If your device qualifies (no add/remove files needed) add your device here.
   - [Weekly](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/weekly.xml) - If your device uses the add/removes (mostly legacy devices) add your device here.
   - Keep alphabetical.

6. [XDAThreads](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/XDAThreads.mkdn)
   - Add your thread links here.
   - Keep it alphabetical.
   - Follow the format.

7. [XDA Forum Thread Template](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/forum-threads/XDA_Forum_4.4_Threads_Template)
   - Just c/p to your thread.
   - Fill in the needed specific device areas.
   - Rom DL link should direct to PAC Forum Thread.

8. [PAC Forum Thread Template](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/forum-threads/Pac_Forum_4.4_threads_Template)
   - Just c/p to your thread.
   - Fill in the needed specific device areas.
   - Link to http://pacman.basketbuild.com/index.php?dir=main/(Device_CODENAME)/nightly/.

9. [devices-breakdown.xml](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/devices-breakdown.xml)
   - Used for our dynamic change-log.
   - Keep alphabetical.

10. [add/removes](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/manifest)
   - Found in the manifest directory.
   - Used for legacy devices.
   - Please try to keep this as clean as possible and only use if you have to.
   - We host a ton of repos so use cherrys.sh option if possible. If we don't host it then you can use a add/remove.
   - Disqualifies your device for nightlies.

11. [cherrie.sh](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/tools/cherries.sh)
   - Found in [tools](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/tools)/.
   - this injects cherry picks for a gerrit commit.
   - if pac hosts the repos then please us this method by adding your patches to our repos and sending a commit to gerrit with the patch and a DO NOT MERGE message. We will abandon the commit and you can use the [cherrie.sh](https://github.com/PAC-man/android_vendor_pac/blob/pac-4.4/tools/cherries.sh) file to cherry-pick during build.
   - very easy to use and understand once you look at the file.

12. [Overlays](https://github.com/PAC-man/android_vendor_pac/tree/pac-4.4/overlay)
   - Found in the overlay directory.
   - Used to either find your correct overlays already created or create your own.
   - If you have added your device to an overlay in the .mk file then you must create your own.
   - We have ones pre-made for xxhdpi, xhdpi, hdpi, mdpi, ldpi feel free to use these.

13. Contact either Chad (cbarlan@gmail.com) or Lokesh (lokesh.c703@gmail.com) to be added to the maintainers group hangout.


PAC-Script Instructions
====================================

Usage:
  build-pac.sh [options] device

    Options:
     -c# Cleaning options before build:
        1 - make clean
        2 - make dirty
        3 - make magicbrownies
     -d  Use dex optimizations
     -f  Fetch cherry-picks
     -i  Static Initlogo
     -j# Set jobs
     -s  Sync before build
     -p  Build using pipe
     -o# Select GCC O Level
         Valid O Levels are
         1 (Os) or 3 (O3)
     -v  Verbose build output

  Example:
    ./build-pac.sh -c1 hammerhead
