###Files to edit

1.  [Dependencies] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/dependencies/)
    - We use Split-Screen (https://github.com/Split-Screen/) for dependencies. You must push ALL device and kernel repos for the device to Split-Screen. Other remotes will not be accepted.
    - The main branch should be pac-5.1 and legacy devices that can not be brought up to Android 5.x will also not be accepted.
    - We use PIC (https://github.com/Pinky-Inky-and-Clyde/) for proprietary repos. This is done to allow for all vendor files to be pulled from the same place. If your vendor files are not on PIC, please submit your vendor files via pull request to the appropriate repository. Please keep commit history by using remotes and merges.
    - Keep the file free of white spaces and formatted to look like the rest of the devices dependencies files. Yes we are all OCD.

2.  [Product make files] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/products/)
    - Found in the products directory.
    - Easiest if you copy most from another .mk file and just fill in the device specific areas correctly. Make sure you using the correct resolutions.
    - If you are using your own device overlays, don't forget to create the files. If you add them in the .mk, then you must create them or they will not be functional.

3.  [Vendor setup] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/vendorsetup.sh)
    - Self explanatory.
    - Keep alphabetical.

4.  [Contributors] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/CONTRIBUTORS.mkdn)
    - Keep alphabetical.
    - Don't forget to change the total devices at the bottom.

5.  [Nightly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/nightly.xml)/[Weekly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/weekly.xml)
    - [Nightly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/nightly.xml) - If your device qualifies (no adds/removes/extras needed) add your device here.
    - [Weekly] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/weekly.xml) - If your device uses the adds/removes/extras (mostly legacy devices) add your device here.
    - Keep alphabetical.

6.  [XDA Threads] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/docs/XDAThreads.mkdn)
    - Add your thread links here.
    - Keep it alphabetical.
    - Follow the format.

7.  [PAC Threads] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/docs/PACThreads.mkdn)
    - Add your thread links here.
    - Keep it alphabetical.
    - Follow the format.

8.  [XDA Forum Thread Template] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/docs/XDAForumThreadTemplate)
    - Just c/p to your thread.
    - Fill in the needed specific device areas.
    - PAC-ROM Downloads link should direct to PAC Forum Thread.

9.  [PAC Forum Thread Template] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/docs/PACForumThreadTemplate)
    - Just c/p to your thread.
    - Fill in the needed specific device areas.
    - Link to https://s.basketbuild.com/devs/pacman/DEVICE_CODENAME/.

10. [Devices Breakdown] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/devices-breakdown.xml)
    - Used for our dynamic changelog.
    - Keep alphabetical.

11. [Adds/Removes] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/extras/addremove/)
    - Found in the [extras/addremove] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/extras/addremove/) folder.
    - Used for legacy devices.
    - Please try to keep this as clean as possible and only use if you have to.
    - We host a ton of repos, so use extras.sh option if possible. If we don't host it, then you can use adds/removes.
    - Disqualifies your device for nightlies.

12. [Extras] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/tools/extras.sh)
    - Found in [tools] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/tools/).
    - You can add cherries, topics and queries from review page of some accounts, for more details check [Extras] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/tools/extras.sh)
    - You can save patches in the [extras/patches] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/extras/patches/) folder.
    - This injects cherry picks and patches for Gerrit and other commits.
    - If PAC hosts the repos, then please use this method by adding your patches to our repos and sending a commit to Gerrit with the patch and a DO NOT MERGE message. We will abandon the commit and you can use the [extras.sh] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.1/tools/extras.sh) file to cherry-pick during build.
    - Very easy to use and understand. (read the extras.sh file for detailed instructions)
    - Disqualifies your device for nightlies.

13. [Overlays] (https://github.com/PAC-man/android_vendor_pac/tree/pac-5.1/overlay/)
    - Found in the overlay directory.
    - Used to either find your correct overlays already created, or create your own.
    - If you have added your device to an overlay in the .mk file, then you must create your own.
    - We have ones pre-made for xxhdpi, xhdpi, hdpi, mdpi, ldpi feel free to use these.

14. Please fill out our [Application/Info Form] (http://application.pac-rom.com) BEFORE you commit your device and contact either Jaaga (madc0w.undergroundz@googlemail.com), Lokesh (lokesh.c703@gmail.com) or Chad (cbarlan@gmail.com) to be added to the maintainers group hangout.

####To send your commit, you can take this as an example: http://waka-waka.pac-rom.com

!!Your submission will not be accepted until ALL requirements according to our guidelines have been met!!

As a Maintainer you are expected to:


    1. Be able to build for your device and provide users with regular builds.
        a. You must own the device you wish to maintain. Blind builds and ports are NOT allowed!
        b. Exceptions may be made (family/friend's devices with direct access and variants of devices etc) and are to be requested BEFORE submitting your patchset to Gerrit!
        c. A Co-Maintainer may be elected for your device by you if wanted. He/she must follow the same rules as you and submit their own commit to Gerrit.
        d. Maintainers will have merge permissions to their device and kernel specific repositories and are expected to keep their device in working order. Whether this done by; doing basic upkeep with upstream changes for fixes and updates, starting for an upstream base and doing original work (pushing upstream when you can), or a mixture of both. The main concern is following proper procedure and keeping your device(s) functioning. Additionally, common and shared repositories will be worked on together by the Maintainers; they will still be controlled and merged by the PAC Team. In this respect, teamwork among Maintainers with common devices will not only be encouraged, in some cases, it may be necessary.

    2. Threads are to be compared to our templates regularly for updated topic and content changes.
        a. Templates are to be used exactly as they are with NO alterations aside the foreseen places like Title, Installation, Updating, Not working, Other info, and additional credits below the current list if any, unless permitted otherwise.
        b. Custom additions (custom builds, kernels, patches, software packages etc) are tolerated and may be distributed from the PAC-ROM thread's Downloads section of the first post.
        c. Information about any custom additions is to be posted in the 2nd post of both threads.
        d. Custom additions are your responsibility, and are not supported by the PAC-ROM Dev Team.
        e. The PAC-ROM Dev Team may change, remove, disable, or tell you to delete ANY custom additions or infringing content for any reason, at any time, in our sole discretion.
        f. If unsure, ask the reviewer you contacted.

    3. Maintainers MUST create an account on our [JIRA] (http://jira.pac-rom.com/). Users will be able to submit issues and find contact information on the Maintainer for their device such as PAC/XDA Threads. Maintainers will be required to upkeep their JIRA support.

    4. To maintain proper support and device usability across the PAC-ROM community, if a device is: abandoned, unsupported, unkempt, or devices where the Maintainer has; sold, broken, lost, no longer has and will not be replacing [within the grace period of 4 weeks], or no longer cares to maintain the device for PAC, then the device will be removed. Remember, if the device is removed and it gets further support, from someone else, then it can be resubmitted later as new.
        a. Be fair to the users, if you can not maintain the device anymore for whatever reason, please try to find a follow up maintainer, have them submit their take over changes to Gerrit, and have your threads transferred if possible. If this is not possible, please remove the device and submit your cleanup to Gerrit.

    5. Prereleases

        * Only Maintainers may publish Alpha/Prerelease builds.
        * Alpha/Prerelease build version tag should be set to UNOFFICIAL
        * Users/Unofficial device Maintainers may NOT release/post our Prerelease builds.
        * Permission for Maintainers may be revoked anytime for a Maintainer or global for all Maintainers.
        * Alpha/Prerelease builds are to be uploaded to BB/codename/Unofficial.
        * Alpha/Prerelease builds are NOT supported by PAC Dev Team or Maintainers.
        * Maintainers are to check their XDA device category for threads posting Prereleases/Unofficial builds and have them removed/closed.
        * Maintainers can use this opportunity to test and bring up their devices, users can play with cutting edge test builds and return feedback for the Maintainer at their own risk.
        * Community/Forum posts about ETA's, Prerelease device compatibility, broken or missing features, or any other acquisition of Prerelease information and support will be deleted/directed toward the Maintainer.

    6. As a Maintainer, you will be able to:

        * Get official, clean built, and automated nightly/weekly builds from Jenkins.
        * Use our file hosting for builds.
        * Use our OTA for pushing your own builds.
        * Join in on our discussions, get support from the Dev Team and other Maintainers.
        * There is no cake, it's a lie!
        * Devices that get less than 35 downloads a week are considered low activity and will be moved to weekly.xml.

    7. This page is subject to change without notice! Check back regularly here for changes.

**!!Failure to maintain your device properly will result in it being removed from nightly/weekly, and/or suspended/removed from being built!!**
