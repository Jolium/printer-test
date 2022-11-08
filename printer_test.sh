#!/bin/bash

cd || { echo "cd failed"; exit 1; }
lp test_page_printer.pdf


# Open crontab
# >> crontab -e

# Add to the end of the file
# # Runs every saturday at 14:00 (UTC +1)
# 0 13 * * 6 /home/<username>/printer_test.sh
