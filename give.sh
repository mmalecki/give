#!/usr/bin/env sh

if [ -z "$give_dir" ]; then
  give_dir=~/.give
fi

give_init () {
  if [ ! -d "$give_dir" ]; then
    mkdir -p "$give_dir"
    git clone https://github.com/joyent/node.git "$give_dir/src/node"
    git clone https://github.com/iojs/iojs.git "$give_dir/src/iojs"
  fi
}

give_update () {
  cd "$give_dir/src/$1" && git pull
}

give_checkout () {
  cd "$give_dir/src" && git archive --prefix "$1-$2/" --remote $1 "$2" | tar -xf -
}

give_install () {
  give_init
  give_update $1

  give_checkout $1 $2

  cd "$give_dir/src/$1-$2" && \
  ./configure --prefix="$give_dir/installed/$1-$2" && \
  make $MAKEFLAGS && \
  make $MAKEFLAGS install
}

give_rm () {
  give_ensure_installed $1 $2
  rm -rf $give_dir/{installed,src}/$1-$2
}

give_ls () {
  ls "$give_dir/installed"
}

give_ensure_installed () {
  if [ ! -d "$give_dir/installed/$1-$2" ]; then
    echo "$1 $2 is not installed. Run \`give install $1 $2\` to install it."
    exit
  fi
}

give_use () {
  give_ensure_installed $1 $2
  PATH=$give_dir/installed/$1-$2/bin:$PATH "$SHELL"
}

give_help () {
  echo
  echo "give - git-based node.js/io.js version manager"
  echo
  echo "Usage:"
  echo
  echo "  give install <what> <commit-ish>    Install <commit-ish> of <what>"
  echo "    Examples:"
  echo "      \`give install node v0.6.10\` - installs \`v0.6.10\` tag of node"
  echo "      \`give install iojs master\`  - installs \`master\` branch of iojs"
  echo "      \`give install iojs 02c1cb5\` - installs commit \`02c1cb5\` of iojs"
  echo
  echo "  give use <what> <commit-ish>        Use <commit-ish> of <what>"
  echo "    Spawns a subshell with correct version of node.js/io.js in the \`\$PATH\`."
  echo
  echo "  give ls                             List installed node.js/io.js versions"
  echo
  echo "  give rm <what> <commit-ish>         Remove <commit-ish>"
  echo "    Removes both source and installation directory for <commit-ish> of <what>."
  echo
  echo "  give init                           Explicitely initialize repository"
  echo "    Please note that \`give\` does it for you during operations which"
  echo "    require repository setup."
  echo
  echo "  give help                           You're staring at it"
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
  "rm")
    give_rm $2 $3
  ;;
  "ls")
    give_ls
  ;;
  "use")
    give_use $2 $3
  ;;
  "init")
    give_init
  ;;
  "install")
    give_install $2 $3
  ;;
esac
