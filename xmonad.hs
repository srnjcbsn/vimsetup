import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Tabbed
import XMonad.Util.Themes

main = do
  xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myLayoutHook =   avoidStruts
              $   tiled
              ||| tabbed shrinkText (theme wfarrTheme)
              where tiled   = Tall nmaster delta ratio
                    nmaster = 1
                    ratio   = 1 / 2
                    delta   = 3 / 100

myConfig = desktopConfig
    { terminal   = "urxvt"
    , modMask    = mod1Mask
    , layoutHook = myLayoutHook
    , manageHook = manageHook defaultConfig <+> manageDocks
    }
