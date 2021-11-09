@echo off

rem temp build files dir
set bld=".build"

rem source paths definition
set src="src"
set manifest="meta-inf"/"manifest.mf"

rem compilation output dir for classes
set outdir="out"
set libdir="lib"
set libname="app"

rem temp source file list for build
set srclst=".srclst"

rem re-create all required directories
rd %bld% /s /q 2>nul 
rd %outdir% /s /q 2>nul

md %bld% 2>nul
md %outdir% 2>nul
md %libdir% 2>nul

rem recursively get all paths to .java files
dir /s /B  *.java > "%bld%/%srclst%"

rem invoke the compiler to compile the sources 
javac -sourcepath %src% @"%bld%/%srclst%" -d %outdir%

rem set classpath;
del "%libdir%\%libname%.jar" 2>nul
jar -c -m %manifest% -f "%libdir%/%libname%.jar" -C %outdir% .

@echo off
rem always cleanup the srclist
del "%bld%\%srclst%" 2>nul