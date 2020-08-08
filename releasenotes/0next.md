### 2018.08.08

Updated all scripts, went through and cleaned up a lot of the code.
Efficiency and stability on many of the scripts are largely improved.
Most added features are to ease development, fi. `--dryrun` and `--verbose` options. 

#### The biggest change has been done to i3fyra

which now keeps track of the *virtual position* of a window. What this means is that if you have the following window rule defined in your **i3 config file**:  

```
for_window [instance=irssi class=URxvt] focus;exec --no-startup-id i3fyra --move A
```

And spawn a window matching the criteria it will get *moved* to the A container, which by default is the top-left container.  

```
AAB
AAD
CCD
```

Just as before the containers can be toggled and swapped by using `i3fyra --move DIRECTION` (where direction is up,down,left or right). And if the A container would have focus, and we execute `--move left` it would hide the B and D containers:

```
AAA
AAA
CCC
```

If we in this state would execute `--move right` (while the A container is focused), it would move the A and C container to the right and show the B and D containers to the left, but i3fyra will also internally rename all the containers:  

```
ABB
ABB
CDD
```

This used to mean that if we now would spawn a window matching our previously defined window rule, it would still get placed in the top-left container. This is where things are different now. In **i3list** there are four new keys, `[VPA],[VPB],[VPC] and [VPD]` which contains a number between zero and three (0-3). If i3list would get executed with the scenario above we would get the following results:  

```
i3list[VPA]=1
i3list[VPB]=0
i3list[VPC]=3
i3list[VPD]=2
```

the integers corresponds to the index of the hypothetical array `a=([0]=A [1]=B [2]=C [3]=D)`, and with this information we can see that when we want to send a window to container A, we test the virtual position, and see that A is positioned at 1 (*B*), be placed in **B** instead. In most cases this is the desired result, but sometimes it isn't, and for those cases one can use the `--force` option (which is new) to ignore the virtual positions. But this is probably nothing that anyone needs to worry about, and is more or less only used internally in **i3fyra**, **i3menu** and **i3run**. This transformation to virtual positions of the containers also works with the `--layout` option in **i3fyra**.

#### i3get

i3get has also underwent a complete makeover, and i now use *one* (well, sometimes two ;) single regular expression test in bash instead of parsing the json with awk, this made the script twice as fast and also, imo, easier to maintain and extend. I also added two new `--print` options, `s` for sticky status, and `e` for fullscreen status. But the most important change is done to the `--synk` functionality, which now uses `i3-msg -t subscribe` instead of a `while true; do sleep 10 ...`, and it makes everything much more responsive while at the same time being so much more efficient and nice on system recourses.

