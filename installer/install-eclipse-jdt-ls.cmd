@echo off

cd %~dp0
if exist "..\servers\eclipse-jdt-ls" rd /S /Q  "..\servers\eclipse-jdt-ls"
md "..\servers\eclipse-jdt-ls"
cd "..\servers\eclipse-jdt-ls"
curl -o "jdt-language-server-latest.tar.gz" "http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz"
curl -o "lombok.jar" "https://projectlombok.org/downloads/lombok.jar"
copy ..\..\installer\jdt-language-server-latest.tar.gz > NUL
tar xvf jdt-language-server-latest.tar.gz
del jdt-language-server-latest.tar.gz

echo @echo off ^

setlocal enabledelayedexpansion ^

cd %%~dp0 ^

for %%%%F in (plugins/org.eclipse.equinox.launcher*.jar) do ( ^

  set launcher=plugins/%%%%F ^

) ^

java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.protocol=true -Dlog.level=ALL -noverify -Xmx1G -javaagent:%%~dp0/lombok.jar -Xbootclasspath/a:%%~dp0/lombok.jar -jar %%~dp0\!launcher! -configuration %%~dp0\config_win -data %%~dp0\data ^

> eclipse-jdt-ls.cmd
