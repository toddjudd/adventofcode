# Advent Of Code

## Description

This year I'm working on the Advent of Code challenges in TypeScript AND Ruby. I'm using this as an opportunity to stretch my Typescript skills while I learn Ruby and to get more comfortable with it.

```bash
# install
npm i
bundle
```

## Dependencies

- typescript
- tsx
- nodemon
- eslint
- prettier
- ruby

## Usage

I wrote a bash script to generate the files for each day. It takes the year as an argument and creates a directory for that year with a file for each day. This could be used next year by changing passing in the output directory as an argument.

```bash
# generate files
bash fileSetup.sh 2024
```

## Inputs

The inputs for each file will be stored in the data.txt file in each directory. I've written a CalendarDate class that I intend to flesh out more with daily tasks. Each solution will extend this class. calling `super(day)` will get the data from the api and store it in the data.txt file. it should then be available in a data property.

## Run a solution

### Ruby

```bash
ruby src/main.rb 01 # runs the solution for day 1
```
