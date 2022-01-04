module Fib where

import Data.List
import BigNumber


----------------------------------------1-------------------------------------------------

---------------------------------------1.1------------------------------------------------

-- Pattern matching for 0 and 1 input, that are the base cases for the recursive call.
-- Fib is then calculated by adding up the recursive calls of both n - 1 and n - 2 until n = 0 or n = 1
-- In case the input is a negative number, an error message is displayed.

fibRec :: (Integral a) => a -> a
fibRec 0 = 0 --base case
fibRec 1 = 1 --base case 
fibRec n 
        | n > 1 = fibRec (n-1) + fibRec (n - 2) --add up the recursive calls
        | otherwise = error "Negative input" --negative input error 

-- For exercise 4
fibRecInt :: Int -> Int
fibRecInt 0 = 0 --base case
fibRecInt 1 = 1 --base case 
fibRecInt n
        | n > 1 = fibRecInt (n-1) + fibRecInt (n - 2) --add up the recursive calls
        | otherwise = error "Negative input" --negative input error 


--------------------------------------1.2------------------------------------------------


-- This function starts with setting up the base cases 0 and 1 to stop the recursion.
-- If the input is a negative number an error is displayed.
-- If the argument is a positive integer we extract the integral value to use as an index in the reversed (see below) fibonacci sequence list, 
-- calculated with the starting accumulator [1,0].


fibLista :: (Integral a) => a -> a
fibLista n 
          | n < 0 = error "Negative Input" 
          | otherwise =   reverse fib_seq !! fromIntegral n -- takes the nth value
                       where fib_seq = fibListaAux n [1,0]

-- List is reversed to meet objective requirement

-- Since constructing the list from left to right, adds the overhead (and complexity) of reaching the end of the list when we want to add up the two previously inserted values,
--  we opted by adding the next element to the head of the list. 
-- The complexity of reaching the two first elements in order to perform the addition operation becomes O(1), since it does not depend on the size of the list calculated. 

-- If the input value is 1 or 0, the values are already present on the base list, so we return it. 
-- Otherwise, we call the function on n - 1. 
-- The accumulator is now the previously calculated list with the head element as the sum of the first pair of values (the greatest numbers in the sequence). 
-- We do this step until the base case is reached and the list is completed. 


fibListaAux:: (Integral a) => a -> [a] -> [a]
fibListaAux n seq@(x:y:ys)
             | n == 0 || n == 1 = seq
             | otherwise = fibListaAux (n-1) (next_n:seq)
                                            where next_n = x + y


-- For exercise 4
fibListaInt :: Int -> Int
fibListaInt n 
          | n < 0 = error "Negative Input" 
          | otherwise =   reverse fib_seq !! fromIntegral n -- takes the nth value
                       where fib_seq = fibListaAux n [1,0]

--------------------------------------1.3------------------------------------------------


-- Infinite List calculation with lazy evaluation.
-- With the help of zipWith we can calculate the fibonacci sequence as an infinite list and then retrieve the intended value.
-- In case the input is negative an error message is displayed.
-- Otherwise we get the nth value of the sequence.

-- The fibs list starts with 0 and 1. 
-- The zipWith algorithm goes through the list pairing and adding up the current value with the last one placed in the list, 
--  then appending the result as the new tail (for the next calculation). The current value changes, as a result of going through the list.
-- The algorithm is efficient since the list values are not calculated instantly, but yielded until the nth number.

fibListaInfinita :: (Integral a) => a -> a
fibListaInfinita n   | n < 0 = error "Negative input"
                     | otherwise = fibs !! fromIntegral n  -- nth value 
                                   where fibs = 0 : 1 : zipWith (+) fibs (tail fibs) -- zipWith takes the current value and adds it up with the list tail

-- For exercise 4
fibListaInfinitaInt :: Int -> Int
fibListaInfinitaInt n   | n < 0 = error "Negative input"
                     | otherwise = fibs !! fromIntegral n -- nth value 
                                   where fibs = 0 : 1 : zipWith (+) fibs (tail fibs) -- zipWith takes the current value and adds it up with the list tail 



----------------------------------------3-------------------------------------------------

---------------------------------------3.1------------------------------------------------

-- Recursive approach to fibonacci number, but instead of Integers, Bignumbers are used.
-- If the input is one of the base cases [] [0] [1], the return values are defined using pattern matching. 
-- If bn > [2] :: BigNumber the fibonacci bnth is the result of the sum of bn - [2] and bn - 1.
-- Else a negative big number sends an error.

fibRecBN:: BigNumber -> BigNumber
fibRecBN [] = []
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN bn@(x:xs)
        | x < 0 = error "Negative input"
        | otherwise = somaBN (fibRecBN (subByOneBN bn)) (fibRecBN (subByTwoBN bn))


----------------------------------------AUX------------------------------------------------

-- Our implementation of the (!!) operator, in order to support BigNumber arrays and index value (used in 3.2 and 3.3 objectives) 
-- If an empty list is provided, [] is returned. 
-- If the intended index is [0] the head of the list is returned. 
-- Otherwise a recursive call is made, decreasing by 1 the search index and passing as the list argument, the tail of the current evaluated list.

listIndexBN:: [BigNumber] -> BigNumber -> BigNumber
listIndexBN [] a = []
listIndexBN (x:xs) [0] = x
listIndexBN (x:xs) a = listIndexBN xs (subByOneBN a)

---------------------------------------3.2------------------------------------------------

-- Dynamic programming fibonacci calculation (adapted to BigNumbers)
-- Setups up base cases for [0] and [1] input
-- An error is sent when the input is negative. 
-- When called with a valid input the function returns the nth value of the fibList3AuxBN list

fibListaBN:: BigNumber -> BigNumber
fibListaBN [0] = [0]
fibListaBN [1] = [1]
fibListaBN n@(x:xs) 
           | x < 0 = error "Negative Input"
           | otherwise = listIndexBN (fibList3AuxBN (subByTwoBN n) base_seq) n
                                         where base_seq = [scanner "1", scanner "0"]


-- This function accepts an input Bn, which is the nth - 2 value we want to obtain from the previous function 
--  and an accumulator that starts off with [[1], [0]] (the start of the fibonacci sequence, reversed). 

-- While the big number given as argument has not reached [0], we recursively call the function with the arguments (subByOneBN bn), 
--  to account the next "iteration") and place at the head of the accumulator, the new sequence value which is the sum of the first pair of bigNumbers.
-- In the case of [0], we return the reversed sequence list (to comply with the exercise guidelines) we've gathered so far, adding the last element to it's head.

fibList3AuxBN:: BigNumber -> [BigNumber] -> [BigNumber]
fibList3AuxBN [0] (x:y:ys) = reverse (somaBN x y:x:y:ys)
fibList3AuxBN n (x:y:ys) = fibList3AuxBN (subByOneBN n) (somaBN x y:x:y:ys)


---------------------------------------3.3------------------------------------------------

-- 1.3 adaptation for BigNumber operations. 
-- If the input is [], and empty list is returned. If the number is negative, an error occurs. 
-- In case the number is bigger that [2] :: BigNumber, we can get the nth number of the sequence by accessing the nth value of the fibs infinite list. 
-- It is calculated by pairing with zipWith the current value (when we're going through the list) with the last value added to the sequence (tail), with the somaBN operation. 


fibListaInfinitaBN:: BigNumber -> BigNumber
fibListaInfinitaBN [] = []
fibListaInfinitaBN bn@(x:xs)
        | x < 0 = error "Negative input"
        | otherwise = listIndexBN fibs bn
                where fibs = [0] : [1] : zipWith somaBN fibs (tail fibs)
