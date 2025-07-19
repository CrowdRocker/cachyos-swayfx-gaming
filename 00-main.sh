#!/usr/bin/env bash
set -e
./01-base.sh
./02-swayfx.sh
./03-launchers.sh
./04-performance.sh
echo "✅ All steps completed. Reboot your system!"
