# git-setup

A discombobulated potpourri of disparate stuff that's so b0rked and in flux that no proper readme is attempted.

In a nutshell, peel it off like an onion.

### Stuff:

* .gitconfig
* winmerge script
* .bashrc/.bash_profile scripts
* bin/ dir scripts
* git hooks
* git prompt script
* git template dir, git hooks dir
* scite scripts

##### .gitconfig

```bash
# Lookup an alias
$ git alias co$
$ git alias alias

# Multiline aliases are nicely printed
$ git alias conf

# List all aliases
$ git alias

# Find an alias for something with grep (does not work properly for multiline aliases)
$ git alias | grep log
```

```bash
# Lookup a config value
$ git conf rerere.enabled
```

```bash
# Log with two line pretty format
$ git l
# Pretty format two line is defined so can be used with log too
$ git log --pretty=two
# Pretty format one has addtional stuff compared to oneline
$ git log --pretty=one

# Last commit
$ git last
# Last 2 commits
$ git last -2
```

```bash
# Fuzzy checkout using a partial branch name (to checkout master)
$ git coe aste
```

```
# Use user.gitconfig for user name and email
# Use overrides.gitconfig for overriding with your own aliases
# Use alias-work.gitconfig for predefined work aliases
```

##### winmerge script

```bash
# winmerge.sh shows diff for added/removed files using a winmerge.empty file stub
$ git dt head~ head added-file.txt
$ git dt head~ head deleted-file.txt
```

##### .bashrc/.bash_profile scripts

```bash
# .gitconfig (global config)
$ gc
# local config
$ c
```

##### bin/ dir scripts

```bash
# To open a file in background (uses scite text editor)
$ o file.txt
$ s file.txt
```

```bash
# To wrap paths having spaces with double quotes for piping to text editor
$ git ls-files "*config" | wrap | xargs o
# To open grepped files
$ git grep "config" | cut -d':' -f1 | wrap | xargs o
```

```bash
# To open a dir in explorer
$ e bin/
$ e .git/hooks
```

```bash
# To list the dictators (uses .mailmap and shortlog)
$ git dictators
```

##### git hooks

```
# commit-msg hook to help with 50/72 commit convention
$ git commit
(user types commit message in editor)
hooks/commit-msg
  apply 50/72 commit message convention
  WARNING: subject should be upto 50 chars
  changing message
(user closes editor)
  no manual change
  now what? (*/u/a/f/o) ↵
  done
(commit succeeds)

(user closes editor)
  no manual change
  now what? (*/u/a/f/o) u
  undoing
(show editor with previous message)

(user closes editor)
  no manual change
  now what? (*/u/a/f/o) a
  aborting commit
(commit aborts)

(user closes editor)
  no manual change
  now what? (*/u/a/f/o) f
  forcing message
(show editor and any changes are used as is)

(user closes editor)
  no manual change
  now what? (*/u/a/f/o) o
  original message
(show editor with very 1st message and any changes are used as is)
```

##### git prompt script

```
# prompt format
<hh:mm:ss> <path> (<branch>) <user>@<host> MINGW64
# example
03:14:15 ~ (master) me@Machine MINGW64
```

##### git template dir, git hooks dir

```
# ~/.git-templates dir has template stuff that gets copied to .git/ dir (init.templateDir)
# ~/.git-hooks dir has commit hooks that apply to all repos (core.hooksPath)
```

##### scite scripts

```
SciTEStartup.lua
SciTEUser.properties
```
