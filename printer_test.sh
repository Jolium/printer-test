#!/bin/bash

cd "$(dirname "$0")" || exit 1
lp printer_test_page.pdf >> printer_test.log 2>&1
