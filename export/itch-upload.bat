@echo off
set /p ver="Version?: "
echo Uploading %ver%...
set user=yellowafterlife
set ext=gamemaker-sprite_add_gif_cs
cmd /C itchio-butler push sprite_add_gif_cs-for-GMS1.gmez %user%/%ext%:gms1 --userversion=%ver%
cmd /C itchio-butler push sprite_add_gif_cs-for-GMS2.yymp %user%/%ext%:gms2 --userversion=%ver%
cmd /C itchio-butler push sprite_add_gif_cs-for-GMS2.3+.yymps %user%/%ext%:gms2.3 --userversion=%ver%

pause