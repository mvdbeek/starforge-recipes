#!/bin/bash
set -e
#set -xv

openssl aes-256-cbc -K $encrypted_632cb16dd578_key -iv $encrypted_632cb16dd578_iv -in .ci/starforge-depot.key.enc -out .ci/starforge-depot.key -d
echo 'orval.galaxyproject.org ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArcGNXg3ytzMa4N1ML82KPmeR2Ft31Dc2ZoDgAo7YiCf/aeaCYxEDW+d/Iwt97hMXbo8wHpWcVIIwqLTZ9IXDHmgCZ65gbrEvj8SYCiaOZTZB2idKi4p2IyWCK6whyIxXOKXLuQI/izFZMdPcYqSz6fbC82o5yvo5Ql9ja0qYGfXF4jrkKD9gmLJlOS9HZXpZsidd5Tx43aioAh+Gb2btQ87cHOCdv8fGssJRkrskmG/gXhvKEpgExkEtUJavNBCj4rkzPGbz8GL54vpevsyG9lXvcdwkGC9AAC++6Van24klrze1MeguD3XB9xRGb2W6vdDUBSNtmWHKnl9QDjzvxw==' >> $HOME/.ssh/known_hosts
eval "$(ssh-agent -s)"
chmod 600 .ci/starforge-depot.key
ssh-add .ci/starforge-depot.key
ssh starforge@orval.galaxyproject.org mkdir -p /srv/nginx/depot.galaxyproject.org/root/starforge/travis/build-${TRAVIS_BUILD_NUMBER}
scp -p *.whl starforge@orval.galaxyproject.org:/srv/nginx/depot.galaxyproject.org/root/starforge/travis/build-${TRAVIS_BUILD_NUMBER}
