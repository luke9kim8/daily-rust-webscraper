{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( someFunc
    ) where
import Text.HTML.Scalpel
import Data.Maybe
import Data.Default
import qualified Data.ByteString.Char8 as C
import qualified Network.HTTP.Client as HTTP
import qualified Network.HTTP.Client.TLS as HTTP
import qualified Network.HTTP.Types.Header as HTTP

someFunc :: IO ()
someFunc = do 
            res <- getCommentDiv targetUrl
            case res of 
                Just a -> do 
                    print a
                    print $ Prelude.length a
                Nothing -> print "No result"
            return ()
targetUrl :: URL 
targetUrl = "https://www.reddit.com/r/rust/comments/rkjf0e/hey_rustaceans_got_an_easy_question_ask_here/" 

managerSettings :: HTTP.ManagerSettings
managerSettings = HTTP.tlsManagerSettings {
  HTTP.managerModifyRequest = \req -> do
    req' <- HTTP.managerModifyRequest HTTP.tlsManagerSettings req
    return $ req' {
      HTTP.requestHeaders = (HTTP.hUserAgent, "Chrome") : HTTP.requestHeaders req'
    }
}

getCommentDiv :: URL -> IO (Maybe [String])
getCommentDiv url = do 
                    manager <- Just <$> HTTP.newManager managerSettings
                    scrapeURLWithConfig (def { manager = manager }) url comments
                    where 
                        comments :: Scraper String [String]
                        comments = chroots (TagString "div" @: [hasClass "Comment" ] ) spanScraper
                        spanScraper :: Scraper String String
                        spanScraper = text $ tagSelector "span"

-- getComments url = scrapeURL url comments
--             where 
--                 comments = chroot 
--                             (TagString "div" @: [hasClass "Comment" ] ) 
--                             $ inSerial do 
                                