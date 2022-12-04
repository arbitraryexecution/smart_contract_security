# Slither, Plugin Example

This repository contains an example of plugin for Slither.

See the [detector documentation](https://github.com/trailofbits/slither/wiki/Adding-a-new-detector).

## Architecture

- `setup.py`: Contain the plugin information
- `slither_my_plugin/__init__.py`: Contain `make_plugin()`. The function must return the list of new detectors and printers
- `slither_my_plugin/detectors/function_scanner.py`: Detector plugin skeleton.

Once these files are updated with your plugin, you can install it:
```bash
python setup.py develop
```

Or

```bash
pip install .
```

We recommend to use a Python virtual environment (for example: [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/)).

## Lab Exercise

`Obfuscated.sol` contains a mildly obfuscated solidity source file.

This contract has two state variables: `passwd` and `secret`. The author has foolishly hardcoded a random number as the `secret`

The function `takeMonies` will pay out the contract's balance to the caller if `passwd` equals `secret`. The only problem is, none of these functions seem to modifiy passwd in a useful way.

Your task is to write a slither detector that examines these functions in more detail using slither's intermediate representation and discovers a way to pick the right `passwd`.
