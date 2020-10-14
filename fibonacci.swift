func fibonacci(n: Int) -> [Int]{
    if n < 1{ return [] }
    if n < 2{ return [0] }

    var f1=0
    var f2=1
    var fib=0
    var result: [Int] = [f1,f2]
    //print("Fibonacci: = \(f1)")
    //print("Fibonacci: = \(f2)")
    for number in 2..<n {
        fib = f1 + f2
        result.append(fib)
        //print("Fibonacci: = \(fib)")
        f1 = f2
        f2 = fib
    }
    return result
}
print(fibonacci(n: 10))
