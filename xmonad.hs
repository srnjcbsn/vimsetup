import           XMonad
import           XMonad.Config.Desktop
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Tabbed
import           XMonad.Util.Themes
import XMonad.Util.Run (spawnPipe, hPutStrLn)

-- main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ myConfig xmproc

myBar = "xmobar"
myPP xmproc = xmobarPP { ppOutput = hPutStrLn xmproc
                       , ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" 
                       }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myLayoutHook =   avoidStruts
              $   tiled
              ||| tabbed shrinkText (theme wfarrTheme)
              where tiled   = Tall nmaster delta ratio
                    nmaster = 1
                    ratio   = 1 / 2
                    delta   = 3 / 100

myConfig xmproc = desktopConfig
    { terminal    = "urxvt"
    , modMask     = mod1Mask
    , layoutHook  = myLayoutHook
    , manageHook  = manageHook defaultConfig <+> manageDocks
    , startupHook = setWMName "LG3D"
    , logHook     = dynamicLogWithPP $ myPP xmproc
    }
