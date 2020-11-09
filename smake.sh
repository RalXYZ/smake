argv_1=$1
argv_2=$2
argv_3=$3
argc=$#
echo $argc

case "$argv_1" in
    init)
        echo "smake: make sure you have already set this shell script as executable."
        which smake
        if [ $? -ne 0 ]  # FIXME: something went wrong, can't go to "else" branch
        then
            echo "smake: paste the following line into your shell configuration file."
            echo "alias smake='sh `pwd`/$0'"
            exit 10
        else
            echo "smake: smake has been correctly configured."
            exit 0
        fi
		;;


	compile)
		gcc -c *.c
		if [ $? -ne 0 ]
		then
			echo "smake: smake didn't sucessfully compile because some errors arose wile compiling."
			exit 1
		fi

		gcc *.o
		if [ $? -ne 0 ]
		then
			echo "smake: smake didn't sucessfully compile because some errors arose while linking."
			exit 1
		fi

		exit 0
		;;


	# smake install DESTINATION INSTALLFILELIST
	install)
		if [ $argc -lt 3 ]
		then
			echo "smake: Invalid amount of operand."
			exit 1
		fi

		if [ ! -d $argv_2 ]
		then
			echo "smake: Please use a valid destination!"
			exit 0
		fi

		install_not_vaild=0
		install_argv_iterator=0
		for argv in $*
		do
			install_argv_iterator=$(($install_argv_iterator + 1))
			if [ $install_argv_iterator -gt 2 ] && [ ! -f $install_argv_iterator ]
			then
				install_not_vaild=$(($install_not_vaild + 1))
				echo "smake: $argv: This Installfile doesn't exist!"
			fi
		done
		if [ $install_not_vaild -gt 0 ]
		then
			exit $install_not_vaild
		fi

		install_argv_iterator=0
		for argv in $*
		do
			install_argv_iterator=$(($install_argv_iterator + 1))
			if [ $install_argv_iterator -gt 2 ]
			then
				install $argv $argv_2
			fi
		done

		exit 0
		;;
		

	clean)
		echo "Do you want to remove the binary file? (y/N)\c"
		read clean_yes_or_no
		case "$clean_yes_or_no" in
			"y" | "Y")
				rm *.o    # TODO: make this branch correct
			"n" | "N" | "")
				exit 0;;
			*)
				echo "Please answer y/N!";;
		esac
		;;


	*)
		echo "smake usage:"
		echo "smake compile"
		echo "smake install DESTINATION INSTALLFILELIST"
		echo "smake clean"
		if [ "$argv_1" = help ]
		then
            echo "smake help"
			exit 0
		else
			exit 127
		fi
		;;


esac
