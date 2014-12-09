android_vendor_pac
==================

We will not be accepting pull requests on our PAC GitHub, so please do not send hoping that you will be the exception. You will be contacted and told to use our Gerrit instead.


Instructions for sending to Gerrit
==================================

We're open source, and patches are always welcome!

Register at [Gerrit Code Review] (http://review.pac-rom.com/) and use the username that you registered with when using git-review. Make sure to add your ssh keys to your Gerrit profile. You must accept the [Contributors Agreement] (http://review.pac-rom.com/#/settings/agreements/) before submitting to Gerrit.

Commit your patches in a single commit.

You can send patches by using these commands:

    sudo apt-get install git-review
    git clone https://github.com/PAC-man/<project>
    cd <project>
    <make edits>
    git add -A
    git commit -m "Message"
    git-review

OR you can use the convential method:

    cd <project>
    <make edits>
    git add -A
    git commit -m "Message"
    git push ssh://<username>@review.pac-rom.com:29418/<project> HEAD:refs/for/pac-5.0


The git-review package will only have to be installed once.

If you are going to make additional edits, just repeat steps, but instead of using:

    git commit -m "Message"

use:

    git commit --amend

Gerrit will recognize it as a new patch-set.

To view the status of your and others' patches, visit [Gerrit Code Review] (http://review.pac-rom.com/).


Files to edit
=============

1.  [Dependencies] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/dependencies/)
    - We use CM dependencies whenever possible. If you must use other remotes, please be prepared to answer why and try to limit them as much as possible.
    - We use PIC (https://github.com/Pinky-Inky-and-Clyde/) for proprietary repos. This is done to allow for all vendor files to be pulled from the same place. If your vendor files are not on PIC, please submit your vendor files via pull request to the appropriate repository. Please keep commit history by using remotes and merges.
    - Keep the file free of white spaces and formated to look like the rest of the devices dependencies files. Yes we are all OCD.

2.  [Product make files] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/products/)
    - Found in the products directory.
    - Easiest if you copy most from another .mk file and just fill in the device specific areas correctly. Make sure you using the correct resolutions.
    - If you are using your own device overlays, don't forget to create the files. If you add them in the .mk, then you must create them or they will not be functional.

3.  [Vendor setup] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/vendorsetup.sh)
    - Self explanatory.
    - Keep alphabetical.

4.  [Contributors] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/CONTRIBUTORS.mkdn)
    - Keep alphabetical.
    - Don't forget to change the total devices at the bottom.

5.  [Nightly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/nightly.xml)/[Weekly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/weekly.xml)
    - [Nightly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/nightly.xml) - If your device qualifies (no adds/removes/cherries needed) add your device here.
    - [Weekly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/weekly.xml) - If your device uses the adds/removes/cherries (mostly legacy devices) add your device here.
    - Keep alphabetical.

6.  [XDA Threads] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/XDAThreads.mkdn)
    - Add your thread links here.
    - Keep it alphabetical.
    - Follow the format.

7.  [PAC Threads] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/PACThreads.mkdn)
    - Add your thread links here.
    - Keep it alphabetical.
    - Follow the format.

8.  [XDA Forum Thread Template] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/forum-threads/XDA_Forum_5.0_Threads_Template)
    - Just c/p to your thread.
    - Fill in the needed specific device areas.
    - PAC-ROM Downloads link should direct to PAC Forum Thread.

9.  [PAC Forum Thread Template] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/forum-threads/Pac_Forum_5.0_threads_Template)
    - Just c/p to your thread.
    - Fill in the needed specific device areas.
    - Link to https://s.basketbuild.com/devs/pacman/DEVICE_CODENAME/.

10. [Devices Breakdown] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/devices-breakdown.xml)
    - Used for our dynamic changelog.
    - Keep alphabetical.

11. [Adds/Removes] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/manifest/)
    - Found in the manifest directory.
    - Used for legacy devices.
    - Please try to keep this as clean as possible and only use if you have to.
    - We host a ton of repos, so use cherries.sh option if possible. If we don't host it, then you can use adds/removes.
    - Disqualifies your device for nightlies.

12. [Cherries] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/tools/cherries.sh)
    - Found in [tools] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/tools/).
    - You can save patches in the [patches] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/tools/patches/) folder.
    - This injects cherry picks and patches for Gerrit and other commits.
    - If PAC hosts the repos, then please use this method by adding your patches to our repos and sending a commit to Gerrit with the patch and a DO NOT MERGE message. We will abandon the commit and you can use the [cherries.sh] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/tools/cherries.sh) file to cherry-pick during build.
    - Very easy to use and understand. (read the cherries.sh file for detailed instructions)
    - Disqualifies your device for nightlies.

13. [Overlays] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.0/overlay/)
    - Found in the overlay directory.
    - Used to either find your correct overlays already created, or create your own.
    - If you have added your device to an overlay in the .mk file, then you must create your own.
    - We have ones pre-made for xxhdpi, xhdpi, hdpi, mdpi, ldpi feel free to use these.

14. Contact either Jaaga (madc0w.undergroundz@googlemail.com), Lokesh (lokesh.c703@gmail.com) or Chad (cbarlan@gmail.com) to be added to the maintainers group hangout.


PAC build script instructions
=============================

Usage:
  build-pac.sh [options] device

  Options:
    -a  Disable ADB authentication and set root access to Apps and ADB
    -c# Cleaning options before build:
        1 - Run make clean
        2 - Run make installclean
    -f  Fetch cherry-picks
    -j# Set number of jobs
    -k  Rewrite roomservice after dependencies update
    -r  Reset source tree before build
    -s# Sync options before build:
        1 - Normal sync
        2 - Make snapshot
        3 - Restore previous snapshot, then snapshot sync
    -p  Build using pipe
    -t# Build with a different recovery: (Extreme caution, ONLY for developers)
        1 - Build TWRP Recovery (Extreme caution, ONLY for developers)
        2 - Build CM Recovery (Extreme caution, ONLY for developers)
        (This may produce an invalid recovery. Use only if you have the correct settings for these)
    -v  Verbose build output

  Example:
    ./build-pac.sh -c1 hammerhead
