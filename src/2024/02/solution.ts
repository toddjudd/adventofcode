import fs from "fs";
const input = fs.readFileSync("./data.txt", "utf-8");


const reports = input
  .split("\n")
  .map((line) => line.split(" ").map((num) => parseInt(num))); // convert input to 2D array of numbers

// const arrDirection = (arr: number[]) => {
//   const out = arr.map((num, i) => {
//     if (i === 0) return 0;
//     const lastNum = arr[i - 1];
//     if (typeof num !== "number" || typeof lastNum !== "number") return 0;
//     return Math.sign(num - lastNum);
//   });
//   out.shift();
//   const sum = out.reduce((acc, val) => acc + val, 0);
//   return Math.sign(sum);
// };
// console.log(reports.map(arrDirection));
const isSorted = (arr: number[]) => {
  if (arr.length <= 2) return true;
  if (!arr) return false;
  if (typeof arr[1] !== "number" || typeof arr[0] !== "number") return false;
  const direction = Math.sign(arr[1] - arr[0]);

  for (let i = 1; i < arr.length; i++) {
    const a = arr[i];
    const b = arr[i - 1];
    if (typeof a !== "number" || typeof b !== "number") {
      return false;
    }
    if (Math.sign(a - b) !== direction) {
      return false;
    }
  }
  return true;
};

const minMaxDiff = (arr: number[]) => {
  let max = 0;
  let min = Infinity;
  for (let i = 1; i < arr.length; i++) {
    const a = arr[i];
    const b = arr[i - 1];
    if (typeof a !== "number" || typeof b !== "number") {
      throw new Error("Invalid input");
    }
    const diff = Math.abs(a - b);
    if (diff < min) {
      min = diff;
    }
    if (diff > max) {
      max = diff;
    }
  }
  return { min, max };
};

const reportStats = reports.map((report) => {
  const { min, max } = minMaxDiff(report);
  const sorted = isSorted(report);
  const safe = sorted && max < 4 && min > 0;
  return { report, sorted, min, max, safe };
});

// console.log(reportStats)

const safeReportCount = reportStats.filter((report) => report.safe).length;

const relaxedReportStats = reports.map((report) => {
  const { min, max } = minMaxDiff(report);
  const sorted = isSorted(report);
  const safe = sorted && max < 4 && min > 0;
  if (safe) {
    // console.log("Strict Safe Report: ", report);
    return { report, sorted, min, max, safe };
  }
  for (let i = 0; i < report.length; i++) {
    let relaxedReport = [...report];
    relaxedReport.splice(i, 1);

    const { min, max } = minMaxDiff(relaxedReport);
    const sorted = isSorted(relaxedReport);
    const safe = sorted && max < 4 && min > 0;
    if (safe) {
      console.log("Relaxed Safe Report: ");
      console.log("Original: ", report);
      const originalMinMax = minMaxDiff(report);
      const originalSorted = isSorted(report);
      console.log({
        min: originalMinMax.min,
        max: originalMinMax.max,
        sorted: originalSorted,
      });
      console.log("Relaxed: ", relaxedReport);
      console.log({ min, max, sorted, safe });
      console.log("\n\n");

      return { report, sorted, min, max, safe };
    }
  }
  // console.log("No Safe Report: ", report);
  return { report, sorted, min, max, safe };
});

// console.log(relaxedReportStats);

const relaxedSafeReportCount = relaxedReportStats.filter(
  (report) => report.safe,
).length;

console.log("Strict Safe Report Count: ", safeReportCount); // 0
console.log("Relaxed Safe Report Count: ", relaxedSafeReportCount); // 0
