{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module LogAnalysis where

import Log

parseMessage :: String -> LogMessage
parseMessage line =
  case words line of
    "I" : ts : msg       -> LogMessage Info (read ts :: Int) (unwords msg)
    "W" : ts : msg       -> LogMessage Warning (read ts :: Int) (unwords msg)
    "E" : sev : ts : msg -> LogMessage (Error (read sev :: Int)) (read ts :: Int) (unwords msg)
    _ -> Unknown "This is not the right format"

parse :: String -> [LogMessage]
parse = map parseMessage . lines

insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) tree = tree
insert msg Leaf = Node Leaf msg Leaf
insert msg@(LogMessage _ timeStamp _) tree@(Node left cur@(LogMessage _ tS _) right)
  | timeStamp < tS    = Node (insert msg left) cur right
  | timeStamp > tS    = Node left cur (insert msg right)
  | tree == Leaf      = Node Leaf msg Leaf 

build :: [LogMessage] -> MessageTree
build = foldl (\acc msg -> insert msg acc) Leaf

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left msg Leaf) = inOrder left ++ [msg]
inOrder (Node Leaf msg right) = [msg] ++ inOrder right
inOrder (Node left msg right) = inOrder left ++ [msg] ++ inOrder right

errorAnd50 :: LogMessage -> Bool
errorAnd50 (LogMessage (Error val) _ _) = val > 50
errorAnd50 _ = False

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong = map (\(LogMessage _ _ msg) -> msg) 
                . filter errorAnd50 
                . inOrder 
                . build


