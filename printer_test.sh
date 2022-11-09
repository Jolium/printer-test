#!/bin/bash

cd || { echo "cd failed"; exit 1; }
lp test_page_printer.pdf
