import fs from "fs";

const input = fs.readFileSync("./data.txt", "utf-8");


const [hisList, myList] = input.split('\n').map(line => line.split('   ').map(Number)).reduce((acc, [his, my]) => {
  if (!his || !my) return acc
  acc[0].push(his)
  acc[1].push(my)
  return acc
}
, [[], []] as [number[], number[]]).map(list => list.sort((a, b) => a - b))

console.log(hisList, myList)

if(!hisList || !myList || hisList.length !== myList.length) {
  throw new Error('Invalid input')
}

let sumOfDiffs = 0
for (let i = 0; i < hisList.length; i++) {
  if (typeof hisList[i] !== 'number' || typeof myList[i] !== 'number') {
    throw new Error('Invalid input')
  }
  const dif = Math.abs(hisList[i] as number -( myList[i] as number))
  console.log(dif)
 sumOfDiffs+= dif


}

console.log(sumOfDiffs)

const getAllIndexes = (arr: any[], val: any) => {
  const indexes = []
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] === val) {
      indexes.push(i)
    }
  }
  return indexes
}

const multipliedDifs = hisList.reduce(
  (sum, number) =>{
console.log(sum, number, getAllIndexes(myList, number).length, number *  getAllIndexes(myList, number).length)
  return  sum+(number *  getAllIndexes(myList, number).length)
  },0

)

console.log(multipliedDifs)
