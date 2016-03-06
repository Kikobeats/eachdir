#!/usr/bin/env bash

function _eachdir() {

if [[ ! "$1" || "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP

  Run one or more commands in one or more dirs.

  Usage
   $ eachdir [dirs --] <commands>

  By default, all subdirs of the current dir will be iterated.

  Use '--' to separate a list of dirs from commands to be executed.

  Multiple commands must be specified as a single string argument.

  Example
    # Print the working directory
      $ eachdir pwd
      $ eachdir * -- pwd

    # Perform a 'git pull' inside for subdirs starting with 'repo-'
      $ eachdir repo-* -- git pull

    # Perform a few commands inside all subdirs starting with 'repo-'
      $ eachdir repo-* -- 'git fetch && git merge'
HELP
return; fi

# For underlining headers.
local h1
local h2
h1="$(tput smul)"
h2="$(tput rmul)"

# Store any dirs passed before -- in an array.
local dashes d
local dirs=()
for d in "$@"; do
  if [[ "$d" == "--" ]]; then
    dashes=1
    shift $(( ${#dirs[@]} + 1 ))
    break
  fi
  dirs=("${dirs[@]}" "$d")
done

# If -- wasn't specified, default to all subdirs of the current dir.
[[ "$dashes" ]] || dirs=(*/)

local nops=()
# Do stuff for each specified dir, in each dir. Non-dirs are ignored.
for d in "${dirs[@]}"; do
  # Skip non-dirs.
  [[ ! -d "$d" ]] && continue
  # If the dir isn't /, strip the trailing /.
  [[ "$d" != "/" ]] && d="${d%/}"
  # Execute the command, grabbing all stdout and stderr.
  output="$( (cd "$d"; eval "$@") 2>&1 )"
  if [[ "$output" ]]; then
    # If the command had output, display a header and that output.
    echo -e "${h1}${d}${h2}\n$output\n"
  else
    # Otherwise push it onto an array for later display.
    nops=("${nops[@]}" "$d")
  fi
done

# List any dirs that had no output.
if [[ ${#nops[@]} -gt 0 ]]; then
  echo "${h1}no output from${h2}"
  for d in "${nops[@]}"; do echo "$d"; done
fi
}

# By putting the above code inside a function, if this file is sourced (which
# is required for external aliases/functions to be used as commands), vars
# can be local and return can be used to exit.
_eachdir "$@"
