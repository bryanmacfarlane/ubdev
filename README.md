<p align="center">
  <img src="res/ubuntu.png">
</p>

# Ubuntu Dev

A quick and convenient Ubuntu dev environment to hack stuff out from my Mac.

## Usage

### Build

Do this once:
```bash
$ ./ub build
```

### Start

Start will start the container and put you into the container interactively

```bash
$ ./ub start
/usr/local/bin/docker
mapping /Users/bryan/Projects/ubdev/..:/projects
root@ubdev:/projects#
```

By default, it will map the directory about this repos directory and map into a container path of `/projects`.  I clone this into my projects folder and run it.

The script accepts an argument to specify which path to map in:
```bash
$ ./ub start ~/Study
/usr/local/bin/docker
mapping /Users/bryan/Study:/projects
root@ubdev:/projects# 
```
