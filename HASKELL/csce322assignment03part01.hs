import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers

-- The main method that will be used for testing / comgand line access

--  Quinn  helped 

main = do
     args <- getArgs
     filename <- readFile (head args)
     (game,moves) <- readConnectFourFile filename
     print "Result"
     let result = onePlayerOneMove game (head moves)
     printGame result

     -- YOUR CODE SHOULD COME AFTER THIS POINT

onePlayerOneMove :: [[Char]] -> Int -> [[Char]]
onePlayerOneMove [] _ = []
onePlayerOneMove game move  =  playSingleMove game (move-1) '1'

playSingleMove :: [[Char]] -> Int -> Char -> [[Char]]
playSingleMove game column player = update game ( openRow game column 0) column player

update :: [[Char]] -> Int -> Int -> Char -> [[Char]]
update [] _ _ _ = []
update (head:tail) row col x 
    | row == 0 = ((update1D head col x):tail)
	| otherwise = head:(update tail (row-1) col x)

                                                 
update1D :: [Char] -> Int -> Char -> [Char]
update1D [] _ _ = []
update1D (head:tail) a x 
   | a == 0 = (x:tail)
   | otherwise = (head : (update1D tail (a - 1) x))

-- This part was mostly helped by quinn
openRow :: [[Char]] -> Int -> Int -> Int
openRow [] _ rowNum = rowNum -1
openRow (row:rows)  column rowNum = if((row !! column) /= '-')
	                                    then rowNum - 1
	                                    else openRow rows column (rowNum +1)






