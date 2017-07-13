#!/bin/bash

echo -e "\n* Bleachbit Clean..."

bleachbit --list-cleaners | egrep '^(google_chrome|firefox)' | xargs --no-run-if-empty bleachbit --clean >/dev/null
