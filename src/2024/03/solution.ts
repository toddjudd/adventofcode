import fs from "fs";
const input = fs.readFileSync("./data.txt", "utf-8");

// Mul(x, y) returns x * y
// x and y are numbers
// x and y are between 0 and 999

// find the mul Input
// run the mul function
// sum the totals

const regex = /(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don't\(\))/gim;

console.log(input);
if (!input || typeof input !== "string") {
  throw new Error("Input is invalid");
}

const matches = input.match(regex);

console.log(matches);

if (!matches) {
  throw new Error("No matches found");
}

let enabled = true;
const filterMatches = matches
  .map((match) => {
    if (match.includes("don't")) {
      enabled = false;
      return null;
    }
    if (match.includes("do")) {
      enabled = true;
      return null;
    }
    if (!enabled) {
      return null;
    }
    return match;
  })
  .filter((match) => match !== null);

console.log(filterMatches);

const sum = filterMatches
  .map((match) => {
    const values = match.match(/\d{1,3}/gim);
    if (!values) {
      throw new Error("No values found");
    }

    const [x, y] = values;

    if (!x || !y) {
      throw new Error("No values found");
    }

    return parseInt(x) * parseInt(y);
  })
  .reduce((acc, curr) => acc + curr, 0);

console.log(sum);
