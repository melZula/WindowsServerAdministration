@echo off
 
set /p mode= Input mode. 1 - auto. 2 - manual:
 
if "%mode%" == "1" (
    netsh interface ipv4 set address name="Ethernet" source=dhcp
    netsh interface ipv4 set dnsservers name="Ethernet" source=dhcp
    )
 
if "%mode%" == "2" (
    netsh interface ipv4 set address name="Ethernet" static 192.168.1.10 255.255.255.0 192.168.1.1
    netsh interface ipv4 set dns name="Ethernet" static 8.8.8.8
    )
