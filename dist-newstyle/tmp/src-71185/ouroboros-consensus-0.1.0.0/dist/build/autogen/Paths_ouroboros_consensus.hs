{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_ouroboros_consensus (
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
bindir     = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/ouroboros-consensus-0.1.0.0-d5398589b7debfd6171abae30df4f7d8fae2879c9bb9d0aaf65db2d7568f2c65/bin"
libdir     = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/ouroboros-consensus-0.1.0.0-d5398589b7debfd6171abae30df4f7d8fae2879c9bb9d0aaf65db2d7568f2c65/lib"
dynlibdir  = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/ouroboros-consensus-0.1.0.0-d5398589b7debfd6171abae30df4f7d8fae2879c9bb9d0aaf65db2d7568f2c65/lib"
datadir    = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/ouroboros-consensus-0.1.0.0-d5398589b7debfd6171abae30df4f7d8fae2879c9bb9d0aaf65db2d7568f2c65/share"
libexecdir = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/ouroboros-consensus-0.1.0.0-d5398589b7debfd6171abae30df4f7d8fae2879c9bb9d0aaf65db2d7568f2c65/libexec"
sysconfdir = "/home/shrey/.cabal/store/ghc-8.10.4.20210212/ouroboros-consensus-0.1.0.0-d5398589b7debfd6171abae30df4f7d8fae2879c9bb9d0aaf65db2d7568f2c65/etc"

getBinDir     = catchIO (getEnv "ouroboros_consensus_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "ouroboros_consensus_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "ouroboros_consensus_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "ouroboros_consensus_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ouroboros_consensus_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ouroboros_consensus_sysconfdir") (\_ -> return sysconfdir)




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
