# Microsoft Developer Studio Project File - Name="vector" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) External Target" 0x0106

CFG=vector - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "vector.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "vector.mak" CFG="vector - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "vector - Win32 Release" (based on "Win32 (x86) External Target")
!MESSAGE "vector - Win32 Debug" (based on "Win32 (x86) External Target")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""

!IF  "$(CFG)" == "vector - Win32 Release"

# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Cmd_Line "NMAKE /f vector.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "vector.exe"
# PROP BASE Bsc_Name "vector.bsc"
# PROP BASE Target_Dir ""
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Cmd_Line "NMAKE /f vector.mak"
# PROP Rebuild_Opt "/a"
# PROP Target_File "vector.exe"
# PROP Bsc_Name "vector.bsc"
# PROP Target_Dir ""

!ELSEIF  "$(CFG)" == "vector - Win32 Debug"

# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Cmd_Line "NMAKE /f vector.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "vector.exe"
# PROP BASE Bsc_Name "vector.bsc"
# PROP BASE Target_Dir ""
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Cmd_Line "e:\fb\vector\mk.bat"
# PROP Rebuild_Opt ""
# PROP Target_File "e:\fb\vector\lib\win32\libvector.a"
# PROP Bsc_Name ""
# PROP Target_Dir ""

!ENDIF 

# Begin Target

# Name "vector - Win32 Release"
# Name "vector - Win32 Debug"

!IF  "$(CFG)" == "vector - Win32 Release"

!ELSEIF  "$(CFG)" == "vector - Win32 Debug"

!ENDIF 

# Begin Group "build"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\.gitignore
# End Source File
# Begin Source File

SOURCE=.\.gitmodules
# End Source File
# Begin Source File

SOURCE=.\changelog.txt
# End Source File
# Begin Source File

SOURCE=.\library.inc
# End Source File
# Begin Source File

SOURCE=.\makefile
# End Source File
# Begin Source File

SOURCE=.\mk.bat
# End Source File
# Begin Source File

SOURCE=.\readme.txt
# End Source File
# End Group
# Begin Group "src"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\src\makefile
# End Source File
# Begin Source File

SOURCE=.\src\mk.bat
# End Source File
# Begin Source File

SOURCE=.\src\vector.bas
# End Source File
# End Group
# Begin Group "inc"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\inc\vector.bi
# End Source File
# End Group
# Begin Group "tests"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\tests\.gitignore
# End Source File
# Begin Source File

SOURCE=.\tests\makefile
# End Source File
# Begin Source File

SOURCE=.\tests\mk.bat
# End Source File
# Begin Source File

SOURCE=.\tests\tests.bas
# End Source File
# End Group
# End Target
# End Project
