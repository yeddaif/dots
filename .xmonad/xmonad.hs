-- ## Modules ## -------------------------------------------------------------------

import Control.Monad
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid
import System.Exit
import XMonad
-- Xmonad Prompt

import XMonad.Config.Azerty
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Fullscreen
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Prompt
import XMonad.Prompt.Shell
import qualified XMonad.StackSet as W
import XMonad.Util.SpawnOnce
-- For Media control
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Actions.MouseResize


-- Prompt def
mydrun =
  def
    { font = "xft:JetBrainsMono Medium:size=10",
      bgColor = "#07273b",
      fgColor = "#ffffff",
      fgHLight = "#ffffff",
      bgHLight = "#3b0455",
      borderColor = "#10141c",
      position = Top,
      height = 23,
      historySize = 100,
      defaultText = "",
      showCompletionOnTab = True
    }

-- ## Startup hook ## ---------------------------------------------------------------
myStartupHook = do spawn "bash ~/.xmonad/autostart"

-- ## Settings ## -------------------------------------------------------------------

-- focus follows the mouse pointer
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- clicking on a window to focus
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels
myBorderWidth = 3

-- Border colors for focused & unfocused windows
normBord = "#4c566a"

focdBord = "#5e81ac"

-- modMask : modkey you want to use
-- mod1Mask : left alt Key
-- mod4Mask : Windows or Super Key
myModMask = mod4Mask

-- Workspaces (ewmh)
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7"]

-- ## Key Bindings ## -------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = super}) =
  M.fromList $
    -- Close focused window
    [ ((super, xK_c), kill),
      ((super, xK_Return), spawn "alacritty"),
      ((super, xK_Escape), spawn "xkill"),
      ((super, xK_space),  spawn "rofi -show drun" ),
      ((super, xK_s),   prompt "scripts/search" mydrun),
      ((super, xK_d), spawn "pcmanfm" ),
      -- Window Manager Specific -----------------------------------------

      -- Resize viewed windows to the correct size
      ((super, xK_r), refresh),
      -- Push window back into tiling
      ((super, xK_t), withFocused $ windows . W.sink),
      -- Rotate through the available layout algorithms
      ((super, xK_Tab ), sendMessage NextLayout),
      --  Reset the layouts on the current workspace to default
      ((super .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Move focus to the next window
      ((super, xK_Left), windows W.focusDown),
      -- Move focus to the previous window
      ((super, xK_Right), windows W.focusUp),
      -- Swap the focused window with the next window
      ((super .|. shiftMask, xK_Left), windows W.swapDown),
      -- Swap the focused window with the previous window
      ((super .|. shiftMask, xK_Right), windows W.swapUp),
      -- Shrink the master area
      ((super .|. controlMask, xK_Left), sendMessage Shrink),
      -- Expand the master area
      ((super .|. controlMask, xK_Right), sendMessage Expand),
      -- Restart xmonad
      ((controlMask .|. shiftMask, xK_r), spawn "xmonad --recompile && notify-send 'done' && xmonad --restart"),
      -- Quit xmonad
      ((controlMask .|. shiftMask, xK_q), spawn "pkill -KILL -u $USER")
      --MULTIMEDIA KEYS

      -- Mute volumea
      , ((0, xF86XK_AudioMute), spawn "pamixer -t")

      -- Decrease volume
      , ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 5%")

      -- Increase brightness
      , ((0, xF86XK_MonBrightnessUp),  spawn "brightnessctl s 5%+")

      -- Decrease brightness
      , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5%-")

      , ((0, xF86XK_AudioPlay), spawn  "mpc toggle")
      , ((0, xF86XK_AudioNext), spawn  "mpc next")
      , ((0, xF86XK_AudioPrev), spawn  "mpc prev")
      , ((0, xF86XK_AudioStop), spawn  "mpc stop")
    ]
      ++
      -- Workspace Specific ---------------------------------------------------------------

      -- mod-[1..9], Switch to workspace N
      -- mod-shift-[1..9], Move client to workspace N
      [ ((m .|. super, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_ampersand, xK_eacute, xK_quotedbl, xK_apostrophe, xK_parenleft, xK_minus, xK_egrave, xK_underscore, xK_ccedilla, xK_agrave],
          (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
      ]

-- ## Layouts ## -------------------------------------------------------------------------
myLayout = avoidStruts (tiled ||| Mirror tiled ||| noBorders Full)
  where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

-- ## Window rules ## --------------------------------------------------------------------
myManageHook =
  composeAll . concat $
    [ [isDialog --> doCenterFloat],
      [className =? c --> doCenterFloat | c <- myCFloats],
      [title =? t --> doCenterFloat | t <- myTFloats],
      [resource =? r --> doFloat | r <- myRFloats],
      [resource =? i --> doIgnore | i <- myIgnores],
      [className =? "mpv" --> viewShift "5"],
      [className =? "anbox" --> sizedSpwan],
      [className =? "kitty" --> sizedSpwan]
    ]
  where
    sizedSpwan = doRectFloat $ W.RationalRect 0.4 0.1 0.37 0.79
    -- in fractions of screen: x y w h
    viewShift = doF . liftM2 (.) W.greedyView W.shift
    myCFloats = ["Viewnior"]
    myTFloats = ["Downloads", "Save As...", "Getting Started"]
    myRFloats = []
    myIgnores = ["desktop_window"]

-- ## Event handling ## -------------------------------------------------------------------
myEventHook = ewmhDesktopsEventHook

myGaps = gaps [(L, 3), (R, 3), (U, 24), (D, 3)] $ spacingRaw False (Border 3 0 3 0) True (Border 0 3 0 3) True myLayout
-- ## Logging ## --------------------------------------------------------------------------
myLogHook = return ()

-- ## Main Function ## --------------------------------------------------------------------

-- Run xmonad with all the configs we set up.
main = xmonad $ fullscreenSupport $ docks $ ewmh defaults

defaults =
  def
    { -- configs
      focusFollowsMouse = myFocusFollowsMouse,
      clickJustFocuses = myClickJustFocuses,
      borderWidth = myBorderWidth,
      modMask = myModMask,
      workspaces = myWorkspaces,
      normalBorderColor = normBord,
      focusedBorderColor = focdBord,
      -- key bindings
      keys = myKeys,
      -- hooks, layouts
      manageHook = myManageHook,
      layoutHook = mouseResize $ windowArrange  myGaps ,
      handleEventHook = myEventHook,
      logHook = myLogHook,
      startupHook = myStartupHook
    }
