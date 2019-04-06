import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers

-- The main method that will be used for testing / comgand line access

-- Quinn helped 

main = do
     args <- getArgs
     filename <- readFile (head args)
     (game,moves) <- readConnectFourFile filename
     print "Result"
     let result = manyPlayersOneMove game moves
     printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT
manyPlayersOneMove :: [[Char]] -> [Int] -> [[Char]]
manyPlayersOneMove [] _ = [] 
manyPlayersOneMove game moves = helperFunction game moves (getMaxPlayers game)

helperFunction :: [[Char]] -> [Int] -> [Char] -> [[Char]]
helperFunction game [] _ = game
helperFunction game _ [] =  game
helperFunction game (move : moves) (player : players) = helperFunction (secondHelperFunction game (move -1) player) moves players


getMaxPlayers :: [[Char]] -> [Char]
getMaxPlayers game = tail (sort (nub (concat game))) -- Quinn gave this to me

secondHelperFunction :: [[Char]] -> Int -> Char -> [[Char]]
secondHelperFunction game column player = if win game 
	                                       then game
	                                       else update game ( openRow game column 0) column player

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


openRow :: [[Char]] -> Int -> Int -> Int
openRow [] _ rowNum = rowNum -1
openRow (row:rows)  column rowNum = if((row !! column) /= '-')
	                                    then rowNum - 1
	                                    else openRow rows column (rowNum +1)
-- got help from quin for these parts 

horizontal :: [[Char]] -> Bool
horizontal [] = False
horizontal(row:rows) 
        | winHorizontal row  == True = True
        | otherwise = horizontal rows

winHorizontal :: [Char] -> Bool
winHorizontal (_:_:_:[]) = False
winHorizontal(first : second : third : fourth : row) 
        |  first /= '-' && first == second && first == third && first == fourth = True
        |  otherwise = winHorizontal(second : third : fourth : row)


vertical :: [[Char]] -> Bool
vertical game = horizontal (transpose game) 



diagonal :: [[Char]] -> Bool
diagonal (_:_:_:[]) = False

diagonal(first:second:third:fourth:rows)
           |  helper first second third fourth 0 == True = True
           |  otherwise = diagonal (second: third :fourth :rows)


helper :: [Char] -> [Char] -> [Char] -> [Char] -> Int -> Bool
helper first second third fourth number 
             |  (number > (length first) - 4) == True = False
             |  otherwise = secondHelper first second third fourth number



secondHelper :: [Char] -> [Char] -> [Char] -> [Char] -> Int -> Bool
secondHelper first second third fourth number
      | (( getElement first number ) /= '-') && ( getElement first number == getElement second ( number +1) ) && ( getElement first number == getElement third ( number +2) ) && ( getElement first number == getElement fourth ( number +3) ) = True
      | otherwise = helper first second third fourth ( number +1)


getElement :: [Char] -> Int -> Char
getElement (el:els) 0 = el
getElement (el:els) n = getElement els (n-1)



diagonalUp :: [[Char]] -> Bool
diagonalUp game = diagonal (reverse game)

win :: [[Char]] -> Bool
win game = (horizontal game || vertical game || diagonal game  || diagonalUp game)