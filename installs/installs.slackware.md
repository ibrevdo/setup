### TODO: git bash autocompletion
```
For Git, I followed: https://git-scm.com/book/en/v1/Git-B...ips-and-Tricks

git is a special case as it doesn't install bash completion stuff in the usual places by default: so yes, if you prefer you can copy its git-completion.bash in /etc/bash_completion.d or ~/.config/bash_completion

for example git, the useful stuff is in /usr/doc/git-2.9.0/contrib/completion/
```


### qtcreator 06/05/22
* tried to install from alinebob repo : qtcreator-5.0.0-x86_64-1alien
* but seems that the installed version cannot use system libclang.so
```
/usr/lib64/qtcreator/clangbackend: error while loading shared libraries: libclang.so.12: cannot open shared object file: No such file or directory
2022-05-06T10:18:26 Clang Code Model: Error: The clangbackend executable "/usr/lib64/qtcreator/clangbackend" could not be started (timeout after 10000ms).
```
* uninstalled. For now using locally downloaded version 4.12, which is working correctly

### calibre 05/05/22
* installed from alienbob repo : calibre-5.39.0-x86_64-1alien

### feh 05/05/22
* `sbopkg -i imlib2 feh:EXIF=yes`
* installed imlib2-1.7.4-x86_64-1_SBo, feh-3.6.1-x86_64-1_SBo

### meld 05/05/22
* installed meld-1.8.6-x86_64-1_SBo

### smplayer 05/05/22
* installed smplayer-21.10.0-x86_64-1_SBo

### sbopkg 05/05/22
* installed sbopkg as slackware package
* synced local repo

### bash_completion 04/05/22
* installed bash completion from extra
* in order to enable it, needed to source from ~/.bashrc

### libreoffice 03/05/22
* installed libreoffice from alienbob repo (using slackpg+ config)
* it was crashing with "application error". needed to run it once from terminal with: `export MESA_LOADER_DRIVER_OVERRIDE=i965`
* from here: <https://www.linuxquestions.org/questions/slackware-14/libreoffice-fails-to-start-on-a-current-clean-install-4175686554/page4.html>

### slackpg+ 03/05/22
* installed slackpg+
* enabled repos of restricted, alien

### to restart plasma
from here : <https://bugs.kde.org/show_bug.cgi?id=427861>
kquitapp5 plasmashell; kstart5 plasmashell

or 
```
#!/bin/sh
kquitapp5 plasmashell
cp /home/username/.config/plasma-org.kde.plasma.desktop-appletsrc.1 /home/username/.config/plasma-org.kde.plasma.desktop-appletsrc
kstart5 plasmashell
```
