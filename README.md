# Bash Android utils
Bash functions for android utilities.

## apk-extractor
Functions to search package, get package path and extract apk.

Add the following line in the .bashrc file.
```
source ~/.apk_extractor.sh
```

## logcat
Prints logs from the given keyword using logcat and frida-ps.

Requeriments:
- frida-ps: get pid and package name.
- adb: logcat.

>Note: the script use network connection to frida-server. If you prefer USB connection change `-H 127.0.0.1:1337` to `-U`.

Add the following line in the .bashrc file.
```
source ~/.logcat.sh
```
