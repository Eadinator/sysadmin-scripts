#!/bin/bash

bleachbit --list-cleaners | grep '^google_chrome' | xargs --no-run-if-empty bleachbit --clean
