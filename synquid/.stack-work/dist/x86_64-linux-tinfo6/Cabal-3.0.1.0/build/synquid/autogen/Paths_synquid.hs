{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_synquid (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
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
version = Version [0,4] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/carrotvm/repo/Syncompleixty/synquid/.stack-work/install/x86_64-linux-tinfo6/ddedeba712dff549fdcde7531fa11f3da36b51a35b35f790c8725aab898d70da/8.8.2/bin"
libdir     = "/home/carrotvm/repo/Syncompleixty/synquid/.stack-work/install/x86_64-linux-tinfo6/ddedeba712dff549fdcde7531fa11f3da36b51a35b35f790c8725aab898d70da/8.8.2/lib/x86_64-linux-ghc-8.8.2/synquid-0.4-FqFIMhTe42C4BldRFBQCs7-synquid"
dynlibdir  = "/home/carrotvm/repo/Syncompleixty/synquid/.stack-work/install/x86_64-linux-tinfo6/ddedeba712dff549fdcde7531fa11f3da36b51a35b35f790c8725aab898d70da/8.8.2/lib/x86_64-linux-ghc-8.8.2"
datadir    = "/home/carrotvm/repo/Syncompleixty/synquid/.stack-work/install/x86_64-linux-tinfo6/ddedeba712dff549fdcde7531fa11f3da36b51a35b35f790c8725aab898d70da/8.8.2/share/x86_64-linux-ghc-8.8.2/synquid-0.4"
libexecdir = "/home/carrotvm/repo/Syncompleixty/synquid/.stack-work/install/x86_64-linux-tinfo6/ddedeba712dff549fdcde7531fa11f3da36b51a35b35f790c8725aab898d70da/8.8.2/libexec/x86_64-linux-ghc-8.8.2/synquid-0.4"
sysconfdir = "/home/carrotvm/repo/Syncompleixty/synquid/.stack-work/install/x86_64-linux-tinfo6/ddedeba712dff549fdcde7531fa11f3da36b51a35b35f790c8725aab898d70da/8.8.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "synquid_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "synquid_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "synquid_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "synquid_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "synquid_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "synquid_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
