# git-setup

A discombobulated potpourri of disparate esoteric stuff that's so b0rked and in flux that no proper readme is attempted.

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

###### .gitconfig include.path files

```
# Use user.gitconfig for user name and email
#  example:
    [user]
        name    = <name>
        email   = <i@email>
```

```
# Use overrides.gitconfig for overriding with your own aliases
#  example:
    [alias]
        l = log --decorate --abbrev-commit
```

```
# Use alias-work.gitconfig for predefined work aliases
#  example:
    [alias]
        ci = commit
        st = status
```

```
# Note that aliases in alias-work.gitconfig 
#   are overridden by .gitconfig
#   which are overridden by overrides.gitconfig
```

##### winmerge script

```bash
# winmerge.sh shows diff for added/removed files using a winmerge.empty dummy file
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
$ git ls-files "*config" | dq | o
# To open grepped files
$ git grep "config" | cut -d':' -f1 | dq | o
```

```bash
# To open grepped files with custom cut alias, cutg
$ git grep "config" | cutg | dq | o
# To cut status with custom cut alias, cuts
$ git diff --name-status | cuts | dq | o
```

```bash
# To get dirname or basename
$ echo "a/b/c" | dn
$ echo "a/b/c" | bn
```

```bash
# To open a dir in explorer
$ e bin/
$ e .git/hooks
$ e "new folder"
```

```bash
# To list the dictators (uses .mailmap and shortlog)
$ git dictators
```

```bash
# To find the merge commit when a given commit was merged into a branch
$ git find-merge <commit>
$ git find-merge <commit> [<branch>]
```

```bash
# To find the tag when a given commit was merged into a branch
$ git find-tag <commit>
$ git find-tag <commit> [<branch>]
```

```bash
# To purge merged branches except certain ones
$ git purge-branches [-n | --dry-run]
```

##### git hooks

Each hook is comprised of sub-hooks that are placed in the '\<hook>.d' dir at ~/.git-hooks/ path. This allows to
- arbitrarily call any function in a desired order.
- call proprietary or work hooks without committing.

The sub-hooks in '\<hook>.d' dir are called in the sorted order of 'ls' command after ignoring files with extensions (ls -I '*.*' -1 "\<hook>.d"). Sub-hooks with '(gitignore)' in their names are git-ignored.

###### apply-commit-message-convention sub-hook

```
# help with 50/72 commit message convention
$ git commit
(user types commit message in editor)
hooks/commit-msg
  apply 50/72 commit message convention
  WARNING: subject should be upto 50 chars
  changing message
(user closes editor)
  no manual change
  now what? (*/undo/abort/force/original) ↵
  done
(commit succeeds)

(user closes editor)
  no manual change
  now what? (*/undo/abort/force/original) u↵
  undoing
(show editor with previous message)

(user closes editor)
  no manual change
  now what? (*/undo/abort/force/original) a↵
  aborting commit
(commit aborts)

(user closes editor)
  no manual change
  now what? (*/undo/abort/force/original) f↵
  forcing message
(show editor and any changes are used as is)

(user closes editor)
  no manual change
  now what? (*/undo/abort/force/original) o↵
  original message
(show editor with very 1st message and any changes are used as is)
```

```
# add gerrit Change-Id sub-hook
```

###### skip/apply functions of hook

As the hooks are run globally from ~/.git-hooks/ dir, configuration variables are used as flags to skip/apply functions (sub-hooks).

```
# use 'hook.skip-cmc' configuration variable to skip commit message convention (cmc)
$ git config hook.skip-cmc true
# use 'hook.changeid' configuration variable to apply gerrit Change-Id
$ git config hook.changeid true
```

###### skip hooks

```
# use 'SKIP_HOOKS' environment variable to skip hooks
$ SKIP_HOOKS=true git commit
```

##### git prompt script

```
# prompt format
<hh:mm:ss> <path> (<branch>) <hash> <user>@<host> MINGW64
# example
03:14:15 ~ (master) 8a338cc me@Machine MINGW64
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
