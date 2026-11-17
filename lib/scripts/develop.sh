#!/usr/bin/env bash

trap 'kill 0' SIGINT 
zathura "$1/$2.pdf" & 
typst watch "$1/$2.typ" --root .
