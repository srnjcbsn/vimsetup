import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Tabbed
import           XMonad.Layout.Renamed
import           XMonad.Hooks.UrgencyHook     ( withUrgencyHook
                                              , NoUrgencyHook (..)
                                              )
import           XMonad.Util.EZConfig         (additionalKeys, removeKeys)
import           XMonad.Actions.WindowBringer (gotoMenu)
import           XMonad.Hooks.EwmhDesktops    (ewmh)
import           XMonad.Util.Run              (spawnPipe, hPutStrLn)
import           Data.List                    (intercalate)
import qualified XMonad.StackSet as W

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
  params = [ "-t", "<fc=" ++ green ++ "><bar0><bar1><bar2><bar3><bar4><bar5><bar6><bar7><bar8><bar9><bar10><bar11><bar12><bar13><bar14><bar15></fc>"
           , "-L", "50", "-l", blue
           , "-H", "90", "-h", red
           , "-n", orange
           , "-W", "1"
           , "-b", "░", "-f", "░"
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

myKeys = [ ((mod1Mask, xK_g), gotoMenu)
	  -- ((mod1Mask, xK_o), spawn "scrot /tmp/scrot.png && convert -scale 5% -scale 2000% /tmp/scrot.png /tmp/scrot.png && i3lock -i /tmp/scrot.png")
	 , ((mod1Mask, xK_o), spawn "i3lock -t -i ~/Downloads/banan3.png")
	 , ((mod4Mask, xK_j), windows W.focusDown)
	 , ((mod4Mask, xK_k), windows W.focusUp)
	 , ((mod4Mask .|. shiftMask, xK_j), windows W.swapDown)
	 , ((mod4Mask .|. shiftMask, xK_k), windows W.swapUp)
	 ]
	 ++
	 -- mod-[1..9] %! Switch to workspace N
         -- mod-shift-[1..9] %! Move client to workspace N
	 [((m .|. mod4Mask, k), windows $ f i)
             | (i, k) <- zip (map show [1 .. 9]) [xK_1 .. xK_9]
             , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
	-- Taken from https://wiki.haskell.org/Xmonad/Frequently_asked_questions (Screens are in wrong order)
	 ++
	 [((m .|. mod1Mask, key), screenWorkspace sc >>= flip whenJust (windows . f)) -- Replace 'mod1Mask' with your mod key of choice.
		| (key, sc) <- zip [xK_w, xK_e, xK_r] [0, 2, 1] -- was [0..] *** change to match your screen order ***
		, (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

rmKeys = [ (mod1Mask, xK_j)
	 , (mod1Mask, xK_k)
	 , (mod1Mask, xK_h)
	 , (mod1Mask, xK_l)
	 , (mod1Mask .|. shiftMask, xK_j)
	 , (mod1Mask .|. shiftMask, xK_k)
	 , (mod1Mask, xK_Tab)
	 , (mod1Mask .|. shiftMask, xK_Tab)
	 ]
	 ++
	 [ (mod1Mask, n) | n <- [xK_1 .. xK_9] ]
	 ++
	 [ (mod1Mask .|. shiftMask, n) | n <- [xK_1 .. xK_9] ]

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
              $   tall
              ||| dishes
              ||| tabbed shrinkText tabbedLayout
              where tall    = Tall nmaster delta ratio
                    nmaster = 1
                    ratio   = 1 / 2
                    delta   = 3 / 100
                    dishes  = renamed [Replace "Wide"] (Tall 0 delta ratio)

myConfig xmproc = ewmh $ desktopConfig
    { terminal           = "gnome-terminal" -- "alacritty" -- "urxvt"
    , modMask            = mod1Mask
    , layoutHook         = myLayoutHook
    , normalBorderColor  = bg1
    , focusedBorderColor = darkBlue
    , manageHook         = manageHook defaultConfig <+> manageDocks
    , startupHook        = setWMName "LG3D"
    , logHook            = dynamicLogWithPP $ myPP xmproc
    } `additionalKeys` myKeys
    `removeKeys` rmKeys
