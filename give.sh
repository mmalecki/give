#!/bin/sh

give_dir=~/.give

function give_init {
  if [ ! -d "$give_dir" ]; then
    mkdir -p "$give_dir"
    git clone https://github.com/joyent/node.git "$give_dir/src/node"
  fi
}

function give_update {
  cd "$give_dir/src/node" && git pull
}

function give_checkout {
  cd "$give_dir/src" && git archive --prefix "$1/" --remote node "$1" | tar -xf -
}

function give_help {
  echo
  echo "give - git-based node.js version manager"
  echo
  echo "Usage:"
  echo "  give help        You're staring at it"
  echo
}

if [ $# -lt 1 ]; then
  give_help
  exit
fi

case $1 in
  "help")
    give_help
  ;;
esac
