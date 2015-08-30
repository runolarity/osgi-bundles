#!/bin/bash
set -eux

#
# This script can be used to replace the Eclipse group id with soomething else.
#

echoerr() { echo "$@" 1>&2; }

MYPATH="$( cd "$(dirname "$0")" ; pwd -P )"
pushd "$MYPATH/.." >/dev/null


if [[ -n $(git status --porcelain) ]]; then
  echoerr "ERROR: you have uncommitted changes! working dir must be clean"
  exit 1
fi

git submodule foreach git pull origin master

if [[ -n $(git status --porcelain) ]]; then
	echo "Found EBR update; committing submodule change."
  git add ebr
  git commit -m "Update EBR"
  git push origin master
else
	echo "No updates found."
fi
