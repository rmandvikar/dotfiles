# dotfiles

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
# Fuzzy checkout using a partial branch name (to checkout main)
$ git echeckout ain
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

###### global and local .gitconfigs

```bash
# .gitconfig (global config)
$ gc
# local config
$ lc
```

###### .gitconfig per $OSTYPE

It's not possible to set variables in gitconfig conditionally as bashrc. So a script `'setup'` is used for wiring. `'.gitconfig'` has a include.path for file `'ostype.gitconfig'` which is gitignored. gitconfig settings per OS are in below files which are committed. The script `'setup'` generates file `'ostype.gitconfig'` with a include.path for the corresponding file per `'$OSTYPE'`. `'setup'` is called from `'.bash_profile'` and can also be run on-demand.

```bash
# gitconfig files per OS
.gitconfig.linux.gitconfig
.gitconfig.windows.gitconfig
.gitconfig.mac.gitconfig
```

```bash
# Run setup to wire the correct gitconfig per ostype
$ setup
```

##### winmerge script

```bash
# winmerge.sh shows diff for added/removed files using a winmerge.empty dummy file
$ git dt head~ head added-file.txt
$ git dt head~ head deleted-file.txt
```

##### .bashrc/.bash_profile scripts

###### .bashrc files per $OSTYPE

```bash
# .bashrc sources OS specific .bashrc files
.bashrc.linux.bashrc
.bashrc.windows.bashrc
.bashrc.mac.bashrc
# .bashrc also sources local and work .bashrc files which are gitignored for adhoc commands
.bashrc.work.bashrc
.bashrc.local.bashrc
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

# To open a file's dir with file focused in explorer
$ e .git/hooks/readme.txt
$ e "new folder/readme.txt"

# To open special paths
$ e ~
$ e .
$ e ..

# To open mount paths
$ e /
$ e /bin
$ which git | e
$ which which | e
$ which e | e
$ e /tmp

# To open mount drives
$ e /d
$ e /c/
$ e /d:/
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

```bash
# To open file using the default application (xdg-open, start, open)
$ app <file>
```

```bash
# Stash changes but keep in working directory
$ git bak [<message>]
```

```bash
# Browse branch's log
$ remote -l    dev
$ remote --log dev

# Browse commit
$ remote -c       19ff585
$ remote --commit 19ff585

# Browse branch's tree
$ remote -t     dev
$ remote --tree dev

# Browse diff of two commits
$ remote -d     fc378ce 19ff585
$ remote --diff fc378ce 19ff585

# Browse pr
$ remote --pr 42
```

```bash
# Diff commit patches (to verify if two commits are cherrypicks)
$ pdiff main dev

# Diff commit range patches (to verify rebase with conflicts is good)
$ pdiff dev'..pdiff' dev..pdiff
```

```bash
# Check if branch exists
$ git branch-exists dev && echo "branch exists"
```

```bash
# Add to .git/info/exclude file
$ git exclude "a/b/c"
$ git exclude --edit
```

```bash
# Create jwt (uses jwtRS256.key, jwtRS256.cer, jwt.header, jwt.payload)
$ jwt
# Decode jwt (uses jwtRS256.key.pub)
$ echo "<jwt>" | jwtd
```

```bash
# Clip
$ jwt | c
# Paste
$ v | jwtd
# Both, clip and paste
$ jwt | cv | jwtd
```

##### git hooks

Each hook is comprised of sub-hooks that are placed in the '`~/.git-hooks/<hook>.d/`' dir and '`.git/hooks/<hook>.d/`' dir. This allows to
- arbitrarily call any function in a desired order.
- call proprietary or work hooks without committing.

The sub-hooks are called in the sorted order of 'sort -n' command of filenames after ignoring files with extensions. Sub-hooks with '(gitignore)' in their names are git-ignored.

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
# use 'SKIP_HOOKS' or 'skip_hooks' environment variable to skip hooks
# set to true or 1 to skip hooks
$ SKIP_HOOKS=true git commit
$ skip_hooks=1 git commit
```

##### git prompt script

```
# prompt format
<hh:mm:ss> <path> (<branch>) [<branchStatus>] <hash> <user>@<host> MINGW64
# example with remote branch status
03:14:15 ~ (main) - 8a338cc me@Machine MINGW64
03:14:15 ~ (main) -0,+1 4ea746e me@Machine MINGW64
# example with no remote branch status
03:14:15 ~ (prompt)  8a338cc me@Machine MINGW64
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

##### AutoHotkey script

```
AutoHotkey.ahk
```
