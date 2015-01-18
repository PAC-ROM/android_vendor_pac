android_vendor_pac
==================

We will not be accepting pull requests on our PAC GitHub, so please do not send hoping that you will be the exception. You will be contacted and told to use our Gerrit instead.


Instructions for sending to Gerrit
==================================

We're open source, and patches are always welcome!

Register at [Gerrit Code Review] (http://review.pac-rom.com/) and use the username that you registered with when using git-review. Make sure to add your ssh keys to your Gerrit profile. You must accept the [Contributors Agreement] (http://review.pac-rom.com/#/settings/agreements) before submitting to Gerrit.

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


Getting Started
===============

Preparing and building PAC-ROM [Guide] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/PrepareForBuild.md)


Device Maintainers
==================

Guidelines and submitting [Guide] (https://github.com/PAC-man/android_vendor_pac/blob/pac-5.0/BecomeAMaintainer.md)

