function catalan(n)
{
    let cat_ = 1;
 
    // For the first number
    console.log(cat_ + " "); // C(0)
 
    // Iterate till N
    for (let i = 1; i < n; i++)
    {
        // Calculate the number
        // and print it
        cat_ *= (4 * i - 2);
        cat_ /= (i + 1);
        console.log(cat_ + " ");
    }
}
 
// Driver code
    let n = 5;
 
    // Function call
    catalan(n);