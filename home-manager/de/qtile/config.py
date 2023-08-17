from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import psutil
import os

from vars import colors, font, font_size, border, margin

terminal = guess_terminal()
mod = "mod4"
sep = ' -- '

### keys
keys = [
    #windows
    Key([mod], 'Tab', lazy.next_layout()),
    Key([mod], 'q', lazy.window.kill()),
    # shift focus
    Key([mod], 'space', lazy.layout.next()),
    # change size
    Key([mod], 'h', lazy.layout.grow_left()),
    Key([mod], 'l', lazy.layout.grow_right()),
    Key([mod], 'j', lazy.layout.grow_down()),
    Key([mod], 'k', lazy.layout.grow_up()),
    Key([mod], 'f', lazy.window.toggle_fullscreen()),
    # move about
    Key([mod, 'shift'], 'h', lazy.layout.shuffle_left()),
    Key([mod, 'shift'], 'l', lazy.layout.shuffle_right()),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down()),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up()),
    # launch
    Key([mod], 'Return', lazy.spawn(terminal)),
    Key([mod], 'd', lazy.spawncmd()),
    #admin
    Key([mod, 'shift'], 'r', lazy.reload_config()),
    Key([mod, 'shift'], 'q', lazy.shutdown()),
]

### groups
groups = []
group_names = ['1','2','3','4','5','6','7','8','9','0']

keynames = [ i for i in '1234567890' ]
for g in range(len(group_names)):
    groups.append(
        Group(name=group_names[g])
    )

for keyname, group in zip(keynames, groups):
    keys.extend([
        Key([mod], keyname, lazy.group[group.name].toscreen()),
        Key([mod, 'shift'], keyname, lazy.window.togroup(group.name)),
    ])

### layouts
layouts = [
    layout.Bsp(
        border_on_single = True,
        border_normal = colors['background'],
        border_focus = colors['accent'],
        border_width = border,
        margin = margin,
        ratio = 1.618, # golden ratio lel
    ),
]

### widgets
widget_defaults = dict(
    background = colors['background'],
    foreground = colors['foreground'],
    font=font,
    fontsize=font_size,
    padding=4,
)
extension_defaults = widget_defaults.copy()

widgets = [
    widget.GroupBox(
        highlight_method = 'text',
        hide_unused = True,
        active = colors['foreground'],
        this_current_screen_border = colors['accent'],
    ),
    widget.Prompt(
        cursor_color = colors['accent'],
        prompt = '-> ',
    ),
    widget.Spacer(length = bar.STRETCH),

    widget.CPU(format = '{freq_current}GHz {load_percent}%'),
    widget.ThermalSensor(
        foreground = colors['foreground'],
    ),
    widget.TextBox(text = sep),
    widget.DF(
        partition = '/',
        visible_on_warn = False,
        format = '{p} {r:.0f}%',
    ),
    widget.TextBox(text = sep),
    widget.Memory(format = '{MemUsed: .0f}{mm} /{MemTotal: .0f}{mm}'),
    widget.TextBox(text = sep),
    widget.PulseVolume(
        fmt = 'vol {}',
    ),
    widget.TextBox(text = sep),
    widget.Clock(format='%A %d %B %H:%M:%S'),
]

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            30,
            border_width = border,
            border_color = colors['accent'],
            margin = 0,
        ),
        wallpaper=os.path.expanduser('~/.background'),
        wallpaper_mode='fill',
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        'Button1',
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [mod],
        'Button3',
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click(
        [mod],
        'Button2', 
        lazy.window.bring_to_front()
    ),
]

### swallow
@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()}
    for i in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()

@hook.subscribe.client_killed
def _unswallow(window):
    if hasattr(window, 'parent'):
        window.parent.minimized = False

floating_layout = layout.Floating(
    border = border,
    border_focus = colors['accent'],
    border_normal = colors['background'],
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='mpv'),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
