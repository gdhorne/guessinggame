#!/usr/bin/env sh

# A game in which the player has to correctly guess the number of regular
# files in the current directory.
#
# Rules:
#
# If the player guesses too low or too high , a message is displayed and
# the game continues.
#
# If the player guesses the correct number of files, a message is displayed
# and the game ends.

# Determine number of regular files in the current directory.
# Parameter $1 is the directory path.

file_count() {
  find ${1} -maxdepth 1 -type f -a ! -iname '\''.*'\'' -print0 | xargs -0r ls' | wc -l
}

# Check if the most recent guess is correct (equal) or incorrect
# (too low or too high) to the actual file count. Non-numeric values
# are not supported.
# Parameter $1 is the player's guess.
# Parameter $2 is the number of files in the directory.

check_guess() {
  if [ $1 -eq $2 ]
  then
    echo 0
  elif [ $1 -lt $2 ]
  then
    echo -1
  else
    echo 1
  fi
}


################################################################################
# Keep prompting the player to enter a guess until the correct number          #
# is entered. Based on the rules of play display an appropriate message.       #
################################################################################

n=$(file_count ${PWD})

MATCH=0
while [ $MATCH -eq 0 ]
do
  echo
  echo -n "How many files in the current directory?  "
  read guess
  result=$(check_guess $guess $n)
  if [ $result -eq 0 ]
  then
    echo "Congratulations!"
    MATCH=1
  elif [ $result -lt 0 ]
  then
    echo "Your guess is too low"
  else
    echo "Your guess is too high"
  fi
done

echo

exit 0
