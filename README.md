## Setup

~~~

# Install cups
$ sudo apt update
$ sudo apt install cups

# Add user to admin group (log out and back in for it to take effect)
$ sudo usermod -a -G lpadmin <username>

# Find the printer. CUPS does not add queues automatically:
# "lpstat: No destinations added." means no queue exists yet.
# Network printers need mDNS discovery
$ sudo apt install avahi-daemon cups-ipp-utils
$ lpinfo -v

# Look for usb://... (USB) or ipp://, ipps://, dnssd://... (network)
# Nothing listed? Check the printer is on, and `lsusb` for USB

# Add the queue with the URI from lpinfo, in quotes.
# -m everywhere is driverless IPP: works on most printers made after ~2015.
# -E must come AFTER -v, otherwise it means "encrypt connection to server"
$ sudo lpadmin -p <printer-name> -v "<uri>" -m everywhere -E

# Example (HP DeskJet 2700 over the network):
# sudo lpadmin -p DeskJet2700 -v "ipps://HP%20DeskJet%202700%20series%20%5B4913BE%5D._ipps._tcp.local/" -m everywhere -E

# Prefer the mDNS .local name over an IP: it survives the printer changing IP.
# Set a DHCP reservation in the router so the IP is stable as a fallback.

# Set default printer
$ lpoptions -d <printer-name>

# Check if printer is the default printer
$ lpstat -t

# Retry instead of pausing the queue when the printer is offline
$ sudo lpadmin -p <printer-name> -o printer-error-policy=retry-job

# Retry every 5 min for ~10 hours (covers a printer that is off overnight)
$ sudo nano /etc/cups/cupsd.conf
# Add:
JobRetryInterval 300
JobRetryLimit 120
$ sudo systemctl restart cups

# Download files on home directory
$ cd
$ git clone https://github.com/Jolium/printer-test.git

# Add execute permission to file
$ chmod +x printer-test/printer_test.sh

# Add cronjob to crontab
$ crontab -e

# Add to the end of the file
# Runs every saturday at 14:00 (UTC +1)
0 13 * * 6 /home/<username>/printer-test/printer_test.sh

# Or every 2 weeks (even-numbered saturdays)
0 13 * * 6 [ $(($(date +\%s) / 604800 \% 2)) -eq 0 ] && /home/<username>/printer-test/printer_test.sh

# Close crontab with ctrt+O, ctrl+X
