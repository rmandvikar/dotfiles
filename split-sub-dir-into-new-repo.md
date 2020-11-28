## How to split a sub-dir into a new repo

Based from [github help link](https://help.github.com/en/articles/splitting-a-subfolder-out-into-a-new-repository).

1. Start from an existing repo.
2. Checkout a new branch with an empty commit.
```
    $ git checkout --orphan split-main
    $ git rm -rf .
    $ git commit --allow-empty -m "root commit"
```
3. Determine the branch (`main` in this case) and sub-dir to split, and split it.
```
    $ git filter-branch --force --prune-empty --subdirectory-filter sub/dir/1/to/split/ main
    $ git branch sub-dir1 main
```
4. The files from sub-dir are placed at the root path, so move files to correct path and/or delete unneeded ones.
```
    $ git checkout sub-dir1
    $ mv *.* new/dir/for/files/
    $ rm file/to/delete
    $ git add -A .
    $ git commit -m "Delete/Move files"
```
5. If there are multiple sub-dirs to split, split them.
```
    $ git branch -f main origin/main
    # Repeat steps 3-4.
```
6. Merge all sub-dir branches into `split-main`.
```
    $ git checkout split-main
    $ git merge --allow-unrelated-histories sub-dir1
    # repeat git merge for other sub-dirs
```
7. Commit dot files that should NOT show up in diff as `.gitignore`, `.gitignore`, `.mailmap`, etc.
8. Point `main` to HEAD.
```
    $ git branch -f main
    $ git checkout main
```
9. Change the remote url to point to the new repo. Create a new repo if one does not exist.
```
    $ git remote set-url origin <new-repo-url>
```
10. Force push `main`.
```
    $ git push -f origin main
```
11. Start making changes on a new branch.
