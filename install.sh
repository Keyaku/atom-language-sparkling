#!/bin/bash

DIR_package="$(cd $(dirname "$0"); pwd)"
packageName="$(basename $DIR_package)"

cd "$HOME/.atom/packages"
if [ $? -eq 0 ]; then
	if [ -z "$(ls | grep -E $packageName)" ]; then
		ln -s $DIR_package
	else
		printf "This package is already installed.\nOverwrite it? (yes/no)\n> "
		while [ -z $(echo $answer | grep -E "yes"\|"no") ]; do
			read
			answer="$(echo $REPLY | tr '[:upper:]' '[:lower:]')"
			if [ -z $(echo $answer | grep -E "yes"\|"no") ]; then
				printf "Please answer with \"yes\" or \"no.\n> "
			fi
		done
		if [ "$answer" == "yes" ]; then
			rm -rf "$packageName";	RET=$?
			ln -s "$DIR_package";	RET=$(expr $RET + $?)
			if [ $RET -eq 0 ]; then
				printf "Overwritten.\n"
			else
				printf "Something went wrong. Could not overwrite.\n"
			fi
		else
			printf "Chosen not to overwrite.\n"
		fi
	fi
else
	printf "Atom directory not found. Are you sure you have Atom installed?\n"
fi
