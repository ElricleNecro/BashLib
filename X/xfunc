#!/bin/bash

getWInfo() {
	xprop | awk '/^WM_CLASS/{sub(/.* =/, "instance:"); sub(/,/, "\nclass:"); print} /^WM_NAME/{sub(/.* =/, "title:"); print}'
}

getRInfo() {
	xprop -root -f WM_NAME "8u" | sed -n -r 's/WM_NAME\(STRING\) = \"(.*)\"/\1/p'
}

#vim:ft=sh
