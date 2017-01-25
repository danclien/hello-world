{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid ((<>))
import Options.Applicative (Parser, ParserInfo, auto, execParser, help, helper, info, option, long, short, value)
import Web.Scotty (scotty, get, html)

-- | Parse the port number from the command line arguments and start the server
main :: IO ()
main = do
  (Options port) <- execParser optionsParserInfo
  putStrLn $ "Running on port " <> (show port) <> "..."
  runServer port

-- | Start the server with the given port
runServer :: Int -> IO ()
runServer port =
  scotty port $ do
    get "/" $ do
      html "<html><body>Hello, world!</body></html>"

-- | Data structure to hold command line options
data Options = Options
  { portNumber :: Int
  } deriving (Show)

-- | optparse-applicative Parser for 'Options'
optionsParser :: Parser Options
optionsParser =
  Options
    <$> option auto (long "port" <> short 'p' <> help "Port number" <> value 3000)

-- | Additional metadata for optparse-applicative like program description
optionsParserInfo :: ParserInfo Options
optionsParserInfo = info (helper <*> optionsParser) mempty
