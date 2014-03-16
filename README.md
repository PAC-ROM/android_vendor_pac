android_vendor_pac
==================

We will not be accepting pull requests on pac github so please do not send hoping that you will be the exception. You will be contacted and told to use gerrit


Instructions for sending to Gerrit
====================================


1. sudo apt-get install git-review     (One time install)

2. git clone https://github.com/PAC-man/android_vendor_pac

3. cd android_vendor_pac

4. make your edits to the files below

5. git add -A

6. git commit -m "message"         (if you are fixing a mistake after initial commit use git commit --amend )

7. git-review


Files to Edit
==============


1. Dependencies
   - We use cm dependencies when ever possible. If you must use other remotes please be prepared to answer why and try to limit them as much as possible
   - We use PIC (https://github.com/Pinky-Inky-and-Clyde) for proprietary repos. This is done to allow for all vendor files to be pulled from the same place. If your vendor files are not on PIC, please submit your vendor files via pull request to the appropriate repository. Please keep commit history by using remotes and merges
   - Keep the file free of white spaces and formated to look like the rest of the devices dependencies files. Yes we are all OCD

2. Product MK files
   - Found in the Products directory
   - Easiest if you copy most from other .mk files just fill in the device specific areas correctly. Make sure you using the correct resolutions
   - If you are using your own device overlays dont forget to create the files. If you add them in the .mk then you must create them or they will not be functional

3. VendorProp
   - Self explanitory
   - Keep alphabetical

4. Contributors
   - Keep alphabetical
   - Don't forget to change the total devices at the bottom

5. Nightly/Weekly.xml
   - Nighly - If your device qualifies (no add/remove files needed) add your device here
   - Weekly - If your device uses the add/removes (mostly legacy devices) add your device here
   - Keep alphabetical

6. XDAThreads
   - Add your thread links here
   - Keep it alphabetical
   - Follow the format

7. devices-breakdown.xml
   - Keep alphabetical

8. add/removes
   - Found in the manifest directory
   - Used for legacy devices
   - Please try to keep this as clean as possible and only use if you have to
   - We host a ton of repos so use cherrys.sh option if possible. If ywe dont host it then you can use a add/remove
   - Disqualifies your device for nightlies

9. cherrys.sh
   - Found in tools/
   - this injects cherry picks for a gerrit commit
   - if pac hosts the repos then please us this method by adding your patches to our repos and sending a commit to gerrit with the patch and a DO NOT MERGE message. We will abandon the commit and you can use the cherrys.sh file to cherrypick during build
   - very easy to use and understand once you look at the file

10. Overlays
   - Found in the overlay directory.
   - Used to either find your correct overlays already created or create your own
   - If you have added your device to an overlay in the .mk file then you must create your own.
   - We have ones premade for xxhdpi, xhdpi, hdpi, mdpi, ldpi feel free to use these

11. Contact me to be added to the maintainers group hangout cbarlan@gmail.com



PAC-Script Instructions
====================================


Usage:
  build-pac.sh [options] device

  Options:
    -c  Clean before build
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
    ./build-pac.sh -c hammerhead
```
