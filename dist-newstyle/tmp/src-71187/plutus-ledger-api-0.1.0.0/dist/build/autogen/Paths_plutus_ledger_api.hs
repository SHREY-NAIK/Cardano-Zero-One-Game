{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_plutus_ledger_api (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/plutus-ledger-api-0.1.0.0-7ad7bd8e7606baf8c5058e1e06941cae194fd7869b4e10366c5c4af477e8f9db/bin"
libdir     = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/plutus-ledger-api-0.1.0.0-7ad7bd8e7606baf8c5058e1e06941cae194fd7869b4e10366c5c4af477e8f9db/lib"
dynlibdir  = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/plutus-ledger-api-0.1.0.0-7ad7bd8e7606baf8c5058e1e06941cae194fd7869b4e10366c5c4af477e8f9db/lib"
datadir    = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/plutus-ledger-api-0.1.0.0-7ad7bd8e7606baf8c5058e1e06941cae194fd7869b4e10366c5c4af477e8f9db/share"
libexecdir = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/plutus-ledger-api-0.1.0.0-7ad7bd8e7606baf8c5058e1e06941cae194fd7869b4e10366c5c4af477e8f9db/libexec"
sysconfdir = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/plutus-ledger-api-0.1.0.0-7ad7bd8e7606baf8c5058e1e06941cae194fd7869b4e10366c5c4af477e8f9db/etc"

getBinDir     = catchIO (getEnv "plutus_ledger_api_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "plutus_ledger_api_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "plutus_ledger_api_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "plutus_ledger_api_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "plutus_ledger_api_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "plutus_ledger_api_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
