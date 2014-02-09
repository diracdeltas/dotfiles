-----------------------------
-- AwesomeWM configuration --
--      <tdy@gmx.com>      --
-----------------------------

require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")

-- {{{ Error handling
-- Startup
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
  title = "Oops, there were errors during startup!",
  text = awesome.startup_errors })
end

-- Runtime
do
  local in_error = false
  awesome.add_signal("debug::error", function (err)
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
    title = "Oops, an error happened!",
    text = err })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
beautiful.init(awful.util.getdir("config") .. "/themes/dust/theme.lua")
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod1"

-- Custom widgets
require("wi")
require("scratch")

-- Table of layouts to cover with awful.layout.inc (order matters)
layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max.fullscreen,
}
-- }}}

-- {{{ Naughty presets
naughty.config.default_preset.timeout = 5
naughty.config.default_preset.screen = 1
naughty.config.default_preset.position = "top_right"
naughty.config.default_preset.margin = 8
naughty.config.default_preset.gap = 1
naughty.config.default_preset.ontop = true
naughty.config.default_preset.font = "Monaco 12"
naughty.config.default_preset.icon = nil
naughty.config.default_preset.icon_size = 16
naughty.config.default_preset.fg = beautiful.fg_focus
naughty.config.default_preset.bg = beautiful.bg_focus
naughty.config.presets.normal.border_color = beautiful.border_focus
naughty.config.default_preset.border_width = 1
naughty.config.default_preset.hover_timeout = nil
-- }}}

-- {{{ Tags
tags = {
  names = { "1", "2", "3", "4", "5" },
  layouts = { layouts[1], layouts[2], layouts[3], layouts[4], layouts[1] }
}

for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layouts)
  awful.tag.setproperty(tags[s][1], "mwfact", 0.475)
  awful.tag.setproperty(tags[s][3], "mwfact", 0.475)
  awful.tag.setproperty(tags[s][4], "mwfact", 0.475)
  awful.tag.setproperty(tags[s][5], "mwfact", 0.475)
end
-- }}}

-- {{{ Menu
myawesomemenu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
  { "awesome", myawesomemenu, beautiful.awesome_icon },
  { "open terminal", terminal }
} })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
  menu = mymainmenu })
-- }}}

-- {{{ Wibox
mywibox = {}
mygraphbox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}

-- Clock
mytextclock = awful.widget.textclock(
  { align = "right" },
  " <span color='" .. beautiful.fg_em .. "'>%a %m/%d</span> @ %I:%M %p "
)

-- Systray
mysystray = widget({ type = "systray" })

-- Taglist
mytaglist.buttons = awful.util.table.join(
  awful.button({ }, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ }, 4, awful.tag.viewnext),
  awful.button({ }, 5, awful.tag.viewprev)
)

-- Tasklist
mytasklist.buttons = awful.util.table.join(
  awful.button({ }, 1, function (c)
      if not c:isvisible() then
        awful.tag.viewonly(c:tags()[1])
      end
      client.focus = c
      c:raise()
    end),
  awful.button({ }, 3, function ()
      if instance then
        instance:hide()
        instance = nil
      else
        instance = awful.menu.clients({ width=250 })
      end
    end),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
    end),
  awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end))

for s = 1, screen.count() do
  -- Prompt
  mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })

  -- Layout
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

  -- Taglist
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- Tasklist
  mytasklist[s] = awful.widget.tasklist(
    function(c) return awful.widget.tasklist.label.currenttags(c, s) end,
    mytasklist.buttons)

  -- Widgets
  mywibox[s] = awful.wibox({ position = "top", height = 16, screen = s })
  mywibox[s].widgets = {
    {
      mytaglist[s], spacer,
      mypromptbox[s],
      mylayoutbox[s], spacer,
      layout = awful.widget.layout.horizontal.leftright
    },
    volspacer, volbar.widget, volicon, spacer,
    batbar.widget, baticon, spacer,
    pacwidget, pacicon, spacer,
    mpdwidget, mpdicon, spacer,
    mytasklist[s],
    layout = awful.widget.layout.horizontal.rightleft
  }

  -- Graphs
  mygraphbox[s] = awful.wibox({ position = "bottom", height = 16, screen = s,
    border_width = 1, border_color = beautiful.bg_widget })
  mygraphbox[s].widgets = {
    mylauncher, spacer, spacer, spacer,
    cpufreq, cpugraph0.widget, cpupct0, cpugraph1.widget, cpupct1,
    cpugraph2.widget, cpupct2, tab,
    memused, membar.widget, mempct, tab,
    swapused, swapbar.widget, swappct, tab,
    rootfsused, rootfsbar.widget, rootfspct, tab,
    txwidget, upgraph.widget, upwidget, tab,
    rxwidget, downgraph.widget, downwidget, tab,
    layout = awful.widget.layout.horizontal.leftright,
    {
      s == 1 and mysystray or nil,
      mytextclock, weather,
      layout = awful.widget.layout.horizontal.rightleft
    }
  }
end
-- }}}

-- {{{ Keybindings
globalkeys = awful.util.table.join(
  awful.key({ modkey, }, "Left", awful.tag.viewprev ),
  awful.key({ modkey, }, "Right", awful.tag.viewnext ),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore),

  awful.key({ altkey, }, "Tab",
    function ()
      awful.client.focus.byidx( 1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ altkey, "Shift" }, "Tab",
    function ()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "w", function() mymainmenu:show({keygrabber=true}) end),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx( 1) end),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx( -1) end),
  awful.key({ modkey, }, "Tab", function() awful.screen.focus_relative( 1) end),
  awful.key({ modkey, "Shift" }, "Tab", function() awful.screen.focus_relative(-1) end),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey, }, "p",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),

  -- Standard program
  awful.key({ modkey, "Shift" }, "Return", function() awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift" }, "q", awesome.quit),

  awful.key({ modkey, }, "l", function() awful.tag.incmwfact( 0.015) end),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.015) end),
  awful.key({ modkey, }, "j", function() awful.client.incwfact( 0.03) end),
  awful.key({ modkey, }, "k", function() awful.client.incwfact(-0.03) end),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster( 1) end),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol( 1) end),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1) end),
  awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),

  -- Prompt
  awful.key({ altkey }, "F2", function() mypromptbox[mouse.screen]:run() end),
  awful.key({ modkey }, "r", function() mypromptbox[mouse.screen]:run() end),

  awful.key({ modkey }, "x",
    function ()
      awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end),

  -- Scratchpad
  awful.key({ modkey }, "`", function()
      scratch.drop("xterm -name scratch", "bottom", "right", 1.0, 0.40)
    end),

  -- {{{ Tag 0
  awful.key({ modkey }, 0,
    function ()
      local screen = mouse.screen
      if tags[screen][10].selected then
        awful.tag.history.restore(screen)
      elseif tags[screen][10] then
        awful.tag.viewonly(tags[screen][10])
      end
    end),
  awful.key({ modkey, "Control" }, 0,
    function ()
      local screen = mouse.screen
      if tags[screen][10] then
        tags[screen][10].selected = not tags[screen][10].selected
      end
    end),
  awful.key({ modkey, "Shift" }, 0,
    function ()
      if client.focus and tags[client.focus.screen][10] then
        awful.client.movetotag(tags[client.focus.screen][10])
      end
    end),
  awful.key({ modkey, "Control", "Shift" }, 0,
    function ()
      if client.focus and tags[client.focus.screen][10] then
        awful.client.toggletag(tags[client.focus.screen][10])
      end
    end)
  -- }}}
)

clientkeys = awful.util.table.join(
  awful.key({ modkey, }, "f", function(c) c.fullscreen = not c.fullscreen end),
  awful.key({ altkey, }, "F4", function(c) c:kill() end),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle ),
  awful.key({ modkey  }, "Return", function(c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey, }, "o", awful.client.movetoscreen ),
  awful.key({ modkey, "Shift" }, "r", function(c) c:redraw() end),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),
  awful.key({ modkey, }, "n", function(c) c.minimized = not c.minimized end),

  -- Maximize
  awful.key({ modkey, }, "m",
    function (c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical = not c.maximized_vertical
    end),

  -- Scratchify
  awful.key({ modkey, }, "v",
    function (c)
      scratch.pad.set(c, 0.50, 0.50, true)
    end)
)

keynumber = 0
for s = 1, screen.count() do
  keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        if tags[screen][i].selected then
          awful.tag.history.restore(screen)
        elseif tags[screen][i] then
          awful.tag.viewonly(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewtoggle(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.movetotag(tags[client.focus.screen][i])
        end
      end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.toggletag(tags[client.focus.screen][i])
        end
      end))
end

clientbuttons = awful.util.table.join(
  awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
  { rule = { },
    properties = { border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = true,
      keys = clientkeys,
      buttons = clientbuttons } },
  { rule = { class = "MPlayer" },
    properties = { floating = true } },
  { rule = { class = "Skype" },
    properties = { floating = true, tag = tags[1][10] } },
  { rule = { class = "Godesk" },
    properties = { floating = true } },
  { rule = { class = "pinentry" },
    properties = { floating = true } },
  { rule = { class = "gimp" },
    properties = { floating = true } },
  { rule = { class = "Firefox" },
    properties = { tag = tags[1][2] } },
  { rule = { class = "Firefox", instance = "Download" },
    properties = { floating = true } },
  { rule = { class = "Firefox", instance = "Places" },
    properties = { floating = true } },
  { rule = { class = "Thunderbird" },
    properties = { tag = tags[1][2] } },
  { rule = { class = "Thunar" },
    properties = { tag = tags[1][7] } },
  { rule = { class = "Gimp" },
    properties = { tag = tags[1][8] } }
}
-- }}}

-- {{{ Signals
client.add_signal("manage", function (c, startup)
  -- Add a titlebar
  -- awful.titlebar.add(c, { modkey = modkey })

  -- Sloppy focus
  c:add_signal("mouse::enter", function(c)
      if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
      and awful.client.focus.filter(c) then
        client.focus = c
      end
    end)

  if not startup then
    -- Set the windows as slave
    awful.client.setslave(c)

    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end

  c.size_hints_honor = false
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
