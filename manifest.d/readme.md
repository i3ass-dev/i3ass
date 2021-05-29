# readme_banner

![logo](assets/i3ass-first-logo2021-05-26-300x200.png)  
This is a collection of scripts I have made to
assist the usage of the windowmanager known as [i3wm]. 

# examples

Execute a script with the `--help` flag to display help about the command. 

`i3get --help` display [i3get] help  
`i3get --version` display [i3get] version  
`man i3get` show [i3get] man page    
`i3ass` show version info for all scripts and dependencies.

# readme_install

If you are using **Arch linux**, you can install the i3ass package from [AUR].  

Or follow the instructions below to install from source:  

(*configure the installation destination in the Makefile, if needed*)

``` text
$ git clone https://github.com/budlabs/i3ass.git
$ cd i3ass
# make install
$ i3ass
i3ass - version: 0.002
updated: 2018-10-18 by budRich

script   | version
------------------
i3viswiz | 0.006
i3get    | 0.302
i3var    | 0.006
i3fyra   | 0.501
i3list   | 0.006
i3flip   | 0.013
i3Kornhe | 0.006
i3gw     | 0.147
i3run    | 0.011

bash      [INSTALLED]
gawk      [INSTALLED]
sed       [INSTALLED]
xdotool   [INSTALLED]
```

All the scripts that will be installed are located in the `src` directory of this repo, so you can also just add that directory or the scripts to your **$PATH**.  

# readme_issues

**THERE IS NO SUPPORT FOR i3-gaps**  
some scripts might still work with i3-gaps,
but consider that *Happy little accidents™*  

The latest version of i3 (**4.19**) introduced a new behaviour
that triggers `for_window` directives when a window is sent to the scratchpad.
This is very annoying if one would use something like:  
`for_window [instance=Install_gentoo] exec i3fyra --move A`  
I recommend anyone using `for_window` to stick with version **4.18.3**,
till this is resolved..  

`i3-msg restart` breaks [i3fyra],
try to use `i3-msg reload` instead
(*it's faster and usually works just as good as restart*).



