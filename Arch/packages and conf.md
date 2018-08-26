- **Connect to Wireless**

```bash
$ nmcli device wifi rescan; nmcli device wifi list
$ nmcli device wifi connect <SSID> password <password>
```

- **Setting up the system**

```bash
$ sudo pacman -S \
    grub \
    dosfstools \
    efibootmgr \
    os-prober \
    wpa_supplicant \
    bash-completion \
    vim 
    networkmanager \
    thunar \
    pulseaudio-alsa \
    alsa-utils
    
```
- **Setting up essential tools**

```bash

$ sudo pacman -S \
    i3 \
    dmenu \
    xorg\
    xorg-xinit \
    w3m \
    irssi \
    xdg-user-dirs \
    tmux \
    mlocate \
    terminator \
    mpv \
    rhythmbox \
    firefox \
    noto-fonts \
    ttf-dejavu \
    ttf-liberation \
    feh \
    emacs \
    clang \
    python-pip \
    python-virtualenv \
    git \
    lxappearance \
    libreoffice-still \
    pavucontrol \
    dunst \
    autoconf \
    automake \
    llvm \
    splint \
    pkgconf \
    python-jedi \
    vala \
    gdb \
    valgrind \
    cmake \
    yasm \
    tmux \
    make \
    patch \
    ccache \
    rsync \
    libnotify \
    pulsemixer \
    rofi \
    gvfs-mtp \
    thunar-volman \
    thunar-archive-plugin \
    thunar-media-tags-plugin \
    gnome-themes-standard \
    gimp \
    android-file-transfer \
    powerline \
    powerline-fonts \
    file-roller \
    evince \
    tumbler \
    libopenraw \
    gpick \
    scrot \
    ntfs-g \
    galculator
    

/* You may want to use rofi instead of dmenu */
```

- **Allowing file manager to mount drives:**

By default, file managers do not allow users to mount partitions or external drive except that is predefined in `/etc/fstab`.
For allowing mounting internal or external drives, you need to create a polkit rule.

Create a file in the location: 
`sudo vi /etc/polkit-1/rules.d/allow-mount-internal.rules`

and write below:

```bash
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
         action.id == "org.freedesktop.udisks.filesystem-mount-system-internal") &&
        subject.local && subject.active && subject.isInGroup("wheel"))
    {
            return polkit.Result.YES;
    }
});
```

and reboot. Done!

- **Notification daemon set display**

```bash
$ vi .xinitrc````

```bash

#!/bin/bash
exec i3

systemctl --user import-environment DISPLAY XAUTHORITY
if command -v dbus-update-activation-environment > /dev/null 2>&1 ; then
         dbus-update-activation-environment DISPLAY XAUTHORITY
fi

```

- **i3config**

`$ vi ~/.config/i3/config`

```bash

# Hide Borders
hide_edge_borders none

# Configure border style <normal|1pixel|pixel xx|none|pixel>
#new_window pixel 2
#new_float normal 2
# default_border normal|none|pixel
default_border pixel 2

# force floating for all new windows
for_window [class="[.]*"] floating enable
# NOTE use `xprop` to find details of open windows
# Generic windows
for_window [window_role="pop-up"] floating enable
#for_window [window_role="bubble"] floating enable
#for_window [window_role="task_dialog"] floating enable
#for_window [window_role="Preferences"] floating enable
#for_window [window_type="dialog"] floating enable
#for_window [window_type="menu"] floating enable

# move floating windows with keys
bindsym $mod+m mode "move" focus floating
mode "move" {
    bindsym $mod+Tab focus right

    bindsym Left  move left
    bindsym Down  move down
    bindsym Up    move up
    bindsym Right move right

    bindsym h     move left
    bindsym j     move down
    bindsym k     move up
    bindsym l     move right

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

# change borders
bindsym $mod+u border none
bindsym $mod+y border pixel 1
bindsym $mod+n border normal

set $mod Mod4
bindsym $mod+r mode "resize"

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
font pango:Iosevka Term Medium, DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
#bindsym $mod+Shift+q kill
bindsym $mod+Q kill

# start dmenu (a program launcher)
#bindsym $mod+d exec dmenu_run
bindsym $mod+a exec rofi -show
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+semicolon focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+j move left
bindsym $mod+Shift+k move down
bindsym $mod+Shift+l move up
bindsym $mod+Shift+semicolon move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+p focus parent

# focus the child container
#bindsym $mod+p focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

bindsym $mod+Prior workspace prev
bindsym $mod+Next workspace next
# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload the configuration file
bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}


# Start i3bar to display a workspace bar (plus the system information i3status if available)
bar {
    i3bar_command i3bar
    status_command i3status
    position bottom

## please set your primary output first. Example: 'xrandr --output eDP1 --primary'
#   tray_output primary
#   tray_output eDP1

    bindsym button4 nop
    bindsym button5 nop
    font xft:Sans 10
    strip_workspace_numbers yes

    colors {
	background #263238
        statusline #F9FAF9
        separator  #454947

    #                      border  backgr. text
        focused_workspace  #F9FAF9 #16a085 #292F34
        active_workspace   #595B5B #353836 #FDF6E3
        inactive_workspace #595B5B #283339 #EEE8D5
        binding_mode       #16a085 #2C2C2C #F9FAF9
        urgent_workspace   #16a085 #FDF6E3 #E5201D
    }
}

# Set your wallpaper
exec --no-startup-id feh --bg-scale /home/$USER/.config/i3/wallpaper/buildings.jpg

# Notification daemon startup
exec --no-startup-id systemctl --user import-environment DISPLAY XAUTHORITY
exec --no-startup-id systemctl --user set-environment DISPLAY=:0

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec amixer -q set Master 5%+
bindsym XF86AudioLowerVolume exec amixer -q set Master 5%-
bindsym XF86AudioMute exec amixer -q set Master toggle

# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness

# Touchpad controls
#bindsym XF86TouchpadToggle exec /some/path/toggletouchpad.sh # toggle touchpad
#The script toggletouchpad.sh for toggling your touchpad should have following content:
#
##!/bin/bash
#if synclient -l | grep "TouchpadOff .*=.*0" ; then
#    synclient TouchpadOff=1 ;
#else
#    synclient TouchpadOff=0 ;
#fi


# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous

client.focused          #555555 #555555 #ffffff #2e9ef4   #CC0000
client.focused_inactive #333333 #5f676a #ffffff #584e50   #AB346E
client.unfocused        #333333 #222222 #888888 #292d2e   #222222
client.urgent           #2f343a #900000 #ffffff #900000   #900000
client.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c
client.background       #ffffff

# HiDPI
# Command xrandr will show up all resolutions
# DPI Set
#exec xrandr --dpi 220
# Resolution
#xrandr --output VGA-1 --mode 1920x1080
#
```
** Setting up i3status statusbar**

` $ vi .config/i3status/config `

```bash

# github.com/rafi i3status config

# i3status configuration file
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!
#
# i3status configuration file.
# see "man i3status" for documentation.

# It is important that this file is edited as UTF-8.
# The following line should contain a sharp s:
# ß
# If the above line is not correctly displayed, fix your editor first!

general {
	colors = true
	color_good = "#BBBBBB"
	color_bad = "#CC1616"
	color_degraded = "#55858E"
	interval = 2
}

order += "volume master"
order += "load"
order += "cpu_usage"
#order += "cpu_temperature 0"
order += "cpu_temperature 1"
order += "cpu_temperature 2"
#order += "cpu_temperature 3"
order += "disk /"
order += "disk /media/media"
order += "ethernet enp0s29u1u5"
order += "wireless wlp0s26u1u1"
order += "tztime local"
order += "tztime Asia/Kolkata"
#order += "ipv6"
#order += "run_watch DHCP"
#order += "run_watch VPN"


volume master {
	format = " ♪: %volume  "
  format_muted = " ♪: %volume"
	device = "default"
	mixer = "Master"
	mixer_idx = 0
	# termsyn font
}

load {
	# termsyn font
	format = " %1min"
}

cpu_usage {
	format = "%usage "
}

cpu_temperature 0 {
	format = " ± %degrees°"
	path = "/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input"
	max_threshold = 95
}

cpu_temperature 1 {
	format = "%degrees°"
	path = "/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp2_input"
	max_threshold = 95
}

cpu_temperature 2 {
	format = "%degrees°"
	path = "/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp3_input"
	max_threshold = 95
}

cpu_temperature 3 {
	format = "%degrees° "
	path = "/sys/devices/platform/coretemp.0/hwmon/hwmon1/temp4_input"
	max_threshold = 95
}

disk "/" {
	format = " ¨ %avail:/ "
}

disk "/media/media" {
	format = " ¨ %avail:m "
}

run_watch DHCP {
	pidfile = "/var/run/dhclient*.pid"
}

run_watch VPN {
	pidfile = "/var/run/vpnc/pid"
}

tztime local {
#	format = " %h-%d %H:%M ☰ "
	# termsyn font
	format = " %h-%d É %H:%M "
}

wireless wlp0s26u1u1 {
        format_up = "⇝ WiFi Connected: (%bitrate)"
        format_down = "↛ WiFi Down"
}

ethernet enp0s29u1u5 {
        # if you use %speed, i3status requires the cap_net_admin capability
        format_up = "⇌ Ethernet Connected"
        format_down = "↛ Ethernet Down"
}

battery 0 {
        format = "%status %percentage %remaining %emptytime"
        format_down = "No battery"
        status_chr = "⚇ CHR"
        status_bat = "⚡ BAT"
        status_full = "☻ FULL"
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
}

run_watch DHCP {
        pidfile = "/var/run/dhclient*.pid"
}

run_watch VPNC {
        # file containing the PID of a vpnc process
        pidfile = "/var/run/vpnc/pid"
}

path_exists VPN {
        # path exists when a VPN tunnel launched by nmcli/nm-applet is active
        path = "/proc/sys/net/ipv4/conf/tun0"
}

tztime local {
        format = "%Y-%m-%d %H:%M:%S"
}

tztime Amsterdam {
        format = "%Y-%m-%d %H:%M:%S %Z"
        timezone = "Asia/Kolkata"
}

load {
        format = "%5min"
}

cpu_temperature 0 {
        format = "T: %degrees °C"
        path = "/sys/devices/platform/coretemp.0/temp1_input"
}

disk "/" {
        format = "%free"
```

- **Setting up dunst notification-daemon**

` $ vi .config/dunst/dunstrc `

```bash

[global]
    ### Display ###

    # Which monitor should the notifications be displayed on.
    monitor = 0

    # Display notification on focused monitor.  Possible modes are:
    #   mouse: follow mouse pointer
    #   keyboard: follow window with keyboard focus
    #   none: don't follow anything
    #
    # "keyboard" needs a window manager that exports the
    # _NET_ACTIVE_WINDOW property.
    # This should be the case for almost all modern window managers.
    #
    # If this option is set to mouse or keyboard, the monitor option
    # will be ignored.
    follow = mouse

    # The geometry of the window:
    #   [{width}]x{height}[+/-{x}+/-{y}]
    # The geometry of the message window.
    # The height is measured in number of notifications everything else
    # in pixels.  If the width is omitted but the height is given
    # ("-geometry x2"), the message window expands over the whole screen
    # (dmenu-like).  If width is 0, the window expands to the longest
    # message displayed.  A positive x is measured from the left, a
    # negative from the right side of the screen.  Y is measured from
    # the top and down respectively.
    # The width can be negative.  In this case the actual width is the
    # screen width minus the width defined in within the geometry option.
    geometry = "300x5-30+20"

    # Show how many messages are currently hidden (because of geometry).
    indicate_hidden = yes

    # Shrink window if it's smaller than the width.  Will be ignored if
    # width is 0.
    shrink = no

    # The transparency of the window.  Range: [0; 100].
    # This option will only work if a compositing window manager is
    # present (e.g. xcompmgr, compiz, etc.).
    transparency = 0

    # The height of the entire notification.  If the height is smaller
    # than the font height and padding combined, it will be raised
    # to the font height and padding.
    notification_height = 0

    # Draw a line of "separator_height" pixel height between two
    # notifications.
    # Set to 0 to disable.
    separator_height = 2

    # Padding between text and separator.
    padding = 8

    # Horizontal padding.
    horizontal_padding = 8

    # Defines width in pixels of frame around the notification window.
    # Set to 0 to disable.
    frame_width = 3

    # Defines color of the frame around the notification window.
    frame_color = "#aaaaaa"

    # Define a color for the separator.
    # possible values are:
    #  * auto: dunst tries to find a color fitting to the background;
    #  * foreground: use the same color as the foreground;
    #  * frame: use the same color as the frame;
    #  * anything else will be interpreted as a X color.
    separator_color = frame

    # Sort messages by urgency.
    sort = yes

    # Don't remove messages, if the user is idle (no mouse or keyboard input)
    # for longer than idle_threshold seconds.
    # Set to 0 to disable.
    # Transient notifications ignore this setting.
    idle_threshold = 120

    ### Text ###

    font = iosevka term  9

    # The spacing between lines.  If the height is smaller than the
    # font height, it will get raised to the font height.
    line_height = 0

    # Possible values are:
    # full: Allow a small subset of html markup in notifications:
    #        <b>bold</b>
    #        <i>italic</i>
    #        <s>strikethrough</s>
    #        <u>underline</u>
    #
    #        For a complete reference see
    #        <http://developer.gnome.org/pango/stable/PangoMarkupFormat.html>.
    #
    # strip: This setting is provided for compatibility with some broken
    #        clients that send markup even though it's not enabled on the
    #        server. Dunst will try to strip the markup but the parsing is
    #        simplistic so using this option outside of matching rules for
    #        specific applications *IS GREATLY DISCOURAGED*.
    #
    # no:    Disable markup parsing, incoming notifications will be treated as
    #        plain text. Dunst will not advertise that it has the body-markup
    #        capability if this is set as a global setting.
    #
    # It's important to note that markup inside the format option will be parsed
    # regardless of what this is set to.
    markup = full

    # The format of the message.  Possible variables are:
    #   %a  appname
    #   %s  summary
    #   %b  body
    #   %i  iconname (including its path)
    #   %I  iconname (without its path)
    #   %p  progress value if set ([  0%] to [100%]) or nothing
    #   %n  progress value if set without any extra characters
    #   %%  Literal %
    # Markup is allowed
    format = "<b>%s</b>\n%b"

    # Alignment of message text.
    # Possible values are "left", "center" and "right".
    alignment = left

    # Show age of message if message is older than show_age_threshold
    # seconds.
    # Set to -1 to disable.
    show_age_threshold = 60

    # Split notifications into multiple lines if they don't fit into
    # geometry.
    word_wrap = yes

    # When word_wrap is set to no, specify where to ellipsize long lines.
    # Possible values are "start", "middle" and "end".
    ellipsize = middle

    # Ignore newlines '\n' in notifications.
    ignore_newline = no

    # Merge multiple notifications with the same content
    stack_duplicates = true

    # Hide the count of merged notifications with the same content
    hide_duplicate_count = false

    # Display indicators for URLs (U) and actions (A).
    show_indicators = yes

    ### Icons ###

    # Align icons left/right/off
    icon_position = off

    # Scale larger icons down to this size, set to 0 to disable
    max_icon_size = 32

    # Paths to default icons.
    icon_path = /usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/

    ### History ###

    # Should a notification popped up from history be sticky or timeout
    # as if it would normally do.
    sticky_history = yes

    # Maximum amount of notifications kept in history
    history_length = 20

    ### Misc/Advanced ###

    # dmenu path.
    dmenu = /usr/bin/dmenu -p dunst:

    # Browser for opening urls in context menu.
    browser = /usr/bin/firefox -new-tab

    # Always run rule-defined scripts, even if the notification is suppressed
    always_run_script = true

    # Define the title of the windows spawned by dunst
    title = Dunst

    # Define the class of the windows spawned by dunst
    class = Dunst

    # Print a notification on startup.
    # This is mainly for error detection, since dbus (re-)starts dunst
    # automatically after a crash.
    startup_notification = false

    ### Legacy

    # Use the Xinerama extension instead of RandR for multi-monitor support.
    # This setting is provided for compatibility with older nVidia drivers that
    # do not support RandR and using it on systems that support RandR is highly
    # discouraged.
    #
    # By enabling this setting dunst will not be able to detect when a monitor
    # is connected or disconnected which might break follow mode if the screen
    # layout changes.
    force_xinerama = false

# Experimental features that may or may not work correctly. Do not expect them
# to have a consistent behaviour across releases.
[experimental]
    # Calculate the dpi to use on a per-monitor basis.
    # If this setting is enabled the Xft.dpi value will be ignored and instead
    # dunst will attempt to calculate an appropriate dpi value for each monitor
    # using the resolution and physical size. This might be useful in setups
    # where there are multiple screens with very different dpi values.
    per_monitor_dpi = false

[shortcuts]

    # Shortcuts are specified as [modifier+][modifier+]...key
    # Available modifiers are "ctrl", "mod1" (the alt-key), "mod2",
    # "mod3" and "mod4" (windows-key).
    # Xev might be helpful to find names for keys.

    # Close notification.
    close = ctrl+space

    # Close all notifications.
    close_all = ctrl+shift+space

    # Redisplay last message(s).
    # On the US keyboard layout "grave" is normally above TAB and left
    # of "1". Make sure this key actually exists on your keyboard layout,
    # e.g. check output of 'xmodmap -pke'
    history = ctrl+grave

    # Context menu.
    context = ctrl+shift+period

[urgency_low]
    # IMPORTANT: colors have to be defined in quotation marks.
    # Otherwise the "#" and following would be interpreted as a comment.
    background = "#222222"
    foreground = "#888888"
    timeout = 10
    # Icon for notifications with low urgency, uncomment to enable
    #icon = /path/to/icon

[urgency_normal]
    background = "#285577"
    foreground = "#ffffff"
    timeout = 10
    # Icon for notifications with normal urgency, uncomment to enable
    #icon = /path/to/icon

[urgency_critical]
    background = "#900000"
    foreground = "#ffffff"
    frame_color = "#ff0000"
    timeout = 0
    # Icon for notifications with critical urgency, uncomment to enable
    #icon = /path/to/icon

# Every section that isn't one of the above is interpreted as a rules to
# override settings for certain messages.
# Messages can be matched by "appname", "summary", "body", "icon", "category",
# "msg_urgency" and you can override the "timeout", "urgency", "foreground",
# "background", "new_icon" and "format".
# Shell-like globbing will get expanded.
#
# SCRIPTING
# You can specify a script that gets run when the rule matches by
# setting the "script" option.
# The script will be called as follows:
#   script appname summary body icon urgency
# where urgency can be "LOW", "NORMAL" or "CRITICAL".
#
# NOTE: if you don't want a notification to be displayed, set the format
# to "".
# NOTE: It might be helpful to run dunst -print in a terminal in order
# to find fitting options for rules.

#[espeak]
#    summary = "*"
#    script = dunst_espeak.sh

#[script-test]
#    summary = "*script*"
#    script = dunst_test.sh

#[ignore]
#    # This notification will not be displayed
#    summary = "foobar"
#    format = ""

#[history-ignore]
#    # This notification will not be saved in history
#    summary = "foobar"
#    history_ignore = yes

#[signed_on]
#    appname = Pidgin
#    summary = "*signed on*"
#    urgency = low
#
#[signed_off]
#    appname = Pidgin
#    summary = *signed off*
#    urgency = low
#
#[says]
#    appname = Pidgin
#    summary = *says*
#    urgency = critical
#
#[twitter]
#    appname = Pidgin
#    summary = *twitter.com*
#    urgency = normal
#
# vim: ft=cfg

```

- ** Seting up X fonts**

` vi .config/fonts.conf`

```bash
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
 <match target="font">
  <edit mode="assign" name="rgba">
   <const>rgb</const>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="hinting">
   <bool>true</bool>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="hintstyle">
   <const>hintslight</const>
  </edit>
 </match>
 <match target="font">
  <edit mode="assign" name="antialias">
   <bool>true</bool>
  </edit>
 </match>
  <match target="font">
    <edit mode="assign" name="lcdfilter">
      <const>lcddefault</const>
    </edit>
  </match>
</fontconfig>
```

- Setting up terminator**

` $ vi .config/terminator/config `

```bash

[global_config]
[keybindings]
[layouts]
  [[default]]
    [[[child0]]]
      fullscreen = False
      last_active_term = 09a9ddc7-c090-46b0-8beb-758c3c8beadc
      last_active_window = True
      maximised = False
      order = 0
      parent = ""
      position = 151:271
      size = 870, 554
      title = fr0xk@eula47:~
      type = Window
    [[[terminal1]]]
      order = 0
      parent = child0
      profile = default
      type = Terminal
      uuid = 09a9ddc7-c090-46b0-8beb-758c3c8beadc
[plugins]
[profiles]
  [[default]]
    background_color = "#263238"
    background_darkness = 0.75
    background_type = transparent
    cursor_color = "#aaaaaa"
    font = Iosevka Term Medium 12
    foreground_color = "#a1b0b8"
    login_shell = True
    palette = "#073642:#dc322f:#859900:#b58900:#268bd2:#d33682:#1793d1:#eee8d5:#78909c:#cb4b16:#4caf50:#b58900:#2196f3:#e91e63:#e7f9fc:#fdf6e3"
    scrollback_infinite = True
    scrollbar_position = hidden
    show_titlebar = False
    use_system_font = False
```

- **Setting up Xresources**

` vi .Xresources `

```bash

!!! XDefaults
Xft.autohint: 0
Xft.antialias: 1
Xft.hinting: true
Xft.hintstyle: hintslight
Xft.dpi: 96
!! Xft.dpi: 220 // HiDPI
!! Also execute xrandr --dpi 220
Xft.rgba: rgb
Xft.lcdfilter: lcddefault

!!! URxvt config
urxvt.scrollBar: false
urxvt.letterSpace: -1
urxvt.saveLines: 1000000
URxvt.font: xft:Iosevka Term:Medium:size=12
URxvt.geometry: 114x28

!! For copy-pasta :D
! rxvt to other: middlw mouse
! others to rxvt: Shift+Insert | Ctrl+Alt+V fr VIM

!! Transparency
!(fake)
!URxvt*inheritPixmap: true
!urxvt*transparent: true
! (real)
!urxvt*depth: 32
!urxvt*background: rgba:0000/0000/0200/c800
!urxvt*shading: 10

!!! colorscheme
! special
*.foreground:   #A1B0B8
*.background:   #263238 
*.cursorColor:  #7ea2b4

! black
*.color0:       #161b1d
*.color8:       #5a7b8c

! red
*.color1:       #d22d72
*.color9:       #d22d72

! green
*.color2:       #568c3b
*.color10:      #568c3b

! yellow
*.color3:       #8a8a0f
*.color11:      #8a8a0f

! blue
*.color4:       #257fad
*.color12:      #257fad

! magenta
*.color5:       #5d5db1
*.color13:      #5d5db1

! cyan
*.color6:       #2d8f6f
*.color14:      #2d8f6f

! white
*.color7:       #7ea2b4
*.color15:      #ebf8ff
```
