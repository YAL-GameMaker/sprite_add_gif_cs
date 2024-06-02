@echo off

if not exist "sprite_add_gif_cs-for-GMS1" mkdir "sprite_add_gif_cs-for-GMS1"
cmd /C copyre ..\sprite_add_gif_cs.gmx\extensions\sprite_add_gif_cs.extension.gmx sprite_add_gif_cs-for-GMS1\sprite_add_gif_cs.extension.gmx
cmd /C copyre ..\sprite_add_gif_cs.gmx\extensions\sprite_add_gif_cs sprite_add_gif_cs-for-GMS1\sprite_add_gif_cs
cmd /C copyre ..\sprite_add_gif_cs.gmx\datafiles\sprite_add_gif_cs.html sprite_add_gif_cs-for-GMS1\sprite_add_gif_cs\Assets\datafiles\sprite_add_gif_cs.html
cd sprite_add_gif_cs-for-GMS1
cmd /C 7z a sprite_add_gif_cs-for-GMS1.7z *
move /Y sprite_add_gif_cs-for-GMS1.7z ../sprite_add_gif_cs-for-GMS1.gmez
cd ..

if not exist "sprite_add_gif_cs-for-GMS2\extensions" mkdir "sprite_add_gif_cs-for-GMS2\extensions"
if not exist "sprite_add_gif_cs-for-GMS2\datafiles" mkdir "sprite_add_gif_cs-for-GMS2\datafiles"
if not exist "sprite_add_gif_cs-for-GMS2\datafiles_yy" mkdir "sprite_add_gif_cs-for-GMS2\datafiles_yy"
cmd /C copyre ..\sprite_add_gif_cs_yy\extensions\sprite_add_gif_cs sprite_add_gif_cs-for-GMS2\extensions\sprite_add_gif_cs
cmd /C copyre ..\sprite_add_gif_cs_yy\datafiles\sprite_add_gif_cs.html sprite_add_gif_cs-for-GMS2\datafiles\sprite_add_gif_cs.html
cmd /C copyre ..\sprite_add_gif_cs_yy\datafiles_yy\sprite_add_gif_cs.html.yy sprite_add_gif_cs-for-GMS2\datafiles_yy\sprite_add_gif_cs.html.yy
cd sprite_add_gif_cs-for-GMS2
cmd /C 7z a sprite_add_gif_cs-for-GMS2.zip *
move /Y sprite_add_gif_cs-for-GMS2.zip ../sprite_add_gif_cs-for-GMS2.yymp
cd ..

if not exist "sprite_add_gif_cs-for-GMS2.3+\extensions" mkdir "sprite_add_gif_cs-for-GMS2.3+\extensions"
if not exist "sprite_add_gif_cs-for-GMS2.3+\datafiles" mkdir "sprite_add_gif_cs-for-GMS2.3+\datafiles"
cmd /C copyre ..\sprite_add_gif_cs_23\extensions\sprite_add_gif_cs sprite_add_gif_cs-for-GMS2.3+\extensions\sprite_add_gif_cs
cmd /C copyre ..\sprite_add_gif_cs_23\datafiles\sprite_add_gif_cs.html sprite_add_gif_cs-for-GMS2.3+\datafiles\sprite_add_gif_cs.html
cd sprite_add_gif_cs-for-GMS2.3+
cmd /C 7z a sprite_add_gif_cs-for-GMS2.3+.zip *
move /Y sprite_add_gif_cs-for-GMS2.3+.zip ../sprite_add_gif_cs-for-GMS2.3+.yymps
cd ..

pause