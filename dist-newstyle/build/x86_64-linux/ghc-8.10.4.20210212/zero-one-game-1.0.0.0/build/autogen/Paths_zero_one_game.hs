{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_zero_one_game (
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
version = Version [1,0,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/shrey/.cabal/bin"
libdir     = "/home/shrey/.cabal/lib/x86_64-linux-ghc-8.10.4.20210212/zero-one-game-1.0.0.0-inplace"
dynlibdir  = "/home/shrey/.cabal/lib/x86_64-linux-ghc-8.10.4.20210212"
datadir    = "/home/shrey/.cabal/share/x86_64-linux-ghc-8.10.4.20210212/zero-one-game-1.0.0.0"
libexecdir = "/home/shrey/.cabal/libexec/x86_64-linux-ghc-8.10.4.20210212/zero-one-game-1.0.0.0"
sysconfdir = "/home/shrey/.cabal/etc"

getBinDir     = catchIO (getEnv "zero_one_game_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "zero_one_game_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "zero_one_game_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "zero_one_game_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "zero_one_game_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "zero_one_game_sysconfdir") (\_ -> return sysconfdir)




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
