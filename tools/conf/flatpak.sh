#!/usr/bin/expect
set package [lindex $argv 0]
set timeout -1
spawn flatpak install flathub $package
expect {
    "Do you want to install it?*" {
        send "y\r"
        expect "Proceed with these changes to the system installation?*"
        send "y\r"
    }
    "Proceed with these changes to the system installation?*" {
        send "y\r"
    }
}
expect EOF

