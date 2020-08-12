`i3ass` - i3 assistance scripts


arbe
# `i3flip` - Tabswitching done right

SYNOPSIS
--------

```text
i3flip [--move|-m] [--json JSON] [--verbose] [--dryrun] DIRECTION
i3flip --help|-h
i3flip --version|-v
```


DESCRIPTION
-----------

`i3flip` switch containers without leaving the
parent. Perfect for tabbed or stacked layout, but
works on all layouts. If direction is `next` and
the active container is the last, the first
container will get focused.  

**DIRECTION** can be either *prev* or *next*,
which can be defined with different words:  

**next**|right|down|n|r|d  
**prev**|left|up|p|l|u  


OPTIONS
-------


`--move`|`-m`  
Move the current container instead of changing
focus.

`--json` JSON  
use JSON instead of output from  `i3-msg -t
get_tree`

`--verbose`  
Print more information to **stderr**.

`--dryrun`  
Don't execute any *i3 commands*.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

`~/.config/i3/config`:  
``` text
...
bindsym Mod4+Tab         exec --no-startup-id i3flip next
bindsym Mod4+Shift+Tab   exec --no-startup-id i3flip prev
```



DEPENDENCIES
------------

`i3` `i3viswiz`

# `i3fyra` - An advanced, simple grid-based tiling layout


SYNOPSIS
--------

```text
i3fyra --show|-s CONTAINER [--force|-f] [--array ARRAY] [--verbose] [--dryrun]
i3fyra --float|-a [--array ARRAY] [--verbose] [--dryrun]
i3fyra --hide|-z CONTAINER [--force|-f] [--array ARRAY] [--verbose] [--dryrun]
i3fyra --layout|-l LAYOUT [--force|-f] [--array ARRAY] [--verbose] [--dryrun]
i3fyra --move|-m DIRECTION|CONTAINER [--force|-f] [--speed|-p INT] [--array ARRAY] [--verbose] [--dryrun]
i3fyra --help|-h
i3fyra --version|-v
```


DESCRIPTION
-----------

The layout consists of four containers:  

``` text
  A B
  C D
```



A container can contain one or more windows. The
internal layout of the containers doesn't matter.
By default the layout of each container is tabbed.  

A is always to the left of B and D. And always
above C. B is always to the right of A and C. And
always above D.  

This means that the containers will change names
if their position changes.  

The size of the containers are defined by the
three splits: AB, AC and BD.  

Container A and C belong to one family.  
Container B and D belong to one family.  

The visibility of containers and families can be
toggled. Not visible containers are placed on the
scratchpad.  

The visibility is toggled by either using *show*
(`-s`) or *hide* (`-z`). But more often by moving
a container in an *impossible* direction, (*see
examples below*).  

The **i3fyra** layout is only active on one
workspace. That workspace can be set with the
environment variable: `i3FYRA_WS`, otherwise the
workspace active when the layout is created will
be used.  

The benefit of using this layout is that the
placement of windows is more predictable and
easier to control. Especially when using tabbed
containers, which are very clunky to use with
*default i3*.


OPTIONS
-------


`--show`|`-s` CONTAINER  
Show target container. If it doesn't exist, it
will be created and current window will be put in
it. If it is visible, nothing happens.

`--force`|`-f`  
If set virtual positions will be ignored.

`--array` ARRAY  
ARRAY should be the output of `i3list`. It is
used to improve speed when **i3fyra** is executed
from a script that already have the array, f.i.
**i3run** and **i3Kornhe**.  

`--verbose`  
If set information about execution will be
printed to **stderr**.

`--dryrun`  
If set no window manipulation will be done during
execution.

`--float`|`-a`  
Autolayout. If current window is tiled: floating
enabled If window is floating, it will be put in a
visible container. If there is no visible
containers. The window will be placed in a hidden
container. If no containers exist, container
'A'will be created and the window will be put
there.

`--hide`|`-z` CONTAINER  
Hide target containers if visible.  

`--layout`|`-l` LAYOUT  
alter splits Changes the given splits. INT is a
distance in pixels. AB is on X axis from the left
side if INT is positive, from the right side if it
is negative. AC and BD is on Y axis from the top
if INT is positive, from the bottom if it is
negative. The whole argument needs to be quoted.
Example:  
`$ i3fyra --layout 'AB=-300 BD=420'`  


`--move`|`-m` CONTAINER  
Moves current window to target container, either
defined by it's name or it's position relative to
the current container with a direction:
[`l`|`left`][`r`|`right`][`u`|`up`][`d`|`down`] If
the container doesnt exist it is created. If
argument is a direction and there is no container
in that direction, Connected container(s)
visibility is toggled. If current window is
floating or not inside ABCD, normal movement is
performed. Distance for moving floating windows
with this action can be defined with the `--speed`
option. Example: `$ i3fyra --speed 30 -m r` Will
move current window 30 pixels to the right, if it
is floating.

`--speed`|`-p` INT  
Distance in pixels to move a floating window.
Defaults to 30.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit


EXAMPLES
--------

If containers **A**,**B** and **C** are visible
but **D** is hidden or none existent, the visible
layout would looks like this:  

``` text
  A B
  C B
```



If action: *move up* (`-m u`) would be called
when container **B** is active and **D** is
hidden. Container **D** would be shown. If action
would have been: *move down* (`-m d`), **D** would
be shown but **B** would be placed below **D**,
this means that the containers will also swap
names. If action would have been *move left* (`-m
l`) the active window in B would be moved to
container **A**. If action was *move right* (`-m
r`) **A** and **C** would be hidden:  

``` text
  B B
  B B
```



If we now *move left* (`-m l`), **A** and **C**
would be shown again but to the right of **B**,
the containers would also change names, so **B**
becomes **A**, **A** becomes **B** and **C**
becomes **D**:  

``` text
  A B
  A D
```



If this doesn't make sense, check out this
demonstration on youtube:
https://youtu.be/kU8gb6WLFk8

ENVIRONMENT
-----------


`I3FYRA_MAIN_CONTAINER`  
This container will be the chosen when a
container is requested but not given. When using
the command autolayout (`-a`) for example, if the
window is floating it will be sent to the main
container, if no other containers exist. Defaults
to A. defaults to: A

`I3FYRA_WS`  
Workspace to use for i3fyra. If not set, the firs
workspace that request to create the layout will
be used. defaults to:

`I3FYRA_ORIENTATION`  
If set to `vertical` main split will be `AC` and
families will be `AB` and `CD`. Otherwise main
split will be `AB` and families will be `AC` and
`BD`. defaults to: horizontal

DEPENDENCIES
------------

`bash` `gawk` `i3` `i3list` `i3gw` `i3var`
`i3viswiz`

# `i3get` - prints info about a specific window to stdout


SYNOPSIS
--------

```text
i3get [--class|-c CLASS] [--instance|-i INSTANCE] [--title|-t TITLE] [--conid|-n CON_ID] [--id|-d WIN_ID] [--mark|-m MARK] [--titleformat|-o TITLE_FORMAT] [--active|-a] [--synk|-y] [--print|-r OUTPUT] [--json TREE]      
i3get --help|-h
i3get --version|-v
```


DESCRIPTION
-----------

Search for `CRITERIA` in the output of `i3-msg -t
get_tree`, return desired information. If no
arguments are passed, `con_id` of active window is
returned. If there is more then one criterion, all
of them must be true to get results.


OPTIONS
-------


`--class`|`-c` CLASS  
Search for windows with the given class

`--instance`|`-i` INSTANCE  
Search for windows with the given instance

`--title`|`-t` TITLE  
Search for windows with title.

`--conid`|`-n` CON_ID  
Search for windows with the given con_id

`--id`|`-d` WIN_ID  
Search for windows with the given window id

`--mark`|`-m` MARK  
Search for windows with the given mark

`--titleformat`|`-o` TITLE_FORMAT  
Search for windows with the given titleformat

`--active`|`-a`  
Currently active window (default)

`--synk`|`-y`  
Synch on. If this option is included,  script
will wait till target window exist. (*or timeout
after 60 seconds*).

`--print`|`-r` OUTPUT  
*OUTPUT* can be one or more of the following 
characters:  



|character | print            | return
|:---------|:-----------------|:------
|`t`         | title            | string
|`c`         | class            | string
|`i`         | instance         | string
|`d`         | Window ID        | INT
|`n`         | Con_Id (default) | INT
|`m`         | mark             | JSON list
|`w`         | workspace        | INT
|`a`         | is active        | true or false
|`f`         | floating state   | string
|`o`         | title format     | string
|`e`         | fullscreen       | 1 or 0
|`s`         | sticky           | true or false
|`u`         | urgent           | true or false

Each character in OUTPUT will be tested and the
return value will be printed on a new line. If no
value is found, `--i3get could not find:
CHARACTER` will get printed.

In the example below, the target window did not
have a mark:  

```
$ i3get -r tfcmw
/dev/pts/9
user_off
URxvt
--i3get could not find: m
1
```



`--json` TREE  
Use TREE instead of the output of  
`i3-msg -t get_tree`

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit


EXAMPLES
--------

search for window with instance name
sublime_text.  Request workspace, title and
floating state.  

``` shell
$ i3get --instance sublime_text --print wtf 
1
~/src/bash/i3ass/i3get (i3ass) - Sublime Text
user_off
```


DEPENDENCIES
------------

`bash` `i3`

# `i3gw` - a ghost window wrapper for i3wm


SYNOPSIS
--------

```text
i3gw MARK
i3gw --help|-h
i3gw --version|-v
```


DESCRIPTION
-----------

`i3-msg` has an undocumented function: *open*, 
it creates empty containers,  or as I call them:
ghosts.  Since these empty containers doesn't
contain any windows  there is no
instance/class/title to identify them,  making it
difficult to manage them.  They do however have a
`con_id`  and I found that the easiest way to keep
track of ghosts, is to mark them.  That is what
this script does,  it creates a ghost,  get its
`con_id` and marks it.


OPTIONS
-------


`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

`$ i3gw casper`  

this will create a ghost marked casper,  you can
perform any action you can perform on a regular
container.

``` text
$ i3-msg [con_mark=casper] move to workspace 2
$ i3-msg [con_mark=casper] split v
$ i3-msg [con_mark=casper] layout tabbed
$ i3-msg [con_mark=casper] kill
```



the last command (`kill`), destroys the
container.

DEPENDENCIES
------------

`i3`

# `i3Kornhe` - move and resize windows gracefully


SYNOPSIS
--------

```text
i3Kornhe DIRECTION
i3Kornhe move [--speed|-p SPEED] [DIRECTION]
i3Kornhe size [--speed|-p SPEED] [DIRECTION]
i3Kornhe 1-9
i3Kornhe x
i3Kornhe --help|-h
i3Kornhe --version|-v
```


DESCRIPTION
-----------

i3Kornhe provides an alternative way to move and
resize windows in **i3**. It has some more
functions then the defaults and is more
streamlined. Resizing floating windows is done by
first selecting a corner of the window,  and then
moving that corner. See the wiki or the manpage
for details and how to add the required mode in
the i3 config file that is needed to use
**i3Kornhe**.


OPTIONS
-------


`--speed`|`-p` SPEED  
Sets speed or distance in pixels to use when
moving and resizing the windows.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


DEPENDENCIES
------------

`bash` `gawk` `i3` `i3list` `i3var`

# `i3list` - list information about the current i3 session.


SYNOPSIS
--------

```text
i3list [--json JSON]
i3list --instance|-i TARGET [--json JSON]
i3list --class|-c    TARGET [--json JSON]
i3list --conid|-n    TARGET [--json JSON]
i3list --winid|-d    TARGET [--json JSON]
i3list --mark|-m     TARGET [--json JSON]
i3list --title|-t    TARGET [--json JSON]
i3list --help|-h
i3list --version|-v
```


DESCRIPTION
-----------

`i3list` prints a list in a *array* formatted
list.  If a search criteria is given 
(`-c`|`-i`|`-n`|`-d`|`-m`)  information about the
first window matching the criteria is displayed. 
Information about the active window is always
displayed.  If no search criteria is given,  the
active window will also be the target window.

By using eval,  the output can be used as an
array in bash scripts,  but the array needs to be
declared first.


OPTIONS
-------


`--json` JSON  
use JSON instead of output from  `i3-msg -t
get_tree`

`--instance`|`-i` TARGET  
Search for windows with a instance matching
*TARGET*

`--class`|`-c` TARGET  
Search for windows with a class matching *TARGET*

`--conid`|`-n` TARGET  
Search for windows with a **CON_ID** matching
*TARGET*

`--winid`|`-d` TARGET  
Search for windows with a **WINDOW_ID** matching
*TARGET*

`--mark`|`-m` TARGET  
Search for windows with a **mark** matching
*TARGET*

`--title`|`-t` TARGET  
Search for windows with a **title** matching
*TARGET*  

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

```text$ i3list
i3list[AWF]=0                  # Active Window floating
i3list[ATW]=270                # Active Window tab width
i3list[ATX]=540                # Active Window tab x postion
i3list[AWH]=1700               # Active Window height
i3list[AWI]=4194403            # Active Window id
i3list[AWW]=1080               # Active Window width
i3list[AFO]=AB                 # Active Window relatives
i3list[AWX]=0                  # Active Window x position
i3list[AFC]=B                  # Active Window cousin
i3list[AWY]=220                # Active Window y position
i3list[AFF]=CD                 # Active Window family
i3list[AFS]=D                  # Active Window sibling
i3list[AWB]=20                 # Active Window titlebar height
i3list[AFT]=A                  # Active Window twin
i3list[AWP]=C                  # Active Window parent
i3list[AWC]=94283162546096     # Active Window con_id
i3list[TWB]=20                 # Target Window titlebar height
i3list[TFS]=D                  # Target Window sibling
i3list[TFF]=CD                 # Target Window family
i3list[TWP]=C                  # Target Window Parent container
i3list[TFT]=A                  # Target Window twin
i3list[TWC]=94283162546096     # Target Window con_id
i3list[TWF]=0                  # Target Window Floating
i3list[TTW]=270                # Target Window tab width
i3list[TWH]=1700               # Target Window height
i3list[TTX]=540                # Target Window tab x postion
i3list[TWI]=4194403            # Target Window id
i3list[TWW]=1080               # Target Window width
i3list[TWX]=0                  # Target Window x position
i3list[TFO]=AB                 # Target Window relatives
i3list[TWY]=220                # Target Window y position
i3list[TFC]=B                  # Target Window cousin
i3list[CAF]=94283159300528     # Container A Focused container id
i3list[CBF]=94283160891520     # Container B Focused container id
i3list[CCF]=94283162546096     # Container C Focused container id
i3list[CAW]=1                  # Container A Workspace
i3list[CBW]=1                  # Container B Workspace
i3list[CCW]=1                  # Container C Workspace
i3list[CAL]=tabbed             # Container A Layout
i3list[CBL]=tabbed             # Container B Layout
i3list[CCL]=tabbed             # Container C Layout
i3list[SAB]=730                # Current split: AB
i3list[MCD]=770                # Stored split: CD
i3list[SAC]=220                # Current split: AC
i3list[SBD]=220                # Current split: BD
i3list[SCD]=1080               # Current split: CD
i3list[MAB]=730                # Stored split: AB
i3list[MAC]=220                # Stored split: AC
i3list[LEX]=CBA                # Existing containers (LVI+LHI)
i3list[LHI]=                   # Hidden i3fyra containers
i3list[LVI]=CBA                # Visible i3fyra containers
i3list[FCD]=C                  # Family CD memory
i3list[LAL]=ABCD               # All containers in family order
i3list[WAH]=1920               # Active Workspace height
i3list[WAI]=94283159180304     # Active Workspace con_id
i3list[WAW]=1080               # Active Workspace width
i3list[WSF]=1                  # i3fyra Workspace Number
i3list[WAX]=0                  # Active Workspace x position
i3list[WST]=1                  # Target Workspace Number
i3list[WAY]=0                  # Active Workspace y position
i3list[WFH]=1920               # i3fyra Workspace Height
i3list[WTH]=1920               # Target Workspace Height
i3list[WFI]=94283159180304     # i3fyra Workspace con_id
i3list[WAN]='1'                # Active Workspace name
i3list[WTI]=94283159180304     # Target Workspace con_id
i3list[WFW]=1080               # i3fyra Workspace Width
i3list[WTW]=1080               # Target Workspace Width
i3list[WFX]=0                  # i3fyra Workspace X position
i3list[WTX]=0                  # Target Workspace X poistion
i3list[WFY]=0                  # i3fyra Workspace Y position
i3list[WTY]=0                  # Target Workspace Y position
i3list[WFN]='1'                # i3fyra Workspace name
i3list[WSA]=1                  # Active Workspace number
i3list[WTN]='1'                # Target Workspace name


$ declare -A i3list # declares associative array
$ eval "$(i3list)"
$ echo ${i3list[WAW]}
1080
```


DEPENDENCIES
------------

`bash` `gawk` `i3`

# `i3menu` - Adds more features to rofi when used in i3wm


SYNOPSIS
--------

```text
i3menu [--theme THEME] [--layout|-a LAYOUT] [--include|-i INCLUDESTRING] [--top|-t TOP] [--xpos|-x INT] [--xoffset INT] [--ypos|-y INT] [--yoffset INT] [--width|-w INT] [--options|-o OPTIONS] [--prompt|-p PROMPT]  [--filter|-f FILTER] [--show MODE] [--modi MODI] [--target TARGET] [--orientation ORIENTATION] [--anchor INT] [--height INT] [--fallback FALLBACK]
i3menu --help|-h
i3menu --version|-v
```


DESCRIPTION
-----------

`i3menu` wraps the options i use the most with
`rofi`  and make it easy to set different color
schemes and positions for the menu.  

Every line in `stdin` will be displayed as a menu
item.  The order will be the same as entered if
not `--top` is set.  

The foundation for the appearance of the menus
are the themefiles 
**i3menu.rasi**,**themevars.rasi**, found in
I3MENU_DIR (defaults to $XDG_CONFIG_HOME/i3menu),
but depending on the options  passed to `i3menu`
certain values of the themefiles  will get
overwritten.  



OPTIONS
-------


`--theme` THEME  
If a **.rasi** file with same name as THEME exist
in `I3MENU_DIR/themes`, it's content will get
appended to theme file before showing the menu.  

`$ echo "list" | i3menu --theme red`  
this will use the the file:
`I3MENU_DIR/themes/red.rasi`

If no matching themefile is found,
`I3MENU_DIR/themes/default.rasi` will be used 
(and created if it doesn't exist).

`--layout`|`-a` LAYOUT  
This is where **i3menu** differs the most from
normal **rofi** behavior and is the only option
that truly depends on `i3`, `i3list` (and
**i3fyra** if the value is A|B|C|D). If this
option is not set, the menu will default to a
single line (*dmenu like*) menu at the top of the
screen. If however a value to this option is one
of the following:  



| LAYOUT     | menu location and dimensions 
|:-----------|:---------------
| mouse      | At the mouse position (requires `xdotool`)
| window     | The currently active window.
| titlebar   | The titlebar of the currently active window.
| tab        | The tab (or titlebar if it isn't tabbed) of the currently active window.
| A,B,C or D | The **i3fyra** container of the same name if it is visible. If target container isn't visible the menu will be displayed at the default location.

titlebar and tab LAYOUT will be displayed as a
single line (*dmenu like*) menu, and the other
LAYOUTS will be of vertical (*combobox*) layout
with the prompt and entrybox above the list.  

The position of the menu can be further
manipulated by using
`--xpos`,`--ypos`,`--width`,`--height`,`--orientation`,`--include`.  

`$ echo "list" | i3menu --prompt "select: "
--layout window --xpos -50 --ypos 30`  
The command above would create a menu with the
same size and position as the current window, but
place it 50px to the left of the window, and 30px
below the *lower* of the window.

`--include`|`-i` INCLUDESTRING  
INCLUDESTRING can be set to force which elements
of the menu to include. INCLUDESTRING can be one
or more of the following character:  



| char | element  |
|:-----|:---------|
|**p** | prompt   |
|**e** | entrybox |
|**l** | list     |

`echo "list" | i3menu --include le --prompt
"enter a value: "`  
The command above will result in a menu without
the **prompt** element.  

`i3menu --include pe --prompt "enter a value: "`  
The command above will result in a menu without a
**list** element. (just an inputbox).  

It's also worth mentioning that **i3menu** adapts
to the objects it knows before creating the menu.
This means that if no input stream (list) exist,
no list element will be included, the same goes
for the prompt.  

`--top`|`-t` TOP  
If TOP is set, the input stream (LIST) will get
matched against TOP. Lines in LIST with an exact
MATCH of those in TOP will get moved to the TOP of
LIST before the menu is created.


`$ printf '%s\n' one two three four | i3menu
--top "$(printf '%s\n' two four)"`  

will result in a list looking like this:  
`two four one three`


`--xpos`|`-x` INT  
Sets the **X** position of the menu to INT. If
this option is set, it will override any automatic
position of the **X** coordinate.

`--xoffset` INT  
Adds INT to the calculated **X** position of the
menu before it is displayed. XPOS can be either
positive or negative.

**EXAMPLE**  
If both `--layout` is set to `window` and
`--xpos` is set to `-50`, the menu will be placed
50 pixels to the left of the active window but
have the same dimensions as the window.

`--ypos`|`-y` INT  
Sets the **Y** position of the menu to INT. If
this option is set, it will override any automatic
position of the **Y** coordinate.

`--yoffset` INT  
Adds INT to the calculated **Y** position of the
menu before it is displayed. INT can be either
positive or negative.

**EXAMPLE**  
If both `--layout` is set to `titlebar` and
`--ypos` is set to `50`, the menu will be placed
50 pixels below the active window.

`--width`|`-w` INT  
Changes the width of the menu. If the argument to
`--width` ends with a `%` character the width will
be that many percentages of the screenwidth.
Without `%` absolute width in pixels will be set.

`--options`|`-o` OPTIONS  
The argument is a string of aditional options to
pass to **rofi**.  

`$ i3menu --prompt "Enter val: " --options
'-matching regex'`  
will result in a call to rofi looking something
like this:  
`rofi -p "Enter val: " -matching regex -dmenu`

Note that the **rofi** options: `-p, -filter,
-show, -modi` *could be* entered to as arguments

to `i3menu --options`, but it is recommended to
use: `--prompt`, `--filter`, `--show` and `--modi`
instead, since this will make i3menu optimize the
layout better.

`--prompt`|`-p` PROMPT  
Sets the prompt of the menu to PROMPT.

`--filter`|`-f` FILTER  
Sets the inputbox text/filter to FILTER. Defaults
to blank string.

`--show` MODE  
This is a short hand for the **rofi** option
`-show`. So instead of doing this:  
`$ i3menu -o '-show run'` , you can do this:  
`$ i3menu --show run`

`--modi` MODI  
This is a short hand for the **rofi** option
`-modi`. So instead of doing this:  
`$ i3menu -o '-modi run,drun -show run'` , you
can do this:  
`$ i3menu --modi run,drun --show run`

`--target` TARGET  
TARGET is a string containing additional options
passed to **i3list**. This can be used to change
the target window when `--layout` is set to:
`window`,`titlebar` or `tab`.

`--orientation` ORIENTATION  
This forces the layout of the menu to be either
vertical or horizontal. If `--layout` is set to
**window**, the layout will always be `vertical`.

`--anchor` INT  
Sets the "*anchor*" point of the menu. The
default is **1**. **1** means the top left corner,
**9** means the bottom right corner. Corner in
this context doesn't refer to the corners of the
screen, but the corners of the menu. If the anchor
is *top left* (**1**), the menu will *grow* from
that point.

`--height` INT  
Overrides the calculated height of the menu.

`--fallback` FALLBACK  
FALLBACK can be a string of optional options the
will be tried if the *first layout* fails. A
layout can fail of three reasons:

1. layout is window or container, but no list is passed. If no fallback is set, **titlebar** layout will get tried.
2. layout is container but container is not visible. If no fallback is set, **default** layout will get tried.
3. layout is window, tab or titlebar but no target window is found. If no fallback is set, **default** layout will get tried.



**Example**  
```text
$ echo -e "one\ntwo\nthree" | i3menu --layout A --fallback '--layout mouse --width 300'
```



The example above will display a menu at the
mouse pointer if container A isn't visible.

Fallbacks can be nested, but make sure to
alternate quotes:  

```text
$ echo -e "one\ntwo\nthree" | i3menu --layout A --fallback '--layout window --fallback "--layout mouse --width 300"'
```



The example above would first try to display a
menu with `--layout A` if that fails, it will try
a menu with `--layout window` and last if no
target window can be found, the menu will get
displayed at the mouse pointer.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit


ENVIRONMENT
-----------


`XDG_CONFIG_HOME`  

defaults to: $HOME/.config

`I3MENU_DIR`  
Path to config directory. defaults to:
$XDG_CONFIG_HOME/i3menu

DEPENDENCIES
------------

`bash` `gawk` `rofi` `i3list` `xdotool`

# `i3run` - Run, Raise or hide windows in i3wm


SYNOPSIS
--------

```text
i3run --instance|-i INSTANCE [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --class|-c CLASS [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --title|-t  TITLE [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --conid|-n CON_ID [--summon|-s] [--nohide|-g] [--mouse|-m] [--rename|-x OLD_NAME] [--force|-f] [--FORCE|-F] [--command|-e COMMAND]
i3run --help|-h
i3run --version|-v
```


DESCRIPTION
-----------

`i3run` let's you use one command for multiple
functions related to the same window identified by
a given criteria.  `i3run` will take different
action depending on the state of the searched
window:  



| **target window state**          | **action**
|:---------------------------------|:------------
| Active and not handled by i3fyra | hide
| Active and handled by i3fyra     | hide container, if not `-g` is set
| Handled by i3fyra and hidden     | show container, activate
| Not handled by i3fyra and hidden | show window, activate
| Not on current workspace         | goto workspace or show if `-s` is set
| Not found                        | execute command (`-e`)


Hidden in this context,  means that window is on
the scratchpad. Show in this context means,  move
window to current workspace.  


`-e` is optional, if no *COMMAND* is passed and
no window is found,  nothing happens.  It is
important that `-e` *COMMAND* is **the last of the
options**.  It is also important that *COMMAND*
**will spawn a window matching the criteria**, 
otherwise the script will get stuck in a loop
waiting for the window to appear. (*it will stop
waiting for the window to appear after 60
seconds*)


OPTIONS
-------


`--instance`|`-i` INSTANCE  
Search for windows with the given INSTANCE

`--summon`|`-s`  
Instead of switching workspace, summon window to
current workspace

`--nohide`|`-g`  
Don't hide window/container if it's active.

`--mouse`|`-m`  
The window will be placed on the location of the
mouse cursor when it is created or shown. (*needs
`xdotool`*)  

`--rename`|`-x` OLD_NAME  
If the search criteria is `-i` (instance), the
window with instance: *OLDNAME* will get a n new
instance name matching the criteria when it is
created (*needs `xdotool`*).  

```shell
i3run --instance budswin --rename sublime_main -command subl

# when the command above is executed:
# a window with the instance name: "budswin" will be searched for.
# if no window is found the command: "subl" will get executed,
# and when a window with the instance name: "sublime_main" is found,
# the instance name of that window will get renamed to: "budswin"
```




`--force`|`-f`  
Execute COMMAND (`--command`), even if the window
already exist. But not when hiding a window.

`--FORCE`|`-F`  
Execute COMMAND (`--command`), even if the window
already exist.

`--command`|`-e` COMMAND  
Command to run if no window is found. Complex
commands can be written inside quotes:  
```
i3run -i sublime_text -e 'subl && notify-send "sublime is started"'
```



`--class`|`-c` CLASS  
Search for windows with the given CLASS

`--title`|`-t` TITLE  
Search for windows with the given TITLE

`--conid`|`-n` CON_ID  
Search for windows with the given CON_ID

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


DEPENDENCIES
------------

`bash` `gawk` `i3list` `i3get` `i3var` `xdotool`
`i3fyra` `i3`

# `i3var` - Set or get a i3 variable


SYNOPSIS
--------

```text
i3var set VARNAME [VALUE]
i3var get VARNAME
i3var --help|-h
i3var --version|-v
```


DESCRIPTION
-----------

`i3var` is used to get or set a "variable" that
is bound to the current i3wm session.  The
variable is actually the mark of a "ghost window"
on the scratch pad.

`set`  \[VALUE\]  
If *VARNAME* doesn't exist, a new window and mark
will be created.  If *VARNAME* exists it's value
will be replaced with *VALUE*.  
If *VALUE* is not defined,  *VARNAME* will get
unset.  

`get`  
if *VARNAME* exists,  its value will be returned
window.  


OPTIONS
-------


`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


DEPENDENCIES
------------

`bash` `gawk` `sed` `i3` `i3gw`

# `i3viswiz` - Professional window focus for i3wm


SYNOPSIS
--------

```text
i3viswiz [--gap|-g GAPSIZE] DIRECTION  [--json JSON]
i3viswiz --title|-t       [--gap|-g GAPSIZE] [DIRECTION|TARGET] [--focus|-f] [--json JSON]
i3viswiz --instance|-i    [--gap|-g GAPSIZE] [DIRECTION|TARGET] [--focus|-f] [--json JSON]
i3viswiz --class|-c       [--gap|-g GAPSIZE] [DIRECTION|TARGET] [--focus|-f] [--json JSON]
i3viswiz --titleformat|-o [--gap|-g GAPSIZE] [DIRECTION|TARGET] [--focus|-f] [--json JSON]
i3viswiz --winid|-d       [--gap|-g GAPSIZE] [DIRECTION|TARGET] [--focus|-f] [--json JSON]
i3viswiz --parent|-p      [--gap|-g GAPSIZE] [DIRECTION|TARGET] [--focus|-f] [--json JSON]
i3viswiz --help|-h
i3viswiz --version|-v
```


DESCRIPTION
-----------

`i3viswiz` either prints a list of the currently
visible tiled windows to `stdout` or shifts the
focus depending on the arguments.  

If a *DIRECTION* (left|right|up|down) is passed,
`i3wizvis` will shift the focus to the window
closest in the given *DIRECTION*, or warp focus if
there are no windows in the given direction.  


OPTIONS
-------


`--gap`|`-g` TARGET  
Set GAPSIZE (defaults to 5). GAPSIZE is the
distance in pixels from the current window where
new focus will be searched.  

`--json` JSON  
use JSON instead of output from  `i3-msg -t
get_tree`

`--title`|`-t`  
If **TARGET** matches the **TITLE** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**TITLE** as the last field of each row.

`--focus`|`-f`  
When used in conjunction with: `--titleformat`,
`--title`, `--class`, `--instance`, `--winid` or
`--parent`. The **CON_ID** of **TARGET** window
will get focused if it is visible.

`--instance`|`-i`  
If **TARGET** matches the **INSTANCE** of a
visible window, that windows  **CON_ID** will get
printed to `stdout`. If no **TARGET** is
specified, a list of all tiled windows will get
printed with  **INSTANCE** as the last field of
each row.

`--class`|`-c`  
If **TARGET** matches the **CLASS** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**CLASS** as the last field of each row.

`--titleformat`|`-o`  
If **TARGET** matches the **TITLE_FORMAT** of a
visible window, that windows  **CON_ID** will get
printed to `stdout`. If no **TARGET** is
specified, a list of all tiled windows will get
printed with  **TITLE_FORMAT** as the last field
of each row.

`--winid`|`-d`  
If **TARGET** matches the **WIN_ID** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**WIN_ID** as the last field of each row.


`--parent`|`-p`  
If **TARGET** matches the **PARENT** of a visible
window, that windows  **CON_ID** will get printed
to `stdout`. If no **TARGET** is specified, a list
of all tiled windows will get printed with 
**PARENT** as the last field of each row.

`--help`|`-h`  
Show help and exit.

`--version`|`-v`  
Show version and exit.


EXAMPLES
--------

replace the normal i3 focus keybindings with
viswiz like this:  
``` text
Normal binding:
bindsym Mod4+Shift+Left   focus left

Wizzy binding:
bindsym Mod4+Left   exec --no-startup-id i3viswiz left
```



example output:  
``` text
$ i3viswiz --class --gap 20 down
trgcon=94125805431344 trgx=1329 trgy=828 wall=none trgpar=C sx=0 sy=0 sw=1920 sh=1080 groupsize=3 grouppos=3 firstingroup=94125805065424 lastingroup=94125805553936 grouplayout="tabbed" groupid=94125805519264 gap=5
* 94851560291216 x: 0     y: 0     w: 1165  h: 450   | URxvt
- 94851559487504 x: 0     y: 451   w: 1165  h: 448   | sublime
- 94851560318768 x: 1166  y: 0     w: 433   h: 899   | bin
```



If `--class , --instance, --title, --titleformat,
--winid or --parent` is used together with a
DIRECTION. i3viswiz will print this output, with
the type in the last column of the table (class in
the example above). The first line contains a lot
of useful pseudo variables that is used by other
scripts in **i3ass**  `eval "$(i3viswiz -p d)" ;
echo "$groupsize"`

DEPENDENCIES
------------

`bash` `gawk` `i3`


EXAMPLES
--------
Execute a script with the `--help` flag to
display help about the command.

`i3get --help` display [i3get] help  
`i3get --version` display [i3get] version  
`man i3get` show [i3get] man page  
`i3ass` show version info for all scripts and
dependencies.

DEPENDENCIES
------------
`bash`
`gawk`
`i3`
`git`



