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
