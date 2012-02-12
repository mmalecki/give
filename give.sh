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

function give_install {
  give_init
  if [ -d "$give_dir/src/$1" ]; then
    echo "Version $1 is already installed. Run \`give rm $1\` to remove it."
    return 1
  fi
  give_checkout $1

  cd "$give_dir/src/$1" && \
  ./configure --prefix="$give_dir/installed/$1" && \
  make &&
  make install
}

function give_ensure_installed {
  if [ ! -d "$give_dir/installed/$1" ]; then
    echo "Version $1 is not installed. Run \`give install $1\` to install it."
    exit
  fi
}

function give_use {
  give_ensure_installed $1
  PATH=$give_dir/installed/$1/bin:$PATH "$SHELL"
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
  "use")
    give_use $2
  ;;
  "install")
    give_install $2
  ;;
esac
