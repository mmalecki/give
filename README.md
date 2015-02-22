# give [![Build Status](https://secure.travis-ci.org/mmalecki/give.png)](http://travis-ci.org/mmalecki/give)

`give` ('git-versioned environment', name courtesy of [@AvianFlu](https://github.com/AvianFlu)) is a git-based node.js/io.js version manager.

It allows you to install anything git can checkout from either node's or io.js's
repos:

  * tags: `give install node v0.6.10`
  * commits: `give install iojs 3f43b1c039727e12c7a27fb31010aa309a4a35d8`
  * branches: `give install iojs master`

It's also very fast - instead of doing `git checkout` it uses `git archive`
which is very fast on local repositories.

## Installation

    npm install -g give


### Getting started

```
give install iojs v1.3.0 # will install version v1.3.0 of io.js
give use iojs v1.3.0     # will use version v1.3.0 of io.js (drops you into a subshell)
^D                       # will quit to original shell
```

## Usage

```
give - git-based node.js/io.js version manager

Usage:

  give install <what> <commit-ish>    Install <commit-ish> of <what>
    Examples:
      `give install node v0.6.10` - installs `v0.6.10` tag of node
      `give install iojs master`  - installs `master` branch of iojs
      `give install iojs 02c1cb5` - installs commit `02c1cb5` of iojs

  give use <what> <commit-ish>        Use <commit-ish> of <what>
    Spawns a subshell with correct version of node.js/io.js in the `$PATH`.

  give ls                             List installed node.js/io.js versions

  give rm <what> <commit-ish>         Remove <commit-ish>
    Removes both source and installation directory for <commit-ish> of <what>.

  give init                           Explicitely initialize repository
    Please note that `give` does it for you during operations which
    require repository setup.

  give help                           You're staring at it
```
