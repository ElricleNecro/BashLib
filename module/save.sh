load_module () {
	export MOD_TMP_DIR=/tmp/module
	mkdir -p $MOD_TMP_DIR

	source $1/load

	touch $MOD_TMP_DIR/`basename $1`
}

unload_module () {
	export MOD_TMP_DIR=/tmp/module/`basename $1`

	if [ ! -f "$MOD_TMP_DIR" ]
	then
		echo "Module not loaded!"
		return 1
	fi

	/usr/bin/rm $MOD_TMP_DIR
	source $1/restore

	/usr/bin/rm -rf $MOD_TMP_DIR
}

module () {
	local mod_basis=$HOME/Documents/src/Module

	case $1 in
		--help|-h ) ;;
		load )
			while [ -n "$2" ]
			do
				load_module $mod_basis/$2
				shift
			done
			;;
		unload )
			while [ -n "$2" ]
			do
				unload_module $mod_basis/$2
				shift
			done
			;;
		* )
			return 1
			;;
	esac

	return 0
}

# vim:ft=sh:spelllang=en
