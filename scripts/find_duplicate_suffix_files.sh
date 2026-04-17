#!/usr/bin/env bash
find . -type f | grep -E " \([0-9]+\)\." || true
