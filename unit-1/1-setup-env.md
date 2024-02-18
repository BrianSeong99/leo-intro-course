# 1 Setup Environment

## Install Git and Rust

- Install [Git](https://git-scm.com/downloads)
- Install [Rust](https://www.rust-lang.org/tools/install)

Note: After installation, if your `git` and `rustc` command doesn't work, try to close the current terminal window, open a new one, and try again.

## [screenshot required] Install leo

Clone the `leo` repository

```bash
# Download the source code
git clone https://github.com/AleoHQ/leo
cd leo
```

Build and install `leo` CLI

```bash
# Build and install
cargo install --path .
```

For more details about how to use `leo` Cli, check out [here](https://developer.aleo.org/leo/commands)

## [screenshot required] Install snarkOS

Clone the `snarkOS` repository

```bash
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
cd snarkOS
```

[For Ubuntu users] A helper script to install dependencies is available. From the snarkOS directory, run:

```bash
./build_ubuntu.sh
```

Lastly, install snarkOS:

```
cargo install --path .
```

Please ensure ports 4133/tcp and 3033/tcp are open on your router and OS firewall.

For more details about how to use `snarkOS` Cli, check out [here](https://developer.aleo.org/testnet/getting_started/installation/#22-installation).

## Install `leo` IDE Syntax Highlighting:

Check out Guide [Here](https://developer.aleo.org/leo/installation#3-ide-syntax-highlighting)

## Docker pull leo

This is the development environment docker of aleo blockchain with leo, rust, and git installed.

pull docker image

```
docker pull 0xaragondocker/leo_docker:latest
```

run docker

```
docker run -it 0xaragondocker/leo_docker /bin/bash
```
