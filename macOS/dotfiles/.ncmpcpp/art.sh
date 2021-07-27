#!/bin/bash

let width=$(tput cols)/5

album="$(mpc --format %album% current)"
artist="$(mpc --format %artist% current)"
query="$artist $album album cover"

wget --user-agent 'Mozilla/5.0' -O cover.html -q "www.google.be/search?q=${query}\&tbm=isch"
curl -s -o cover.jpg "$(sed -e 's/</\'$'\n</g' cover.html | grep "src" | head -n 2 | tail -1 | sed 's/.*="//' | sed 's/".*//')"

echo ""; echo ""; echo ""

imgcat --width $width cover.jpg
rm cover.html cover.jpg

