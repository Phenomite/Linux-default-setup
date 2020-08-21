# Linux default setup

Used to keep my distro settings in sync across devices.

## Disclaimers

* Due to kali's favourable change to user level default, the installer may do things twice upon the user level and root level.
* The bashrc may introduce some unwanted (wanted for myself) GitLab kali experimental additions

## Contents

* **README.md** - Manual instructions and resource links

* **installs.sh** - Auto setup most things (hopefully)

## Look and feel

* TTY layout files (.profile and .bashrc) looks like:

    ```bash
    ┌──(kali(🚹)test)-[~]
    └─$ su
    Password: 
    ┌──(root(🚷)test)-[/home/kali]
    └─# whoami
    root
    ```

## Manual adjustments

* Terminator preferences
  * Global > Unfocused terminal font brightness: 100%
  * Profiles > Colors > Ambience (replicate ubuntu)

## Resources

* [Firefox Stable install in debian (get lost esr)](https://wiki.debian.org/Firefox#From_Mozilla_binaries)
