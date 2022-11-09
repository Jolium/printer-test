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

# Download files on home directory
$ cd
$ git clone https://github.com/Jolium/printer-test.git

# Add cronjob to crontab
$ crontab -e

# Add to the end of the file
# Runs every saturday at 14:00 (UTC +1)
0 13 * * 6 /home/<username>/printer-test/printer_test.sh

# Close crontab with ctrt+O, ctrl+X
