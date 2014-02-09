-----------------------
-- AwesomeWM widgets --
--   <tdy@gmx.com>   --
-----------------------

vicious = require("vicious")

graphwidth  = 120
graphheight = 20
pctwidth    = 40
netwidth    = 100

-- {{{ SPACERS
spacer = widget({ type = "textbox" })
spacer.text = " "
tab = widget({ type = "textbox" })
tab.text = "       "
volspacer = widget({ type = "textbox" })
volspacer.text = " "
-- }}}

-- {{{ PROCESSOR
-- Cache
vicious.cache(vicious.widgets.cpu)
vicious.cache(vicious.widgets.cpuinf)

-- Core 0 freq
cpufreq = widget({ type = "textbox" })
vicious.register(cpufreq, vicious.widgets.cpuinf,
  function(widget, args)
    return string.format("<span color='" .. beautiful.fg_em .. "'>cpu</span>%1.1fGHz", args["{cpu0 ghz}"])
  end, 3000)

-- Core 0 graph
cpugraph0 = awful.widget.graph()
cpugraph0:set_width(graphwidth):set_height(graphheight)
cpugraph0:set_background_color(beautiful.bg_widget)
cpugraph0:set_border_color(nil)
cpugraph0:set_border_color(beautiful.bg_widget)
cpugraph0:set_gradient_colors({
  beautiful.fg_end_widget,
  beautiful.fg_end_widget,
  beautiful.fg_center_widget
})
cpugraph0:set_gradient_angle(0)
vicious.register(cpugraph0, vicious.widgets.cpu, "$2")

-- Core 0 %
cpupct0 = widget({ type = "textbox" })
cpupct0.width = pctwidth
vicious.register(cpupct0, vicious.widgets.cpu, "$2%", 2)

-- Core 1 graph
cpugraph1 = awful.widget.graph()
cpugraph1:set_width(graphwidth):set_height(graphheight)
cpugraph1:set_background_color(beautiful.bg_widget)
cpugraph1:set_border_color(nil)
cpugraph1:set_border_color(beautiful.bg_widget)
cpugraph1:set_gradient_colors({
  beautiful.fg_end_widget,
  beautiful.fg_end_widget,
  beautiful.fg_center_widget
})
cpugraph1:set_gradient_angle(0)
vicious.register(cpugraph1, vicious.widgets.cpu, "$3")

-- Core 1 %
cpupct1 = widget({ type = "textbox" })
cpupct1.width = pctwidth
vicious.register(cpupct1, vicious.widgets.cpu, "$3%", 2)

-- Core 2 graph
cpugraph2 = awful.widget.graph()
cpugraph2:set_width(graphwidth):set_height(graphheight)
cpugraph2:set_background_color(beautiful.bg_widget)
cpugraph2:set_border_color(nil)
cpugraph2:set_border_color(beautiful.bg_widget)
cpugraph2:set_gradient_colors({
  beautiful.fg_end_widget,
  beautiful.fg_end_widget,
  beautiful.fg_center_widget
})
cpugraph2:set_gradient_angle(0)
vicious.register(cpugraph2, vicious.widgets.cpu, "$4")

-- Core 2 %
cpupct2 = widget({ type = "textbox" })
cpupct2.width = pctwidth
vicious.register(cpupct2, vicious.widgets.cpu, "$4%", 2)

-- }}}

-- {{{ MEMORY
-- Cache
vicious.cache(vicious.widgets.mem)

-- Ram used
memused = widget({ type = "textbox" })
vicious.register(memused, vicious.widgets.mem,
  "<span color='" .. beautiful.fg_em .. "'>ram</span>$2MB", 5)

-- Ram bar
membar = awful.widget.progressbar()
membar:set_vertical(false):set_width(graphwidth):set_height(graphheight)
membar:set_ticks(false):set_ticks_size(2)
membar:set_background_color(beautiful.bg_widget)
membar:set_border_color(nil)
membar:set_gradient_colors({
  beautiful.fg_widget,
  beautiful.fg_center_widget,
  beautiful.bg_widget
})
vicious.register(membar, vicious.widgets.mem, "$1", 13)

-- Ram %
mempct = widget({ type = "textbox" })
mempct.width = pctwidth
vicious.register(mempct, vicious.widgets.mem, "$1%", 5)

-- Swap used
swapused = widget({ type = "textbox" })
vicious.register(swapused, vicious.widgets.mem,
  "<span color='" .. beautiful.fg_em .. "'>swap</span>$6MB", 5)

-- Swap bar
swapbar = awful.widget.progressbar()
swapbar:set_vertical(false):set_width(graphwidth):set_height(graphheight)
swapbar:set_ticks(false):set_ticks_size(2)
swapbar:set_background_color(beautiful.bg_widget)
swapbar:set_border_color(nil)
swapbar:set_gradient_colors({
  beautiful.fg_widget,
  beautiful.fg_center_widget,
  beautiful.bg_widget
})
vicious.register(swapbar, vicious.widgets.mem, "$5", 13)

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

-- Root bar
rootfsbar = awful.widget.progressbar()
rootfsbar:set_vertical(false):set_width(graphwidth):set_height(graphheight)
rootfsbar:set_ticks(false):set_ticks_size(2)
rootfsbar:set_background_color(beautiful.bg_widget)
rootfsbar:set_border_color(nil)
rootfsbar:set_gradient_colors({
  beautiful.fg_widget,
  beautiful.fg_center_widget,
  beautiful.bg_widget
})
vicious.register(rootfsbar, vicious.widgets.fs, "${/ used_p}", 97)

-- Root %
rootfspct = widget({ type = "textbox" })
rootfspct.width = pctwidth
vicious.register(rootfspct, vicious.widgets.fs, "${/ used_p}%", 97)
-- }}}

-- {{{ NETWORK
-- Cache
vicious.cache(vicious.widgets.net)

-- TX
txwidget = widget({ type = "textbox" })
vicious.register(txwidget, vicious.widgets.net,
  "<span color='" .. beautiful.fg_em .. "'>up</span>${eth0 tx_mb}MB", 19)

-- Up graph
upgraph = awful.widget.graph()
upgraph:set_width(graphwidth):set_height(graphheight)
upgraph:set_background_color(beautiful.bg_widget)
upgraph:set_border_color(nil)
upgraph:set_gradient_colors({
  beautiful.fg_end_widget,
  beautiful.fg_end_widget,
  beautiful.fg_center_widget
})
upgraph:set_gradient_angle(0)
vicious.register(upgraph, vicious.widgets.net, "${eth0 up_kb}")

-- Up speed
upwidget = widget({ type = "textbox" })
upwidget.width = netwidth
vicious.register(upwidget, vicious.widgets.net, "${eth0 up_kb}k/s", 2)

-- RX
rxwidget = widget({ type = "textbox" })
vicious.register(rxwidget, vicious.widgets.net,
  "<span color='" .. beautiful.fg_em .. "'>down</span>${eth0 rx_mb}MB", 17)

-- Down graph
downgraph = awful.widget.graph()
downgraph:set_width(graphwidth):set_height(graphheight)
downgraph:set_background_color(beautiful.bg_widget)
downgraph:set_border_color(nil)
downgraph:set_gradient_colors({
  beautiful.fg_end_widget,
  beautiful.fg_end_widget,
  beautiful.fg_center_widget
})
downgraph:set_gradient_angle(0)
vicious.register(downgraph, vicious.widgets.net, "${eth0 down_kb}")

-- Down speed
downwidget = widget({ type = "textbox" })
downwidget.width = netwidth
vicious.register(downwidget, vicious.widgets.net, "${eth0 down_kb}k/s", 2)
-- }}}

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
