#!/bin/bash
set -e
#set -xv

echo "Detecting changes to wheels/..."

git diff --quiet "$TRAVIS_COMMIT_RANGE" -- || GIT_DIFF_EXIT_CODE=$?
if [ "$GIT_DIFF_EXIT_CODE" -gt 1 ]; then
    git remote set-branches --add origin master
    git fetch
    TRAVIS_COMMIT_RANGE=origin/master...
fi
echo "\$TRAVIS_COMMIT_RANGE is $TRAVIS_COMMIT_RANGE"

git diff --color=never --name-status "$TRAVIS_COMMIT_RANGE" -- wheels/

while read op path; do
    case "${path##*/}" in
        meta.yml)
            ;;
        *)
            continue
            ;;
    esac
    case "$op" in
        A|M)
            echo "$op $path"
            echo "${path}" >> __wheels.txt
            ;;
    esac
done < <(git diff --color=never --name-status "$TRAVIS_COMMIT_RANGE" -- wheels/)
