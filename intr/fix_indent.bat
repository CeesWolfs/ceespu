for /r %%v in (*.v) do ASBeautifier.exe "-s2" "%%v" & del "%%v.orig"
