---
parent: Topics
layout: default
title: "Pulse Secure"
description:  "Remotely Access the UCSB Campus Network"
indent: true
---

# {{page.title}}

If you are not connected to campus or university housing internet, you will not be able to access some online resources that are restricted to only members of our campus. For this class, this includes the shared digital copies of the course textbooks and the ECI network share which allows you to mount your CSIL home directory on your computer. 

To access these resourcs, you'll need to install the Pulse Secure VPN on your computer and configure it to connect to the university network.

## Desktop Clients (Windows, macOS, and Linux)

Start by downloading and running the correct installer for your operating system on the UCSB IT website: https://www.it.ucsb.edu/get-connected-vpn

> \* Note that you will need access to Box to download the desktop clients. We realize that certain parts of the world may not be able to access Box. In this case, please email ets-info@ucsb.edu for an alternate download link. 
>
> ** For Windows 10 users, I recommend using the Microsoft Store version instead of the installer: https://www.microsoft.com/en-us/p/pulse-secure/9nblggh3b0bp. You'll have to manually configure this client (see below), but this client saves your credentials, is integrated natively into the Windows network selector, and doesn't require Box to download.

Desktop clients downloaded from Box should already be pre-configured to work with the UCSB VPN. All you have to do is open the "Pulse Secure" app, click "Connect", and enter your UCSB NetID and password.

## Mobile Clients (iOS, Android, Chrome OS)

Start by visiting your platform's application store and downloading the Pulse Secure VPN Client:
* [iOS App Store](https://itunes.apple.com/us/app/pulse-secure/id945832041?mt=8)
* [Android Google Play Store](https://play.google.com/store/apps/details?id=net.pulsesecure.pulsesecure&hl=en)
* [Chrome Web Store](https://chrome.google.com/webstore/detail/pulse-secure/eiddfaedmgnpnnojolcknhpjbmmpplgd?hl=en-US)
* [Microsoft Store](https://www.microsoft.com/en-us/p/pulse-secure/9nblggh3b0bp)

After installing, visit https://ps.vpn.ucsb.edu/install to set up your VPN client with the UCSB network.

## Manual Configuration

As an alternative to configuring your machine using the pre-made installers or installing a deivce management profile, you can manually set up your Pulse Secure VPN client by inputting the following parameters in your VPN client configuration:

* Server name or address: `https://ps.vpn.ucsb.edu/ra`
* Username: your UCSB NetID
* Password: your UCSB NetID password

## Notes about the VPN

Each VPN session will last for twelve hours at maximum. If you don't manually disconnect within twelve hours of initially connecting, you will automatically be disconnected and you may lose unsaved work. Be sure to save often!
