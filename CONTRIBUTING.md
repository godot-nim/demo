Thank you for choosing gdext-nim as your project partner.
This repository is looking for gdext-nim projects that actually work.

You can contribute to this repo in two ways.
It is assumed that you know basic git operations. See [Git - Book][1] and [GitHub Docs - Creating a pull request from a fork][2] for more information.

## Add a link to your project in godot-nim/demo/README

Add your project to demo/README; when gdext-nim is updated, you will receive a report about deprecated or replaced features. This is recommended if you update your project frequently, if your project is large, or if you want to protect your work.

### Initial work

1. Fork https://github.com/godot-nim/demo and clone it.
1. Add to the `Projects using gdext-nim` section of the cloned/README, create a commit, and push it.
1. Visit godot-nim/demo, you should see a popup to create a pull request. Create a PR as you go.

## Maintenance for updates to gdext-nim and Godot Engine

Please update the version info in demo/README when you migrate to the latest version.
Star godot-nim/gdext-nim to receive notification when a new version is released. If you wish, we can send reports on deprecated or replaced features to Issues in your project; just mention it in your PR.

### Maintenance for your project updates

Nothing.

## Adding your project to godot-nim/demo

Copy your project to godot-nim/demo using `git subtree`. Use a license that allows the godot-nim team to modify and distribute the source code.
You can leave the maintenance work such as migration to the development team when gdext-nim is updated. When you update your project, you should also work on demo repo.
This is recommended if you do not update your project very often.

### Initial work

1. Create CREDITS or LICENSE to let people know who the project belongs.
1. Fork https://github.com/godot-nim/demo and clone it.
1. Execute the following command in the cloned repository.
   ```console
   git remote add <remote> <git-url>
   git subtree add --prefix=<project> <remote>/<branch> --squash
   ```
   For example, if you host the `mine` project on https://github.com/me/mine, you would do the following.
   ```console
   git remote add mine https://github.com/me/mine.git
   git subtree add --prefix=mine mine/main --squash
   ````
1. If you are using git submodules, you need to move .gitmodules to the root.
   ```diff
   # mine/.gitmodules
   - [submodule “depends”]
   - path = depends
   - url = https://github.com/external/depends.git
   ```
   ```diff
   # /.gitmodules
   + [submodule “mine/depends”]
   + path = mine/depends
   + url = https://github.com/external/depends.git
   ```
1. Commit and push your changes.
1. Visit godot-nim/demo, you should see a popup to create a pull request. Create a PR as you go.

## Maintenance for updates to gdext-nim and Godot Engine

No need, the godot-nim development team will do it for you.

### Maintenance for your project updates

Run the following command against the forked repository to resolve conflicts and submit a PR.

```console
git subtree pull --prefix=mine --squash mine main
```

[1]: https://git-scm.com/book/en/v2
[2]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork