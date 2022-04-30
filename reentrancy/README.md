This project contains several Solidity reentry puzzles - both hacks and patches to be solved.

You can find all the puzzles in the `./challenges` directory. Each challenge will have its own directory and contain one or more Solidity files, a test JS file and a README.md file with instructions on how to solve the puzzle.

Depending on the puzzle, code will need to be written either the Solidity files, the test files or both. The code that needs to be written will be marked with a `// CHALLENGE:` comment, so be sure to look for these places in the challenge files.

To get started, clone this repository and run: `npm i` to install the dependencies.

To run a given challenge to see if you've correctly solved it, you can run
```shell
npm run <challenge-name>
```

To run all challenges, run
```shell
npm run all
```
