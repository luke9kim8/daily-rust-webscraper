module Lib
    ( someFunc
    ) where

import Text.HTML.Scalpel
    ( scrapeURL,
      innerHTML,
      (@:),
      (@=~),
      (@=),
      AttributeName(AttributeString),
      TagName(TagString) )
import Data.Maybe
import Text.Regex.Base.RegexLike 
import Text.Regex.Base 

someFunc :: IO ()
someFunc = do 
            res <- getTitle
            print $ maybeToList res
            return ()

divTag :: TagName 
divTag = TagString "div"

styleAttr :: AttributeName
styleAttr = AttributeString "style"

getTitle :: IO (Maybe String)
getTitle = scrapeURL 
                "https://www.reddit.com/r/rust/comments/rpiyzw/hey_rustaceans_got_an_easy_question_ask_here/" 
                (innerHTML ( TagString "div" @: [AttributeString "style" @= "--commentswrapper-gradient-color:#FFFFFF;max-height:unset" ]))
 