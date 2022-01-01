{-# LANGUAGE OverloadedStrings #-}

module Temp 
    ( run
    ) where

import Test.WebDriver
import Data.Text
import Test.WebDriver.Commands.Wait (waitUntil)
import Test.WebDriver.Session (WDSessionState(getSession))
import Test.WebDriver.JSON (ignoreReturn)
import Test.WebDriver.Common.Keys (arrowDown)
import Control.Monad (replicateM_)

firefoxConfig :: WDConfig
firefoxConfig = defaultConfig

chromeConfig :: WDConfig
chromeConfig = useBrowser chr defaultConfig
  { wdHost = "127.0.0.1", wdPort = 4444 }
  where chr = chrome


run = runSession firefoxConfig  $ do
  openPage "https://www.reddit.com/r/rust/comments/rkjf0e/hey_rustaceans_got_an_easy_question_ask_here/" 
  body <- findElem $ ByTag "body"
  replicateM_ 1000 $ sendKeys arrowDown body
  getSource
