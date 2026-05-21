// Catalan number sequence using an iterative multiplicative relation.
function printCatalanSequence(count) {
    let catalanValue = 1;
    const output = [catalanValue];

    for (let i = 1; i < count; i++) {
        catalanValue *= 4 * i - 2;
        catalanValue /= i + 1;
        output.push(catalanValue);
    }

    console.log(output.join(" "));
}

const count = 5;
printCatalanSequence(count);
