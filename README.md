# give [![Build Status](https://secure.travis-ci.org/mmalecki/give.png)](http://travis-ci.org/mmalecki/give)

`give` ('git-versioned environment', name courtesy of [@AvianFlu](https://github.com/AvianFlu)) is a git-based node.js version manager.

## Installation

    npm install give

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
