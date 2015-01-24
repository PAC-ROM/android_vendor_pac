##How to use Gerrit

**We're open source, and patches are always welcome!**

Register at [Gerrit Code Review] (http://review.pac-rom.com/) and use the username that you registered with when using git-review.
Make sure to add your ssh keys to your Gerrit profile.
You must accept the [Contributors Agreement] (http://review.pac-rom.com/#/settings/agreements) before submitting to Gerrit.

Commit your patches in a single commit.

**You can send patches by using these commands:**

    sudo apt-get install git-review
    git clone https://github.com/PAC-man/<project>
    cd <project>
    <make edits>
    git add -A
    git commit -m "Message"
    git-review

**The git-review package will only have to be installed once.**

**OR you can use the convential method:**

    cd <project>
    <make edits>
    git add -A
    git commit -m "Message"
    git push ssh://<username>@review.pac-rom.com:29418/<project> HEAD:refs/for/pac-5.0

**If you are going to make additional edits, just repeat steps, but instead of using:**

    git commit -m "Message"

use:

    git commit --amend

**Gerrit will recognize it as a new patch-set.**

####Important:
**If you are doing cherry pick of a patch from another author, Please use the appropriate credits,
this means that you must use the name of the author and the date of the original commit,
the original author devotes his time and effort to do so. and it is not fair that you will remove the credits,
please respect the rules.**

**You can take this line of command to set the author and original date of commit:**

    git commit --amend --author "" --date ""

**example:**

    git commit --amend --author "J.A.R.V.I.S <jarvis@stark.com>" --date "Jan 23, 2015 8:28 PM"

**To view the status of your and others' patches, visit [Gerrit Code Review] (http://review.pac-rom.com/)**
