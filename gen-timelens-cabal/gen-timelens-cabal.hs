module Main (main) where

import qualified Cartel

version :: [Word]
version = [0,2,0,2]

properties :: Cartel.Properties
properties = Cartel.Properties
  { Cartel.name = "timelens"
  , Cartel.version = version
  , Cartel.cabalVersion = Just (1,10)
  , Cartel.buildType = Just Cartel.simple
  , Cartel.license = Just Cartel.bsd3
  , Cartel.licenseFile = "LICENSE"
  , Cartel.licenseFiles = []
  , Cartel.copyright = "Copyright (c) 2016 Omari Norman"
  , Cartel.author = "Omari Norman"
  , Cartel.maintainer = "omari@smileystation.com"
  , Cartel.stability = "Experimental"
  , Cartel.homepage = "http://www.github.com/massysett/timelens"
  , Cartel.bugReports = "http://www.github.com/massysett/timelens/issues"
  , Cartel.packageUrl = ""
  , Cartel.synopsis = "Lenses for the time package"
  , Cartel.description =
      [ "These are lenses for the time package.  Please see the README.md"
      , "for more information."
      ]
  , Cartel.category = "Development"
  , Cartel.testedWith = []
  , Cartel.dataFiles = []
  , Cartel.dataDir = ""
  , Cartel.extraSourceFiles = [ "README.md" ]
  , Cartel.extraDocFiles = []
  , Cartel.extraTmpFiles = []
  }

ghcOptions :: Cartel.HasBuildInfo a => a
ghcOptions = Cartel.ghcOptions
  [ "-W"
  ]

commonOptions :: Cartel.HasBuildInfo a => [a]
commonOptions
  = ghcOptions
  : Cartel.haskell2010
  : Cartel.hsSourceDirs ["lib"]
  : []

libraryDepends :: [Cartel.Package]
libraryDepends =
  [ Cartel.closedOpen "base" [4,8] [5]
  , Cartel.atLeast "lens" [4,13]
  , Cartel.atLeast "time" [1,5]
  ]

library
  :: [Cartel.NonEmptyString]
  -- ^ List of library modules
  -> [Cartel.LibraryField]
library libModules
  = Cartel.buildDepends libraryDepends
  : Cartel.exposedModules libModules
  : commonOptions

github :: Cartel.Section
github = Cartel.githubHead "massysett" "timelens"

sections :: [Cartel.Section]
sections =
  [ github
  ]

main :: IO ()
main = Cartel.defaultMain $ do
  libModules <- Cartel.modules "../timelens/lib"
  return (properties, library libModules, sections)
