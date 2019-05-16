## Install Fedy
Fedy lets you install multimedia codecs and additional software that Fedora doesn’t want to ship, such as MP3 support, Adobe Flash, Oracle Java, and much more, with just a few clicks.

To install Fedy in Fedora, follow the steps below.

First, install our release package, which adds our repos to your system:

```
dnf install https://dl.folkswithhats.org/fedora/$(rpm -E %fedora)/RPMS/fedy-release.rpm
```

Next, install RPMFusion's repositories:

```
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

Finally, install Fedy:

```
dnf install fedy
```
