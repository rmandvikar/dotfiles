## How to split a sub-dir into a new repo

Based from [github help link](https://help.github.com/en/articles/splitting-a-subfolder-out-into-a-new-repository).

1. Start from an existing repo.
2. Checkout a new branch with an empty commit.
```
    $ git checkout --orphan split-master
    $ git rm -rf .
    $ git commit --allow-empty -m "root commit"
```
3. Determine the branch and sub-dir to split, and split it.
   NOTE: sub/dir/to/split refers to the repo location, not local file.  Use / not \
```
    $ git filter-branch --force --prune-empty --subdirectory-filter sub/dir/to/split master
    $ git branch sub-dir1 master
```
4. The files from sub-dir are placed at the root path, so move files to correct path and/or delete unneeded ones.
   NOTE: new/dir/for/files is within this repo, not in a new space
   NOTE: If you are repeating this step to pull files from another location, change the sub-dir1.
```
    $ git checkout sub-dir1
    $ mv *.* new/dir/for/files/
    $ rm file/to/delete
    $ git add -A .
    $ git commit -m "Delete/Move files"
```
5. If there are multiple sub-dirs to split, split them.
```
    $ git branch -f master origin/master
    # Repeat steps 3-4.
```
6. Merge all sub-dir branches into `split-master`.
```
    $ git checkout split-master
    $ git merge --allow-unrelated-histories sub-dir1
    # repeat git merge for other sub-dirs
```
7. Commit dot files that should NOT show up in diff as `.gitignore`, `.gitignore`, `.mailmap`, etc.
8. Point `master` to HEAD.
```
    $ git branch -f master
    $ git checkout master
```
9. Change the remote url to point to the new repo. Create a new repo if one does not exist.
```
    $ git remote set-url origin <new-repo-url>
```
10. Force push `master`.
```
    $ git push -f origin master
```
11. Start making changes on a new branch.
