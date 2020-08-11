### i3flip
We now use the output of **i3viswiz** instead of a custom AWK script. This made everything more reliable and `--move` function now works as expected in all types of layouts, (*not just tabbed and stacked as before*). Also added `--json`, `--verbose` and `--dryrun` options.




### 2018.08.08

Updated all scripts, went through and cleaned up a lot of the code.
Efficiency and stability on many of the scripts are largely improved.
Most added features are to ease development, fi. `--dryrun` and `--verbose` options. 



#### i3get

i3get has also underwent a complete makeover, and i now use *one* (well, sometimes two ;) single regular expression test in bash instead of parsing the json with awk, this made the script twice as fast and also, imo, easier to maintain and extend. I also added two new `--print` options, `s` for sticky status, and `e` for fullscreen status. But the most important change is done to the `--synk` functionality, which now uses `i3-msg -t subscribe` instead of a `while true; do sleep 10 ...`, and it makes everything much more responsive while at the same time being so much more efficient and nice on system recourses.

