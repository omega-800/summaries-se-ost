#!/bin/sh

./.git/hooks/pre-commit && git add . && git commit -m "$1" && git push
