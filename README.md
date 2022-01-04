# PFL-2021

Projects for the PFL UC

> Henrique Sousa 

> Antonio Ribeiro 

# Fib Module
 
## 1.1 fibRec 

- Standard recursive implementation of Fibonacci numbers. 

*** 
Test cases Notes: 
For values of 30 and above, we start to get a noticeable operation delay. This is due to the recursive nature of the implementation.

fibRec 0
> 0

fibRec 1
> 1

fibRec 10
> 55

*** 

## 1.2 fibLista

- Returns the nth number of the fibonacci sequence, following the memoization/dynamic programming strategy (use of a list with previously calculated values).

Note: since auxiliar function constructs the list from right to left (reversed), in order to meet the project guidelines we reversed the list, the nth number of the sequence corresponds to the nth element of the list.

### fibListaAux

- FibListaAux composes the reversed list of fibonacci numbers until a value n.

Test cases Notes: 
- Values starting at the order of magnitude of 1000000 are calculated with noticiable delay.

***

fibLista 0
> 0

fibLista 1
> 1

fibLista 10
> 55

fibLista 100
> 354224848179261915075

***

## 1.3 fibListaInfinita

- Returns the nth fibonacci number making use of an infinite list generator, that yields the next value in the sequence. 

***
Test cases Notes: 
- Values starting at the order of magnitude of 1000000 are calculated with noticiable delay.

fibListaInfinita 0
> 0

fibListaInfinita 1
> 1

fibListaInfinita 10
> 55

fibListaInfinita 100
> 354224848179261915075

***
## 3.1 fibRecBN

- The standard fibonacci recursive approach converted into Big Number operations. 

***

fibRecBN [0]
> [0]

fibRecBN [1]
> [1]

fibRecBN [1,0]
> [5,5]

***

## 3.2 fibListaBN

- Reinterpretation of the fibLista function, that outputs the nth fibonacci number. All done in BigNumber types. 

### fibListaAuxBN

- Constructs the list of fibonacci numbers (BigNumber typed) until a given value, using the dynamic programming approach. 

***

fibListaBN [0]
> [0]

fibListaBN [1]
> [1]

fibListaBN [1,0]
> [5,5]

fibListaBN [1,0,0]
> [3,5,4,2,2,4,8,4,8,1,7,9,2,6,1,9,1,5,0,7,5]

***

## 3.3 fibListaInfinitaBN

- Returns the nth fibonacci number, taking advantage of the lazy evaluation paradigm that outputs the infinite list (the sequence in BigNumber notation).

***

fibListaInfinitaBN [0]
> [0]

fibListaInfinitaBN [1]
> [1]

fibListaInfinitaBN [1,0]
> [5,5]

fibListaInfinitaBN [1,0,0]
> [3,5,4,2,2,4,8,4,8,1,7,9,2,6,1,9,1,5,0,7,5]

***

# BigNumber module

We will now describe how the BigNumber module is implemented

## Definition of a BigNumber
We choose to create the type BigNumber which is a list of Ints in the order they appear by. For example, the number 123 will be represented as [1,2,3]. 

For programming purposes and so we had an easier time with functions that reverse the order of this number, we also created the RevBigNumber type which represents the same digits in the opposite order.

A negative BigNumber can be identified if its first digit is negative. A positive BigNUmber has a positive first digit.



## 2.1 Scanner

- Converts a string literal into a BigNumber typed value 

*** 

scanner "0"
> [0]

scanner "00000"
> [0]

scanner "-0"
> [0]

scanner "-00000"
> [0]

scanner "1"
> [1]

scanner "-1"
> [-1]

scanner "12345"
> [1,2,3,4,5]

scanner "-12345"
> [-1,2,3,4,5]

scanner "000012345"
> [1,2,3,4,5]

scanner "-000012345"
> [-1,2,3,4,5]

***

## 2.2 Output 

- Inverse operation, given a BigNumber as input, it's printed as a String variable.

***

Test cases Notes: 
 - BigNumbers functions will strip leading 0's when necessary. As such, the string resulting from a series of leading 0's will not be clean. For demonstration purposes we also include these cases.
  
output [0]
> "0"

output [0,0,0]
> "000"

output [-0]
> "0"

output [-0,0,0]
> "000"

output [1]
> "1"

output [-1]
> "-1"

output [1,2,3,4,5]
> "12345"

output [-1,2,3,4,5]
> "-12345"

output [0,0,0,1,2,3,4,5]
> "00012345"

output [-0,0,0,1,2,3,4,5]
> "-00012345"

***

## SomaBN

Accepts two big numbers and returns their sum. It takes into account the four possible combinations of arguments (signed and not signed).

The function replicates the sum by hand calculation, in which both numbers are written in a column, aligning the least significant digit.

We then add up each digit, and if there is a carry value we take it in consideration for the next calculation.

***

somaBN [0] [0]
> [0]

somaBN [0] [9]
> [9]

[somaBN [0] [n] | n <- [1..9]]
> [[1],[2],[3],[4],[5],[6],[7],[8],[9]]

somaBN [9] [9]
> [1,8]

[somaBN [m] [n] | m <- [5..9], n <- [5..9]]
> [[1,0],[1,1],[1,2],[1,3],[1,4],[1,1],[1,2],[1,3],[1,4],[1,5],[1,2],[1,3],[1,4],[1,5],[1,6],[1,3],[1,4],[1,5],[1,6],[1,7],[1,4],[1,5],[1,6],[1,7],[1,8]]

somaBN [1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [9,8,7,6,6,6,6,6,6]

somaBN [-1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [9,8,7,6,4,1,9,7,6]

somaBN [-1,2,3,4,5] [-9,8,7,6,5,4,3,2,1]
> [-9,8,7,6,6,6,6,6,6]

somaBN [1,2,3,4,5] [-9,8,7,6,5,4,3,2,1]
> [-9,8,7,6,4,1,9,7,6]

somaBN [1,2,3,4,5] [-1,2,3,4,5]
> [0]

somaBN [1,2,3,4,5] [-1,2,3,0,0]
> [4,5]

***

<div style="page-break-after: always;"></div>

## SubBN

Accepts two big numbers and returns their sum. It takes into account the four possible combinations of arguments (signed and not signed).

The function replicates the subtraction by hand calculation, where both numbers are aligned, the operation is performed and a carry bit from the previous one is included the subtraction of the digits in question.

From an arithmetic perspective, it's easy to comprehend that the structure larger number at the top and smaller one at the bottom (absolute value comparison), makes calculations easier and intuitive. 
Even if the arguments don't work in our favor (e.g. the bigger number is signed), we can alter the equation (mantaing its value), in order to garantee that the operation is the one described above or a similiar operation is used to calculate its result. 

***
subBN [0] [0]
> [0]

subBN [9] [0]
> [9]

subBN [0] [9]
> [-9]

subBN [9] [9]
> [0]
 
[subBN [m] [n] | m <- [-5..5], n <- [-2..2]]
> [[-3],[-4],[-5],[-6],[-7],[-2],[-3],[-4],[-5],[-6],[-1],[-2],[-3],[-4],[-5],[0],[-1],[-2],[-3],[-4],[1],[0],[-1],[-2],[-3],[2],[1],[0],[-1],[-2],[3],[2],[1],[0],[-1],[4],[3],[2],[1],[0],[5],[4],[3],[2,[1],[6],[5],[4],[3],[2],[7],[6],[5],[4],[3]]

subBN [1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [-9,8,7,6,6,6,6,6,6]

subBN [-1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [-9,8,7,6,6,6,6,6,6]

subBN [-1,2,3,4,5] [-9,8,7,6,5,4,3,2,1]
> [9,8,7,6,4,1,9,7,6]

subBN [1,2,3,4,5] [-9,8,7,6,5,4,3,2,1]
> [9,8,7,6,6,6,6,6,6]

subBN [1,2,3,4,5] [1,2,3,4,5]
> [0]

subBN [1,2,3,4,5] [1,2,3,0,0]
> [4,5]

***


## MulBN

Multiplies two BigNumbers. 

A divide and conquer arithmetic approach is utilized. We divide the number into smaller chunks, which are then added into a final result.

Our decomposition proccess is executed in the following way: 

Given the numbers AB and CD that we want to multiply, we can represent it as the following (applying the distributive property):

- ABC * DEF 

- = (AB0 + C) * (DE0 + F)

- = (AB0 * DE0) + (AB0 * F) + (C * DE0) + (C * F)

- = 10 * ((10 * (AB * DE)) + (AB * F) + (DE * C)) + (C * F)


For recursion purposes each number is decomposed digit wise (e.g. 1234 transforms into 1230 + 4 and so on), and with the distributive property, we can interpret the base case operation as a simple digit multiplication (or two digits by one multiplication) and, when unrolling, we multiply it's value by 10 (corresponding to the decimal shift we need in order to fully represent the chunk's place according to it's order of magnitude), which will continuosly build our final result.

An approach similliar to the one used in the polynomial addition in the pratical class exercises is used for this purpose. 

<div style="page-break-after: always;"></div>

***
mulBN [0] [0]
> [0]

mulBN [9] [0]
> [9]
> 
mulBN [0] [9]
> [0]

mulBN [9] [9]
> [8,1]

mulBN [-9] [-9]
> [8,1]

mulBN [-9] [9]
> [-8,1]
 
mulBN [9] [-9] 
> [-8,1]

[mulBN [m] [n] | m <- [-5..5], n <- [-2..2]]
> [[1,0],[5],[0],[-5],[-1,0],[8],[4],[0],[-4],[-8],[6],[3],[0],[-3],[-6],[4],[2],[0],[-2],[-4],[2],[1],[0],[-1],[-2],[0],[0],[0],[0],[0],[-2],[-1],[0],[1],[2],[-4],[-2],[0],[2],[4],[-6],[-3],[0],[3],[6],[-8],[-4],[0],[4],[8],[-1,0],[-5],[0],[5],[1,0]]

mulBN [1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [1,2,1,9,2,5,9,2,5,9,2,7,4,5]

mulBN [-1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [-1,2,1,9,2,5,9,2,5,9,2,7,4,5]

mulBN [-1,2,3,4,5] [-9,8,7,6,5,4,3,2,1]
> [1,2,1,9,2,5,9,2,5,9,2,7,4,5]

mulBN [1,2,3,4,5] [-9,8,7,6,5,4,3,2,1]
> [-1,2,1,9,2,5,9,2,5,9,2,7,4,5]
 
mulBN [1,2,3,4,5] [0]
> [0]

mulBN [0] [1,2,3,4,5]
> [0]

***

## DivBN

Accepts two big numbers and returns the quotient of the first by the second.
The function replicates the division by hand calculation. It takes a section of the dividend with the same size of the divisor and does the quotient between the two. The quotient is accumulated as the digits of the final solution. The remaider is joined with the rest of the dividend. The process is repeated until we have processed the whole dividend. The last remainder will be the remainder of the division, and the quotient will be obtained from the digits of each partial division.

***

divBN [0] [9]
> ([0],[0])

divBN [5] [9]
> ([0],[5])

divBN [9] [9]
> ([1],[0])

divBN [1,0] [9]
> ([1],[1])


[divBN [m] [n] | m <- [1..9], n <- [2..5]]
> [([0],[1]),([0],[1]),([0],[1]),([0],[1]),([1],[0]),([0],[2]),([0],[2]),([0],[2]),([1],[1]),([1],[0]),([0],[3]),([0],[3]),([2],[0]),([1],[1]),([1],[0]),([0],[4]),([2],[1]),([1],[2]),([1],[1]),([1],[0]),([3],[0]),([2],[0]),([1],[2]),([1],[1]),([3],[1]),([2],[1]),([1],[3]),([1],[2]),([4],[0],([2],[2]),([2],[0]),([1],[3]),([4],[1]),([3],[0]),([2],[1]),([1],[4])]

divBN [1,2,3,4,5] [2]
> ([6,1,7,2],[1])

divBN [1,2,3,4,6] [2]
> ([6,1,7,3],[0])

divBN [1,2,3,4,5] [9,8,7,6,5,4,3,2,1]
> [1,2,1,9,2,5,9,2,5,9,2,7,4,5]

divBN [9,8,7,6,5,4,3,2,1] [1,2,3,4,5]
> ([8,0,0,0,4],[4,9,4,1])

divBN [0] [1,2,3,4,5]
> ([0],[0])

***

## safeDivBN 

A secure runtime implementation of safeDiv function. 

A Maybe Monad is introduced with the intention of verifying the divisor at runtime execution. 

If it's a [0] :: BigNumber, the operation can't be completed so we return _Nothing_, otherwise the result of the divBN is returned as a J_ust_ clause.

***

safeDivBN [0] [0]
> Nothing

safeDivBN [0] [1]
> Just ([0], [0])

safeDivBN [1] [0]
> Nothing

safeDivBN [9] [2]
> Just ([4],[1])

safeDivBN [9,8,7,6,5,4,3,2,1] [1,2,3,4,5]
> Just ([8,0,0,0,4],[4,9,4,1])

safeDivBN [1,2,3,4,5] [0]
> Nothing

***

## Auxiliary functions

### equalBNLen biggerBNLen smallerBNLen

These three functions return true if the number of digits of the first argument is equal, strictly bigger or strictly smaller than the number of digits of the second argument, respectively. This is done by recursively taking digits from each number and seeing which of them results in getting an empty list first.
_smallerBNLen_ is not used in any of the other functions, but we decided to keep it in the code since it operates very similarly to the others and provides the complementary functionality to the other two.

### biggerAbsBn

This functions takes two positive BigNumbers and returns true if the first argument is bigger or equal. First, if the length of both number is equal, we will use the function biggerAbsBbAux to compare the value of their digits. In case the size of the first number is bigger (for which we use the function _biggerBNLen_ to verify) then the number itself is bigger and we return true. Otherwise the second number is bigger and we return false.

### biggerAbsBnAux

Takes two positive positive BigNumbers with the same number of digits and returns true if the first is bigger or equal than the second. This is done recursively. If the first digit is bigger, then true is returned. If the first digit is smaller, then false is returned. Otherwise, the function is called with the remaining digits of both arguments. In case they are the same, true is returned.

### mulDigitBN

Multiplies a BigNumber by a digit. This is done recursively in the function _mulDigitBNAcc_.

### mulDigitBNAcc

The function replicates a multiplication by hand algorithm. It goes through the BigNumber in reverse order and multiplies each of its digits by the multiplicand and adds it to the carry from the previous step. The carry is kept in a variable and it is the quotient of the result of the previous operation and 10. The modulo by 10 of each multiplicative step is what is added to the accumulator. When we run out of digits, the accumulator is already in the right order and can be returned.

<div style="page-break-after: always;"></div>

### divBNPrep

This functions computes the partial and tailing dividend as described in the section for the _DivBN_. In practice it takes the first argument and returns two parts of it, where the first is the same length as the second argument. This is done by recursively calling the function with the tail of the arguments, after having safeguard each digit of the first in the accumulator. When the second argument runs out of digits, the accumulator and the remaining digits of the first argument are both returned in the form of a tuple.


### divBNAux2

This functions takes two BigNumbers where the first is the dividend and the second is the divisor. The circumstances in which the function is called are such that the dividend is not 10 times larger than the divisor. Therefore, the quotient will always be a number between 0 and 9, inclusively. The remainder will be a number between 0 and the divisor. The function will be called recursively. If the dividend is not bigger than the divisor, then it will return the value in the accumular as the quotient and the divisor as the remainder. Otherwise, it will call itself, but with the first argument subtracted by the divisor and the accumulator incremented by 1.


# Exercise 4

According to Haskell's documentation, the Int type describes a fixed precision integer, whereas the Integer type descrbies an infinite precision integer. The BigNumber type is also defined and implemented such as we can hold and operate on integers of any size. For our implementation of Haskell, 9223372036854775807 was the upper limit for the Int type (set at maxBound :: Int).

We verified that 92 is the biggest value for which an Int implementation of the fibLista function yields the right result. From there on, values won't be accurate, since the result is bigger than the max bound.

For the BigNumber implementation, 92 isn't the limit either since, as long as there is memory, we can compute for an integer of arbitrary size.

For the Integer implementation, 92 isn't the limit either since, as long as there is memory, we can compute for an integer of arbitrary size.

For example, we obtained an agreeing value for the Integer and BigNumber implementations of the 2000th Fibonacci number. However, we observed that the BigNumber took considerably longer and more memory space.
We used the command :set +s and obtained the following results for the FibLista implementations:
* Integer: 0.20 secs, 147,946,296 bytes allocated
* BigNumber: 0.77 secs, 353,461,328 bytes allocated

Similarly, for the 8000th Fibonacci number we obtained the following:

* Integer: 3.76 secs, 2,735,162,784 bytes allocated 

* BigNumber: 11.57 secs, 5,367,230,792 bytes allocated
  
In conclusion, Int will take 92 as the biggest argument for its functions. Integer and BigNumber will take an arbitrarily large number as long as there is memory, being the Integer implementation the fastest of the two.


