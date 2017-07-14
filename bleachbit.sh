#!/bin/bash

echo -e "\n* Performing bleachbit clean..."

bleachbit --list-cleaners | egrep '^(google_chrome|firefox)' | xargs --no-run-if-empty bleachbit --clean >/dev/null
