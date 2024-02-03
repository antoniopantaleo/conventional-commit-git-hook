<p align="center">
  <img width="20%" src="https://github.com/antoniopantaleo/conventional-commit-hook/assets/46167308/05f9e0e1-23ae-42a6-9f5a-cfb58674f716"/>
</p>

# Conventional Commit Git Hook

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
![](https://img.shields.io/badge/swift-5.8-orange?logo=swift&logoColor=white&style=flat-square)
![](https://img.shields.io/badge/MacOS-13+-white?logo=apple&logoColor=white&style=flat-square)
![](https://img.shields.io/github/license/antoniopantaleo/conventional-commit-git-hook?style=flat-square&color=red)
[![](https://img.shields.io/github/actions/workflow/status/antoniopantaleo/conventional-commit-git-hook/test.yml?branch=master&label=test&style=flat-square&logo=github)](https://github.com/antoniopantaleo/conventional-commit-git-hook/actions/workflows/test.yml)
![](https://img.shields.io/codecov/c/github/antoniopantaleo/conventional-commit-git-hook?style=flat-square&logo=codecov&logoColor=white)

This Swift Package allows you to equip your projects with a git hook that enforces the
[conventional commits](https://www.conventionalcommits.org) format. 
Conventional commits encourage consistent and structured commit messages,
making it easier to understand the history of your codebase.

## How it works

Each commit has to be structured with a type, an optional scope, a message, an optional body and optional footers.

Some examples:

```
fix(login)!: resolve issue with incorrect validation

This is related to ticket #12345

An update to the login library was made
```

```
docs(readme): update installation guide
```

```
chore: pod update
```

More [examples](https://www.conventionalcommits.org/en/v1.0.0/#examples)


This version just checks the header message of a commit. Further releases may consider footers 
too in order to respect [git trailer convention](https://git-scm.com/docs/git-interpret-trailers).

## Installation

### Manual

Copy or move the `commit-msg` hook binary file to your project's `.git/hooks/` folder.
The hook will automatically be executed on every commit, whether made in terminal sessions or GUI clients.

### curl

You can install the hook in your directory without cloning the repo just using `curl`. 
To do so, run the following command inside your repository directory:

```bash
curl /path/to/your/project/.build/release/commit-msg -o /path/to/your/project/.git/hooks/commit-msg
```

## Build your own

You can build the Package and generate a new hook just by running

```
swift build -c release
```

a brand new `commit-msg` binary file will be written inside `./build/release` folder

## Override hook execution

You can override and skip the hook execution using the [`--no-verify`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---no-verify) git commit option
