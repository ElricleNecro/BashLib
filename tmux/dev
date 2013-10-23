#Fonction créant un environnement de développement avec tmux et comprennant :
#	x) un panneau avec un vim de lancé
#	x) un panneau avec un htop
#	x) un panneau avec un bash

dev () {
	local DIRECTORY="$PWD"
	local NUM=1
	#"~/Documents/These/src"
	local HelpMSG="Usage :\n
\tdev [OPTION] NAME
\tNAME = Nom de la session à lancer.\n
Option :
\t-d --directory DIR : Répertoire où placer le terminal (défaut : $DIRECTORY).
\t-a                 : Attacher directement la session créé.
\t-n --number NUM    : Indice de début pour compter les fenètre et panel (défaut : $NUM).
\t-h --help          : Affiche cette aide.
\t-v --verbose       : Verbosité.
"

	local NAME
	local opt
	local opt_verbose=0
	local opt_attach=0

	OPTIND=0
	# Analyse des arguments de la ligne de commande
	while getopts ":d:hvan" opt ; do
		case $opt in
			d ) DIRECTORY=$OPTARG ;;
			n ) NUM=$OPTARG ;;
			h )	echo -e "$HelpMSG"
				return 0;;
			v ) opt_verbose=1 ;;
			a ) opt_attach=1 ;;
			- ) case $OPTARG in
				directory ) DIRECTORY=$OPTARG ;;
				number ) NUM=$OPTARG ;;
				verbose )	opt_verbose=1 ;;
				help )  echo -e "$HelpMSG"
					return 0 ;;
				* ) 	echo "option illégale --$OPTARG"
					return 1;;
			esac ;;
			? ) 	echo "option illégale -$OPTARG"
				return 1;;
		esac
	done
	shift $(($OPTIND - 1))
	NAME=$1

	if [[ "$NAME" = "" ]]
	then
		echo -e "\033[38;5;160mVous DEVEZ indiquer un nom de session\033[00m"
		return 1
	fi

	if [ $opt_verbose -ne 0 ]
	then
		echo "Creation of the new tmux session"
		echo tmux new-session -d -s "$NAME" -n 'Développement'
	fi

	tmux new-session -d -s "$NAME" -n 'Développement'

	#Envoi d'une commande à la fenétre de développement :
	CMD="cd $DIRECTORY"

	if [ $opt_verbose -ne 0 ]
	then
		echo "Will move to "$CMD
	fi

	if [ $opt_verbose -ne 0 ]
	then
		echo "Create differents panes"
		echo tmux send-keys -t "$NAME":$NUM "$CMD" C-m
		echo tmux split-window -v -t "$NAME":$NUM
		echo tmux select-pane  -t "$NAME":$NUM.0
		echo tmux split-window -h -t "$NAME":$NUM
		echo tmux resize-pane  -D -t "$NAME":$NUM.0 25
		echo tmux resize-pane  -R -t "$NAME":$NUM.0 80
	fi

	tmux send-keys -t "$NAME":$NUM "$CMD" C-m
	tmux split-window -v -t "$NAME":$NUM
	tmux select-pane  -t "$NAME":$NUM.0
	tmux split-window -h -t "$NAME":$NUM
	tmux resize-pane  -D -t "$NAME":$NUM.0 25
	tmux resize-pane  -R -t "$NAME":$NUM.0 80

	if [ $opt_verbose -ne 0 ]
	then
		echo "Send differents command for prepare environement"
		echo tmux send-keys -t "$NAME":$NUM.1 'top' C-m
		echo tmux send-keys -t "$NAME":$NUM.2 "$CMD" C-m
	fi

	#Envoi d'une série de commande aux nouveaux panneaux :
	tmux send-keys -t "$NAME":$NUM.1 'top' C-m
	tmux send-keys -t "$NAME":$NUM.2 "$CMD" C-m

	#Séléction du panneau avec vim comme panneau par défaut :
	if [ $opt_verbose -ne 0 ]
	then
		echo "Select default pane"
		echo tmux select-pane -t "$NAME":$NUM.0
	fi

	tmux select-pane -t "$NAME":$NUM.0

	if [ $opt_attach -ne 0 ]
	then
		tmux attach -t "$NAME"
	fi
}

# ViM modeline {{{1
# vim:foldmethod=marker:foldenable:foldlevel=0:ft=sh
