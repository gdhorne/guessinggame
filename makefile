build:
	rm -f README.md
	echo "## Guessing Game" > README.md
	echo >> README.md
	echo -n "**Execution Time:** " >> README.md
	date >> README.md
	echo -n "**Lines of Code:** " >> README.md
	awk '!/^\#/ && NF { count++; } END { print(count); }' guessinggame.sh >> README.md
	echo >> README.md
