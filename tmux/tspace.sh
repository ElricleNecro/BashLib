#!/bin/bash

# this is for setting up a session in tmux
tspace () {
	tmux set default-path $(pwd)
	tmux rename-session $(basename $(pwd))
}

#vim: ft=sh:spelllang=