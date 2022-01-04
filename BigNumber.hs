module BigNumber where
import Data.Char

----------------------------------------2.1-------------------------------------------------

type BigNumber = [Int]
type RevBigNumber = [Int]


-- Fib module use 

-- Subtracts a bigNumber by one 
subByOneBN :: BigNumber -> BigNumber
subByOneBN bn = subBN bn [1]

-- Subtracts a bigNumber by two
subByTwoBN :: BigNumber -> BigNumber
subByTwoBN bn = subBN bn [2]


---------------------------------------2.2------------------------------------------------

-- For the scanner and output function we used the chr and ord functions of the Data.Char in order to convert from digits to their respective string representation and viceversa.
-- Conditions are put in place to interpret a possible negative signal (e.g. the use of the function symmetricBN). 
-- The scanner function is based on mapping the list made of the numerical characters to a number, using the function toInt which takes a Char and returns an Int.

scanner:: String -> BigNumber
scanner (x:xs) = if (x=='-') then symmetricBN (cleanZerosBN a) else cleanZerosBN((toInt x):a)
    where a = map toInt xs

-- Transforms a numerical character into an Int
toInt:: Char -> Int
toInt x = if(isNumber x) then ord x - ord '1' + 1 else error "Not a valid number character"

-- The choice of the typed representation method allows us to output the symmetric number, simply by changing the most significant digit.
-- The first element of the list representing the BigNumber is replaced by its symmetric

-- Returns the symmetric of a given bigNumber
symmetricBN:: BigNumber -> BigNumber
symmetricBN (x:xs) = -x:xs

---------------------------------------2.3------------------------------------------------

-- The output function is also based on mapping the list. 
-- In this case however, we map number to numerical characters using the function toChar which takes a Int and returns a char. 
-- Similarly, if the BigNumber we are outputting was negative, a negative signal will be added.

output:: BigNumber -> String
output (x:xs) = if x < 0 then '-':num else num 
    where num =map toChar ((abs x):xs)
    

-- Transforms an Int into a numerical character
toChar:: Int -> Char
toChar x = chr (ord '1' + x - 1)

-- Turning the number into its absolute is as simple as replacing the first element of the list is replaced by its absolute value.
absBN:: BigNumber -> BigNumber
absBN (x:xs) = (abs x):xs


---------------------------------------2.4------------------------------------------------

-- When computing a sum, there are four cases:  
     -- both operands are positive
     -- both are negative,
     -- the two circumstances where they have opposing signals. 
-- We can identify this four cases by seeing the signal of the first digits of both numbers. 

-- In the case both are negative, we compute the symmetric of the sum of both the symmetrics. 
-- In the case the signals are different, we convert the sum to the subtraction where both of the operands are positive. 

-- Only the sum of two positive numbers will be directly calculated by invoking an auxiliar function. 
-- For the sum of two positive numbers an algorithm for addition by hand will be replicated: 
     -- We will go through the numbers in the reverse order of their digits. 
     -- We will have an accumulator which will represent the digits of the result, already in the right order. 
     -- As we proceed, for each digit, the result modulo 10 is added to the accumulator. 
     -- Additionally, a variable will keep track of whether or not the sum of the two digits was bigger than 10 and to carry it to the next digit. 
     -- When the digits of both operands have been processed, the result will be the accumulator and we end the recursion. 


somaBN:: BigNumber -> BigNumber -> BigNumber
somaBN a [] = a
somaBN [] b = b
somaBN n1@(x:xs) n2@(y:ys)
    | x < 0 && y < 0 = symmetricBN (somaBN (symmetricBN n1) (symmetricBN n2))
    | x < 0 && y >= 0 = subBN (y:ys) (-x:xs)
    | x >= 0 && y < 0 = subBN (x:xs) (-y:ys)
    | x >= 0 && y >= 0 = cleanZerosBN (somaBNAcc(reverse n1) (reverse n2) 0 [])

somaBNAcc:: RevBigNumber -> RevBigNumber -> Int -> BigNumber -> BigNumber
somaBNAcc [] [] c acc= if c > 0 then somaBNAcc [] [] (div c 10) ((mod c 10):acc) else acc
somaBNAcc [] (x:xs) 0 acc= (reverse (x:xs)) ++ acc
somaBNAcc [] (x:xs) c acc= somaBNAcc [] xs (div (x+c) 10) ((mod (x+c) 10):acc)
somaBNAcc (x:xs) [] 0 acc= (reverse (x:xs)) ++ acc
somaBNAcc (x:xs) [] c acc= somaBNAcc xs [] (div (x+c) 10) ((mod (x+c) 10):acc)
somaBNAcc (x:xs) [y] c acc = somaBNAcc xs [] (div (x+y+c) 10) ((mod (x +y+c) 10):acc)
somaBNAcc [x] (y:ys) c acc = somaBNAcc [] ys (div (x+y+c) 10) ((mod (x +y+c) 10):acc)
somaBNAcc (x:xs) (y:ys) c acc = somaBNAcc xs ys (div (x + y + c) 10) ((mod (x+y+c) 10):acc)

---------------------------------------2.5------------------------------------------------

-- Similarly to the sum, when computing a subtraction there are four cases: 
    -- When the signals of the operands are different, the operation is transformed in a sum with two positive operands. 
    -- When both are negative, it is converted in the subtraction of the symmetrics with their orders swapped. 
    -- Only the subtraction of two negative number will be directly calculated by invoking an axuiliar function. 


-- The auxiliar function in structured in a way that the first operand must necessarily be bigger or equal than the second.
-- We verify which of the operands of the initial call was the biggest, using the auxiliar function biggerAbsBN. 

-- From this comparison, we can decide if the order of the arguments remains the same or swapped.
-- In case it's swapped, the symmetric of the subtraction operation will be returned

subBN:: BigNumber -> BigNumber -> BigNumber
subBN n1@(x:xs) n2@(y:ys)
    | x < 0 && y < 0 = subBN (-y:ys) (-x:xs)
    | x < 0 && y >= 0 = symmetricBN (somaBN (-x:xs) (y:ys))
    | x >= 0 && y < 0 = somaBN (x:xs) (-y:ys)
    | x >= 0 && y >= 0 = if biggerAbsBn n1 n2 
        then cleanZerosBN (subBNAcc (reverse n1) (reverse n2) 0 [])
        else symmetricBN (cleanZerosBN (subBNAcc (reverse n2) (reverse n1) 0 []))

-- For the subtraction of two positive numbers, where the first is bigger than the second, an algorithm for subtraction by hand will be replicated:
    -- We will go through the numbers in the reverse order of their digits. 
    -- An accumulator represents the digits of the result, already in the right order (passed down each call).
    -- Additionally, a variable will keep track or not the digit of the subtrahend was bigger than that of the minuend to reflect the borrowing from the next order of magnitude. 
    -- When the digits of both operands have been processed, the result will be the accumulator.

subBNAcc:: RevBigNumber -> RevBigNumber -> Int -> BigNumber -> BigNumber
subBNAcc [] [] _ acc = acc
subBNAcc [a] [] c acc = if (a-c) == 0 then acc else (a-c):acc
subBNAcc (x:xs) [] c acc = if x >= c then reverse ((x-c):xs) ++ acc else subBNAcc xs [] 1 ((10+x-c):acc)
subBNAcc (x:xs) (y:ys) c acc = if (y+c) <= x then subBNAcc xs ys 0 ((x-y-c):acc)
    else subBNAcc xs ys 1 ((10+x-y-c):acc)

------------------------------------Aux comparison and cleaning functions------------------------------------------------

-- Returns true if the number of digits of the two BigNumbers is the same
equalBNLen:: BigNumber -> BigNumber -> Bool
equalBNLen [] [] = True
equalBNLen a [] = False
equalBNLen [] b = False
equalBNLen (x:xs) (y:ys) = equalBNLen xs ys

-- Returns true if the number of digits of the first Bignumber is strictly bigger than the second's
biggerBNLen:: BigNumber -> BigNumber -> Bool
biggerBNLen [] [] = False
biggerBNLen a [] = True
biggerBNLen [] b = False
biggerBNLen (x:xs) (y:ys) = biggerBNLen xs ys

-- Returns true if the number of digits of the first BigNumber is strictly smaller than the second's
smallerBNLen:: BigNumber -> BigNumber -> Bool
smallerBNLen [] [] = False
smallerBNLen a [] = False
smallerBNLen [] b = True
smallerBNLen (x:xs) (y:ys) = smallerBNLen xs ys

-- Takes two positive BigNumbers and returns true if the value of the first BigNumber is bigger or equal than the second's
biggerAbsBn:: BigNumber -> BigNumber -> Bool
biggerAbsBn [] [] = True
biggerAbsBn a b
    | equalBNLen c d = biggerAbsBnAux c d
    | otherwise = biggerBNLen c d -- If the length is not equal; if the lenght is bigger then the number itself is bigger, if it is not bigger then the number itself is smaller
    where (c,d) = (cleanZerosBN a, cleanZerosBN b)

-- Takes two positive BigNumbers with the same number of digits and returns true if the value of the first is bigger or equal than the second's
biggerAbsBnAux:: BigNumber -> BigNumber -> Bool
biggerAbsBnAux [] [] = True
biggerAbsBnAux (x:xs) (y:ys) = if x > y then True else if x < y then False else biggerAbsBn xs ys

-- Given that an operation might have an arbitrary number of leading zeros, this function removes them and is called to clean the result of multiple operations.
-- For example, the subtraction between 12345 and 12312 would have resulted in 00033. 
-- So we don't keep useless information that might have implications in the operations themselves, we often remove this zeros. 
-- The removal is done by comparing the first digit with a 0. If that is not the case the number is returned. Otherwise, it is recursively called with the rest of the number.
-- Even though this function could have a maximum time complexity of O(n), for the majority of the situations none or few zeros will have to be removed.

cleanZerosBN:: BigNumber -> BigNumber
cleanZerosBN [] = [0]
cleanZerosBN n@(x:xs) = if x == 0 then cleanZerosBN xs else n

---------------------------------------2.6------------------------------------------------

-- Similarly to the previous to the addition and subtraction, when computing a multiplication there are four cases.
-- These are handled just keeping track of what the signal of the final result should be and calling the first axuiliar function which takes two positive BigNumber.
-- For the multiplication of two positive numbers, a strategy similar to what is used in the resolution of exercise 2.23 (2nd worksheet), 
--  which was available in moodle (see https://moodle.up.pt/pluginfile.php/130413/mod_resource/content/1/polinomios.hs), will be used.


-- Given the numbers AB and CD that we want to multiply, we can represent it as the following (applying the distributive property):
-- * ABC * DEF 
-- * = (AB0 + C) * (DE0 + F)
-- * = (AB0 * DE0) + (AB0 * F) + (C * DE0) + (C * F)
-- * = 10 * ((10 * (AB * DE)) + (AB * F) + (DE * C)) + (C * F)

-- Succinctly (x+abc0) (y + def0) = xy + x*def0 + yabc0 + abcdef00
mulBN:: BigNumber -> BigNumber -> BigNumber
mulBN a [0] = [0]
mulBN [0] b = [0]
mulBN (x:xs) (y:ys)
    | x < 0 && y < 0 = mulBNAux (-x:xs) (-y:ys)
    | x < 0 && y >= 0 = symmetricBN (mulBNAux (-x:xs) (y:ys))
    | x >= 0 && y < 0 = symmetricBN (mulBNAux (x:xs) (-y:ys))
    | x >= 0 && y >= 0 = mulBNAux (x:xs) (y:ys)


-- Intermediate step for the multiplication of two BigNumbers
mulBNAux:: BigNumber -> BigNumber -> BigNumber
mulBNAux a b =  reverse (mulBNAux2 (reverse a) (reverse b))

-- The auxiliar function will first calculate the products represented by (AB * F) and (DE * C) and add them. 
-- Subsequently, it will add the value obtained with the product (10 * (AB * DE)) which will be recursively calculated, since both AB and DE have more than 1 digit. 
-- Finally, it will multiply the result of this steps by 10 and add it with the product (C * F).

-- Take into account that, when a variable var is of the type RevBigNumber, multiplying it 10 is equivalent to just doing 0:var.

-- Additionally, one might notice the use of the reverse function mutiple times. 
-- This is due to the fact that the multiplication makes use of the auxiliary function which represent the addition whose arguments are reversed but the return value is not. 
-- Since we take the value of an addition and use it as the argument for another addition, reversing is mandatory. 
-- The auxiliary functions mulDigitBN and mulDigitBNAcc are also used. These multiply a BigNumber or RevBigNumber by a digit.

mulBNAux2:: RevBigNumber -> RevBigNumber -> RevBigNumber
mulBNAux2 a [] = a
mulBNAux2 [] b = b
mulBNAux2 [x] (y:ys) = reverse (mulDigitBNAcc (y:ys) x 0 [])
mulBNAux2 (x:xs) [y] = reverse (mulDigitBNAcc (x:xs) y 0 [])
mulBNAux2 (x:xs) (y:ys) = reverse (somaBNAcc (reverse (mulDigitBN [x] y)) (0:restantes) 0 [])
    where restantes = reverse (somaBNAcc (reverse (somaBN (mulDigitBNAcc ys x 0 []) (mulDigitBNAcc xs y 0 []))) (0:(mulBNAux2 xs ys)) 0 [])

-- Multiplies a BigNumber by a single digit int
mulDigitBN:: BigNumber -> Int -> BigNumber
mulDigitBN a 0 = [0]
mulDigitBN a b = mulDigitBNAcc (reverse a) b 0 []

-- Takes a RevBigNumber, multiplies it by a single digit int, and returns a BigNumber
mulDigitBNAcc:: RevBigNumber -> Int -> Int -> BigNumber -> BigNumber
mulDigitBNAcc [] _ c [] = [c]
mulDigitBNAcc [] _ c acc = if c == 0 then acc else c:acc
mulDigitBNAcc (x:xs) b c acc = mulDigitBNAcc xs b (div subTotal 10) ((mod subTotal 10):acc) where subTotal = x * b + c
---------------------------------------2.7------------------------------------------------

-- For this function it was only requested that we considered the arguments to be positive. 

-- Firstly , if it is the case that the divisor is bigger than the dividend, the result will be a quotient of 0 and a remainder equal to the divisor.
-- For the division of two positive numbers, the dividend being bigger than the divisor, an algorithm for division by hand will be replicated. 

-- For example, given a dividend of 5 digits and a divisor of 3 digits, we will take the 3 first digits. 
-- Let's call it the partial dividend and the remaining digits the tailing dividend:
    -- We divide the partial dividend number by the divisor.
    -- The quotient of that first step will be the digit of highest value of the solution. 
    -- To the remainder, we concatenate the first digit of the tailing dividend, to obtain the next partial dividend. We realize yet another divison of the partial dividend with the divisor.
    -- We repeat until there are no more digits in the tailing dividend. 
    -- The remainder of the solution will be the last remainder obtained. 
    -- The quotient of the solution will be the concatenation in order of all of the quotients which are necessarily a single digit. 
    -- This is the process that was replicated, taking into account number of any amount of digits.
   
    -- The first step is to obtain the first two numbers who are divided in the algorithm described above. This is done in the auxiliar function divBNPrep. 
    -- The second step is to iterate the partial and the tailing dividends and keep an accumulator. This is done in the function divBNAux

divBN:: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b
    | not (biggerAbsBn a b) = ([0], a) --The divisor is bigger than the dividend. Quotient is 0 and remainder is the dividend
    | otherwise = divBNAux firstDividend restDivident b []
    where (firstDividend, restDivident) = divBNPrep a b []

-- Takes a dividend and a divisor and obtains the partial dividiend and the tailing dividend
divBNPrep:: BigNumber -> BigNumber -> RevBigNumber -> (BigNumber, BigNumber)
divBNPrep (x:xs) [y] acc = (reverse (x:acc), xs)
divBNPrep (x:xs) (y:ys) acc = divBNPrep xs ys (x:acc)

-- The auxiliar function will perform the division once given the partial dividend, the tailing dividend and the divisor
-- The accumulator will contain the digits of the solution quotient in the reverse order and will have to be reversed in the final step
-- For each step, we divide the partial dividend by the divisor, using the function divBNAux2 which iterates subtraction, and we obtain a remainder and a digit for the quotient which we add to the accumulator.
-- We then call the function again after removing the first digit of the tailing dividend and concatenating it to the partial dividend. 
-- The process stops when there are no more digits to take from the tailing dividend

divBNAux:: RevBigNumber -> RevBigNumber -> BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBNAux x [] z acc = (cleanZerosBN (reverse (a:acc)), cleanZerosBN b)
    where (a,b) = divBNAux2 x z 0
divBNAux x (y:ys) z acc = divBNAux (b ++ [y]) ys z (a:acc)
    where (a, b) = divBNAux2 x z 0
    
-- Divides a BigNumber by a single digit int and returns the quotient and the remainder as a tuple
divBNAux2:: BigNumber -> BigNumber -> Int -> (Int, BigNumber)
divBNAux2 a b acc = if biggerAbsBn a b then divBNAux2 (subBN a b) b (acc+1) else (acc, a)


---------------------------------------5------------------------------------------------

-- Divides two BigNumbers safely. When the divisor is 0 returns Nothing.
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN a [0] = Nothing
safeDivBN a b = Just (divBN a b)