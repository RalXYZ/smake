argv_1=$1
argv_2=$2
argv_3=$3
argc=$#

case "$argv_1" in
	# smake init
    "init")
		if [ $argc -eq 1 ]
		then
			echo "smake: make sure you have already set this shell script as executable."
			which smake
			if [ $? -ne 0 ]  # FIXME: something went wrong, can't go to "else" branch
			then
				echo "smake: paste the following line into your shell configuration file."
				echo "alias smake='sh `pwd`/$0'"
				exit 1
			else
				echo "smake: smake has been correctly configured."
				exit 0
			fi
		fi
		;;


	# smake compile
	"compile")
		if [ $argc -eq 1 ]
		then
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
		fi
		;;


	# smake install DESTINATION INSTALLFILELIST
	"install")
		if [ $argc -gt 2 ]
		then

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
					echo "smake: '$argv' doesn't exist!"
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
		fi
		;;


	# smake clean
	"clean")
		if [ $argc -eq 1 ]
		then
			`ls *.o > /dev/null`
			if [ $? -ne 0 ]
			then
				echo "smake: No file needs to be cleaned."
			else 
				for clean_file in `ls *.o`
				do
					rm $clean_file
					echo "smake: '$clean_file' has been removed successfully."
				done
			fi

			echo "smake: The list below is a list of current directory."
			ls -lh
			echo "smake: Do you want to remove any binary file? (y/N)\c"
			read clean_file_selection
			case "$clean_file_selection" in
				"y" | "Y")
					echo "smake: Enter the name of your binary file(s):\c"
					read clean_file_list
					clean_succeeded=0
					clean_failed=0
					for clean_file in $clean_file_list
					do
						rm $clean_file
						if [ $? -eq 0 ]
						then
							clean_succeeded=$(($clean_succeeded + 1))
							echo "smake: '$clean_file' has been removed successfully."
						else
							clean_failed=$(($clean_failed + 1))
						fi
					done
					echo "smake: Operation done. $clean_succeeded succeeded, $clean_failed failed."
					exit 0
					;;
				"n" | "N" | "")
					exit 0
					;;
				*)
					echo "smake: Please answer y/N!"
					exit 1
					;;
			esac
		fi
		;;


	*)
		if [ $argc -eq 0 ]
		then
			echo "smake: Needs command."
		else
			echo "smake: Invalid command: $argv_1"
		fi
esac


echo "smake usage:"
		echo "smake init"
		echo "smake compile"
		echo "smake install DESTINATION INSTALLFILELIST"
		echo "smake clean"
		echo "smake help"
		if [ "$argv_1" = help ] && [ $argc -eq 1 ]
		then
			exit 0
		else
			exit 127
		fi
