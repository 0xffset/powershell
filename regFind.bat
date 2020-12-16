dir \/s/b | find /"password"
dir \/b /s "*.bat"
dir \/b /s "*.cmd"
dir \/b /s "*.vbs"
dir \/b /s "*.vba"
dir \/b /s "*.vbe"
dir \/b /s "*.ps1"
dir \/b /s "*.config"
dir \/b /s "*.ini"
dir /s "*pass* == *cred* == *vnc* == *.config*
findstr /si password *.xml *.ini *.txt