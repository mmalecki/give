# give [![Build Status](https://secure.travis-ci.org/mmalecki/give.png)](http://travis-ci.org/mmalecki/give)

`give` ('git-versioned environment', name courtesy of [@AvianFlu](https://github.com/AvianFlu)) is a git-based node.js version manager.

It allows you to install anything git can checkout:

  * tags: `give install v0.6.10`
  * commits: `give install 3f43b1c039727e12c7a27fb31010aa309a4a35d8`
  * branches: `give install master`

It's also very fast - instead of doing `git checkout` it uses `git archive`
which is very fast on local repositories.

## Installation

    npm install -g give

## Usage

```
give - git-based node.js version manager

Usage:

  give install <commit-ish>        Install <commit-ish>
    Examples:
      `give install v0.6.10` - installs `v0.6.10` tag
      `give install master`  - installs `master` branch
      `give install 02c1cb5` - installs commit `02c1cb5`

  give use <commit-ish>            Use <commit-ish>
    Spawns a subshell with correct version of node.js in the `$PATH`.

  give ls                          List installed node.js versions

  give rm <commit-ish>             Remove <commit-ish>
    Removes both source and installation directory for <commit-ish>.

  give init                        Explicitely initialize repository
    Please note that `give` does it for you during operations which
    require repository setup.

  give help                        You're staring at it
```

### Getting started

```
give install v0.6.10 # will install version tagged as v0.6.10
give use v0.6.10     # will use version tagged as v0.6.10
^D                   # will quit to original shell
```
