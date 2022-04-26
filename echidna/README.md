# Setup

## Install Dependencies
```
$ python3 -m pip install -r ./requirements.txt
```

## Verify install

### solc-select
Correct install:
```
$ solc-select -h
usage: solc-select [-h] {install,use,versions} ...

positional arguments:
  {install,use,versions}
                        Allows users to install and quickly switch between Solidity compiler versions
    install             list and install available solc versions
    use                 change the version of global solc compiler
    versions            prints out all installed solc versions

optional arguments:
  -h, --help            show this help message and exit
```

## Install the solc 0.7.6 compiler
```
$ solc-select install 0.7.6
$ solc-select use 0.7.6
```
## Ensure correct echidna install
Linux:
```
$ ./linux/echidna-test ./lab2.sol
```
Mac:
```
$ ./mac/echidna-test ./lab2.sol
```

## Troubleshooting
### Unable to locate solc-select
The following will add `solc-select` to your `$PATH` and will also use the solc installed by that
binary over any global installs of `solc`

> Linux: If `solc-select` does not display as shown above, ensure `~/.local/bin` is in `$PATH`
```
$ echo "export PATH=/home/$(whoami)/.local/bin:\$PATH" >> ~/.bashrc
$ source ~/.bashrc
```

> Mac: If `solc-select` does not display as shown above, ensure `/opt/homebrew/bin` is in `$PATH`
```
$ echo "export PATH=/home/$(whoami)/.local/bin:\$PATH" >> ~/.zshrc
$ source ~/.zshrc
```

### solc version not changing when using `solc-select use`
It is likely that a different solc binary is being used instead of the version installed by
`solc-select`. Ensure the path to the `solc` binary installed by `solc-select` is the first path in
the `$PATH` variable.
> Linux install directory: `~/.local/bin` \
> Mac install directory: `/opt/homebrew/bin`
```
# Determine file path being used
$ which solc

# Modify $PATH to include the local solc install (if not already at the start of $PATH)
# Linux
$ echo "export PATH=/home/$(whoami)/.local/bin:\$PATH" >> ~/.bashrc
$ source ~/.bashrc

# Mac
$ echo "export PATH=/opt/homebrew/bin:\$PATH" >> ~/.zshrc
$ source ~/.zshrc
```

### Error running slither
```
$ ./linux/echidna-test lab2.sol 
Analyzing contract: /home/foo/repos/intro_to_vr/echidna/lab2.sol:ArrayUtil
echidna-test: Error running slither:
```
Run slither as a standalone to get the error output
```
$ slither lab2.sol
```
One common problem is having both `sha3` and `pysha3` installed as python packages.
A list of install python packages can be seen by running the following:
```
$ python3 -m pip freeze

# Remove sha3 if both are installed
$ python3 -m pip uninstall sha3
```

[Further Troubleshooting](https://github.com/crytic/solc-select)