-----------------------
-- AwesomeWM widgets --
--   <tdy@gmx.com>   --
-----------------------

vicious = require("vicious")

graphwidth  = 50
graphheight = 12
pctwidth    = 30
netwidth    = 100

-- {{{ SPACERS
spacer = widget({ type = "textbox" })
spacer.text = " "
tab = widget({ type = "textbox" })
tab.text = " :: "
volspacer = widget({ type = "textbox" })
volspacer.text = " "
-- }}}

-- {{{ PROCESSOR
-- Cache
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.cpuinf)

cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")

-- }}}

-- {{{ MEMORY
-- Cache
vicious.cache(vicious.widgets.mem)

-- Ram used
memused = widget({ type = "textbox" })
vicious.register(memused, vicious.widgets.mem,
  "<span color='" .. beautiful.fg_em .. "'>ram</span>$2MB", 5)

-- Ram %
mempct = widget({ type = "textbox" })
mempct.width = pctwidth
vicious.register(mempct, vicious.widgets.mem, "$1%", 5)

-- Swap used
swapused = widget({ type = "textbox" })
vicious.register(swapused, vicious.widgets.mem,
  "<span color='" .. beautiful.fg_em .. "'>swap</span>$6MB", 5)

-- Swap %
swappct = widget({ type = "textbox" })
swappct.width = pctwidth
vicious.register(swappct, vicious.widgets.mem, "$5%", 5)

-- {{{ FILESYSTEM
-- Cache
vicious.cache(vicious.widgets.fs)

-- Root used
rootfsused = widget({ type = "textbox" })
vicious.register(rootfsused, vicious.widgets.fs,
  "<span color='" .. beautiful.fg_em .. "'>sdd</span>${/ used_gb}GB", 97)

-- Root %
rootfspct = widget({ type = "textbox" })
rootfspct.width = pctwidth
vicious.register(rootfspct, vicious.widgets.fs, "${/ used_p}%", 97)
-- }}}

-- {{{ NETWORK
-- Cache
vicious.cache(vicious.widgets.net)

wlanwidget = widget({ type = "textbox" })
vicious.register(wlanwidget, vicious.widgets.net, '<span color="#CC9393">${wlan0 down_kb}k/s</span> <span color="#7F9F7F">${wlan0 up_kb}k/s</span>', 3)
ethwidget = widget({ type = "textbox" })
vicious.register(ethwidget, vicious.widgets.net, '<span color="#CC9393">${eth0 down_kb}k/s</span> <span color="#7F9F7F">${eth0 up_kb}k/s</span>', 3)

-- wifi
wifiwidget = widget({ type = "textbox" })
vicious.register(wifiwidget, vicious.widgets.wifi, '${ssid}', 3, "wlan0")

wifiicon = widget({ type = "imagebox" })
vicious.register(wifiicon, vicious.widgets.wifi,
    function (widget, args)
        link = args['{link}']
        -- wifiicon.visible = true  -- didnt help
        if link > 70 then
            wifiicon.image=image(beautiful.widget_wifi_hi)
        elseif link > 30 and link <= 70 then
            wifiicon.image=image(beautiful.widget_wifi_mid)
        elseif link > 0 and link <= 30 then
            wifiicon.image=image(beautiful.widget_wifi_low)
        else
            wifiicon.image=image(beautiful.widget_wifi_no)
        end
    end,
        3, "wlan0")

-- {{{ WEATHER
weather = widget({ type = "textbox" })
vicious.register(weather, vicious.widgets.weather,
  "<span color='" .. beautiful.fg_em .. "'>${sky}</span> @ ${tempf}°F on",
  1501, "XXXX")
weather:buttons(awful.util.table.join(awful.button({ }, 1,
  function() vicious.force({ weather }) end)))
-- }}}

-- {{{ VOLUME
-- Cache
vicious.cache(vicious.widgets.volume)

-- Icon
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)

-- Level bar
volbar = awful.widget.progressbar()
volbar:set_vertical(true):set_width(4):set_height(24)
volbar:set_ticks(false):set_ticks_size(1)
volbar:set_background_color(beautiful.bg_normal)
volbar:set_border_color(nil)
volbar:set_gradient_colors({
  beautiful.fg_center_widget,
  beautiful.fg_end_widget
})
vicious.register(volbar, vicious.widgets.volume, function(widget, args)
  if args[1] == 0 or args[2] ==  "♩" then
    volicon.image = image(beautiful.widget_mute)
  else
    volicon.image = image(beautiful.widget_vol)
  end
  return args[1]
end, 2, "Master")

-- Buttons
volbar.widget:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function() awful.util.spawn("amixer -q set Master toggle", false) end),
  awful.button({ }, 4,
    function() awful.util.spawn("amixer -q set Master 3+% unmute", false) end),
  awful.button({ }, 5,
    function() awful.util.spawn("amixer -q set Master 3-% unmute", false) end)
))
volicon:buttons(volbar.widget:buttons())
volspacer:buttons(volbar.widget:buttons())
-- }}}

-- {{{ BATTERY
-- Battery attributes
bat_state  = ""
bat_charge = 0
bat_time   = 0
blink      = true

-- Icon
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_batfull)

-- Charge bar
batbar = awful.widget.progressbar()
batbar:set_vertical(true):set_width(4):set_height(24)
batbar:set_ticks(false):set_ticks_size(1)
batbar:set_background_color(beautiful.bg_normal)
batbar:set_border_color(nil)
batbar:set_gradient_colors({
  beautiful.fg_center_widget,
  beautiful.fg_end_widget
})
vicious.register(batbar, vicious.widgets.bat, function(widget, args)
  bat_state  = args[1]
  bat_charge = args[2]
  bat_time   = args[3]

  if args[1] == "-" then
    if bat_charge > 80 then
      baticon.image = image(beautiful.widget_batfull)
    elseif bat_charge > 30 then
      baticon.image = image(beautiful.widget_batmed)
    elseif bat_charge > 10 then
      baticon.image = image(beautiful.widget_batlow)
    else
      baticon.image = image(beautiful.widget_batempty)
    end
  else
    baticon.image = image(beautiful.widget_ac)
    if args[1] == "+" then
      blink = not blink
      if blink then
        baticon.image = image(beautiful.widget_acblink)
      end
    end
  end

  return bat_charge
end, nil, "BAT0")

-- Buttons
function popup_bat()
  local state = ""
  if bat_state == "=" then
    state = "Full"
  elseif bat_state == "=" then
    state = "Charged"
  elseif bat_state == "+" then
    state = "Charging"
  elseif bat_state == "-" then
    state = "Discharging"
  else
    state = "Unknown"
  end

  naughty.notify { text = "Charge : " .. bat_charge .. "%\nState  : " .. state .. " (" .. bat_time .. ")", timeout = 5, hover_timeout = 0.5 }
end
batbar.widget:buttons(awful.util.table.join(awful.button({ }, 1, popup_bat)))
baticon:buttons(batbar.widget:buttons())
-- }}}
