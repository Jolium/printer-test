## Setup

~~~

# Install cups
$ sudo apt update
$ sudo apt install cups

# Add user to admin group
$ sudo usermod -a -G lpadmin <username>

# Check printer name
$ lpstat -t

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
