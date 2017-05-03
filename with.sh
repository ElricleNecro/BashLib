#!/bin/bash

# We need the shell to stop the evaluation when a command fail, so that the with
# block can be close, and the execution stopped.
set -e

#! Mark the end of line to use in the stack.
EOL="
"

#! This variable will act as a stack for call to do on exiting a with code.
stack=""

#! Start the with block by calling the opening command and add a `un$*` to the
#! stack, to call at the end of the with.
#! @param * Command to call to open the with block.
start_with() {
	cmd="$*"
	$cmd
	stack+="${EOL}un$cmd"
}

#! End the with block by executing the closing command, using `un$*`, where $*
#! correspond to the parameters given to the start with function.
end_with() {
	undo="$(echo "$stack" | tail -n 1)"
	$undo
	stack="$(echo "$stack" | head -n -1)"
}

#! This function will be caught in case of an exception/error, to ensure all the
#! environnement is correctly closed.
on_exit() {
	while [[ "$stack" != "" ]]
	do
		end_with
	done
}
trap on_exit EXIT

#! This function is used into an alias on a while to create and control the with
#¡ block, ensuring, thanks to the alias, that the environnement is correctly
#! closed.
#! @param * Command to open the with block. The closing command has to be `un$*`
loop_control() {
	if [[ $loop_entry = 1 ]]
	then
		start_with $*
		loop_entry=0
		return 0
	else
		end_with
		return 1
	fi
}
shopt -s expand_aliases
alias with='loop_entry=1; while loop_control'
