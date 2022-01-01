{-# LANGUAGE OverloadedStrings #-}

module Temp 
    ( run
    ) where

import Test.WebDriver

firefoxConfig :: WDConfig
firefoxConfig = defaultConfig

chromeConfig :: WDConfig
chromeConfig = useBrowser chr defaultConfig
  { wdHost = "127.0.0.1", wdPort = 4444 }
  where chr = chrome



run = runSession chromeConfig  $ do
  openPage "https://google.com" 
  searchInput <- findElem ( ByCSS "input[type='text']" )
  sendKeys "Hello, World!" searchInput 
  submit searchInput 
  closeSession