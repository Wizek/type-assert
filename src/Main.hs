module Main where

import Internal
import Test.Hspec

main :: IO ()
main = hspec $ do
  specify "s" $ do
    1 `shouldBe` 1
    [shouldTypecheck|    1 :: Int  |]
    [shouldNotTypecheck| 1 :: Char |]
    1 `shouldBe` 1
