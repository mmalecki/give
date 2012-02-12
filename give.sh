#!/bin/sh

if [ -z "$give_dir" ]; then
  give_dir=~/.give
fi

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
  give_update

  give_checkout $1

  cd "$give_dir/src/$1" && \
  ./configure --prefix="$give_dir/installed/$1" && \
  make &&
  make install
}

function give_rm {
  give_ensure_installed $1
  rm -rf $give_dir/{installed,src}/$1
}

function give_ls {
  ls "$give_dir/installed"
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
  echo
  echo "  give install <commit-ish>        Install <commit-ish>"
  echo "    Examples:"
  echo "      \`give install v0.6.10\` - installs \`v0.6.10\` tag"
  echo "      \`give install master\`  - installs \`master\` branch"
  echo "      \`give install 02c1cb5\` - installs commit \`02c1cb5\`"
  echo
  echo "  give use <commit-ish>            Use <commit-ish>"
  echo "    This command will spawn a subshell with correct version of node.js"
  echo "    in the \`\$PATH\`."
  echo
  echo "  give ls                          List installed node.js versions"
  echo "  give rm <commit-ish>             Remove <commit-ish>"
  echo "  give init                        Explicitely initialize repository"
  echo "    Please note that \`give\` does it for you during operations which"
  echo "    require repository setup"
  echo
  echo "  give help                        You're staring at it"
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
    give_rm $2
  ;;
  "ls")
    give_ls
  ;;
  "use")
    give_use $2
  ;;
  "init")
    give_init
  ;;
  "install")
    give_install $2
  ;;
esac
