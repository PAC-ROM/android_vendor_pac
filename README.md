android_vendor_pac
==================

PAC-man Vendor repository

Please use the Pac Man Universal Review to push to gerrit all code changes

We will not be accepting pull requests on pac github so please do not send hoping that you will be the exception. You will be contacted and told to use gerrit

Universal Review

http://forum.xda-developers.com/showthread.php?t=2530388

Please use this link to download and get instrutions on how to use

Please ask all questions there about this script as I and a few others monitor it daily


When sending your devices to PAC-man for review please include the following files to be reviewed in one commit.

If you happen to mess up, which happens often, please use git commit --amend to send a new patchset to gerrit or you can do this in the universal review script provided.


1. Dependencies
   - We use cm dependencies when ever possible. If you must use other remotes please be prepared to answer why and try to limit them as much as possible
   - We use PIC (https://github.com/Pinky-Inky-and-Clyde) for proprietary repos. This is done to allow for all vendor files to be pulled from the same place. If your vendor files are not on PIC, please submit your vendor files via pull request to the appropriate repository.
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
   - We host a lot of repos and if we do then we can add your code into ours if at all possible
   - Disqualifies your device for nightlies

9. Overlays
   - Found in the overlay directory.
   - Used to either find your correct overlays already created or create your own
   - If you have added your device to an overlay in the .mk file then you must create your own.
   - We have ones premade for xxhdpi, xhdpi, hdpi, mdpi, ldpi feel free to use these

10. Contact me to be added to the maintainers group hangout cbarlan@gmail.com
