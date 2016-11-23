import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Tabbed
import           XMonad.Hooks.UrgencyHook     ( withUrgencyHook
                                              , NoUrgencyHook (..)
                                              )
import           XMonad.Util.EZConfig         (additionalKeys)
import           XMonad.Actions.WindowBringer (gotoMenu)
import           XMonad.Hooks.EwmhDesktops    (ewmh)
import           XMonad.Util.Run              (spawnPipe, hPutStrLn)
import           Data.List                    (intercalate)

darkRed   = "#cc241d"
red       = "#fb4934"
darkGreen = "#98971a"
green     = "#b8bb26"
darkBlue  = "#458588"
blue      = "#83a598"
orange    = "#fe8019"
fg        = "#ebdbb2"
bg0       = "#282828"
bg1       = "#3c3836"
bg2       = "#504945"
bg3       = "#665c54"
bg4       = "#7c6f64"
gray      = "#a89984"

xmCommand :: String -> [String] -> Int -> String
xmCommand name params delay = intercalate " " ["Run", name, show params, show delay]

xmCPU = xmCommand "MultiCpu" params 10 where
  params = [ "-t", "<fc=" ++ green ++ "><bar0><bar1><bar2><bar3></fc>"
           , "-L", "50", "-l", blue
           , "-H", "90", "-h", red
           , "-n", orange
           , "-W", "1"
           , "-b", "●", "-f", "●"
           ]

xmMem = xmCommand "Memory" params 10 where
  params = [ "-t", "<usedratio>%"
           , "-H", "80", "-h", red
           , "-n", "orange"
           , "-w", "4"
           ]

xmSwap = xmCommand "Swap" params 10 where
  params = [ "-t", "<usedratio>%"
           , "-H", "50", "-h", red
           , "-L", "10", "-l", fg
           , "-n", orange
           , "-w", "4"
           ]

xmBattery = xmCommand "Battery" params 20 where
  params = [ "-t", "<acstatus>"
           , "-L", "100", "-l", red
           , "-H", "20"
           , "-f", "●", "-b", "·"
           , "--"
           , "-p", blue
           -- Discharging
           , "-o", "<leftbar> <fc=" ++ red ++ ">▼</fc> <left>%"
           -- Charging
           , "-O", "<leftbar> <fc=" ++ blue ++ ">▲</fc> <left>%"
           -- Charged
           , "-i", "<fc=" ++ blue ++ ">Charged</fc>"
           ]

xmSingleCPU = xmCommand "Cpu" params 10 where
  params = [ "-t", "CPU: <total>"
           , "-n", orange
           , "-h", red
           , "-w", "3"
           ]

xmCommands = intercalate ", " [xmSingleCPU, xmCPU, xmMem, xmSwap, xmBattery]


main = do
    xmproc <- spawnPipe $ "xmobar"
                        ++ " -F '" ++ fg ++ "'"
                        ++ " -B '" ++ bg0 ++ "'"
                        ++ " -C '[" ++ xmCommands ++ "]'"
                        ++ " ~/.xmonad/xmobar.hs"
    xmonad $ withUrgencyHook NoUrgencyHook $ myConfig xmproc

myBar = "xmobar"
myPP xmproc = xmobarPP { ppOutput = hPutStrLn xmproc
                       , ppCurrent = xmobarColor darkBlue ""
                         -- . wrap "[" "]"
                       , ppTitle = xmobarColor darkBlue ""
                       , ppUrgent = xmobarColor red "" . xmobarStrip
                       }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myKeys = [((mod1Mask, xK_g), gotoMenu)]

tabbedLayout :: Theme
tabbedLayout = defaultTheme
  { activeColor = darkBlue
  , activeBorderColor = darkBlue
  , activeTextColor = fg
  , inactiveColor = bg1
  , inactiveBorderColor = bg1
  , inactiveTextColor = fg
  , decoHeight = 12
  , fontName = "-*-consolas-bold-r-*-*-*-*-*-*-*-*-*-*"
  }

myLayoutHook =    avoidStruts
              $   tiled
              ||| tabbed shrinkText tabbedLayout
              where tiled   = Tall nmaster delta ratio
                    nmaster = 1
                    ratio   = 1 / 2
                    delta   = 3 / 100

myConfig xmproc = ewmh $ desktopConfig
    { terminal           = "urxvtcd"
    , modMask            = mod1Mask
    , layoutHook         = myLayoutHook
    , normalBorderColor  = bg1
    , focusedBorderColor = darkBlue
    , manageHook         = manageHook defaultConfig <+> manageDocks
    , startupHook        = setWMName "LG3D"
    , logHook            = dynamicLogWithPP $ myPP xmproc
    } `additionalKeys` myKeys
