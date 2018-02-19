call c:\batch\setpath.bat FBWIN

make DEBUG=1 everything
if ERRORLEVEL 1 goto DONE

:DONE

