# Microsoft Developer Studio Project File - Name="libgb" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libgb - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libgb.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libgb.mak" CFG="libgb - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libgb - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libgb - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libgb - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /MD /W3 /O2 /D "NDEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /D "SYSV" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x407 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /MD /W3 /Gm /ZI /Od /D "_DEBUG" /D "WIN32" /D "_MBCS" /D "_LIB" /D "SYSV" /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x407 /d "_DEBUG"
# ADD RSC /l 0x407 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "libgb - Win32 Release"
# Name "libgb - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\gb_basic.c
# End Source File
# Begin Source File

SOURCE=.\gb_books.c
# End Source File
# Begin Source File

SOURCE=.\gb_dijk.c
# End Source File
# Begin Source File

SOURCE=.\gb_econ.c
# End Source File
# Begin Source File

SOURCE=.\gb_flip.c
# End Source File
# Begin Source File

SOURCE=.\gb_games.c
# End Source File
# Begin Source File

SOURCE=.\gb_gates.c
# End Source File
# Begin Source File

SOURCE=.\gb_graph.c
# End Source File
# Begin Source File

SOURCE=.\gb_io.c
# End Source File
# Begin Source File

SOURCE=.\gb_lisa.c
# End Source File
# Begin Source File

SOURCE=.\gb_miles.c
# End Source File
# Begin Source File

SOURCE=.\gb_plane.c
# End Source File
# Begin Source File

SOURCE=.\gb_raman.c
# End Source File
# Begin Source File

SOURCE=.\gb_rand.c
# End Source File
# Begin Source File

SOURCE=.\gb_roget.c
# End Source File
# Begin Source File

SOURCE=.\gb_save.c
# End Source File
# Begin Source File

SOURCE=.\gb_sort.c
# End Source File
# Begin Source File

SOURCE=.\gb_words.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\gb_basic.h
# End Source File
# Begin Source File

SOURCE=.\gb_books.h
# End Source File
# Begin Source File

SOURCE=.\gb_dijk.h
# End Source File
# Begin Source File

SOURCE=.\gb_econ.h
# End Source File
# Begin Source File

SOURCE=.\gb_flip.h
# End Source File
# Begin Source File

SOURCE=.\gb_games.h
# End Source File
# Begin Source File

SOURCE=.\gb_gates.h
# End Source File
# Begin Source File

SOURCE=.\gb_graph.h
# End Source File
# Begin Source File

SOURCE=.\gb_io.h
# End Source File
# Begin Source File

SOURCE=.\gb_lisa.h
# End Source File
# Begin Source File

SOURCE=.\gb_miles.h
# End Source File
# Begin Source File

SOURCE=.\gb_plane.h
# End Source File
# Begin Source File

SOURCE=.\gb_raman.h
# End Source File
# Begin Source File

SOURCE=.\gb_rand.h
# End Source File
# Begin Source File

SOURCE=.\gb_roget.h
# End Source File
# Begin Source File

SOURCE=.\gb_save.h
# End Source File
# Begin Source File

SOURCE=.\gb_sort.h
# End Source File
# Begin Source File

SOURCE=.\gb_words.h
# End Source File
# End Group
# Begin Group "CWEB Files"

# PROP Default_Filter "w;ch"
# Begin Source File

SOURCE=..\gb_basic.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_basic.w
InputName=gb_basic

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_basic.w
InputName=gb_basic

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_books.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_books.w
InputName=gb_books

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_books.w
InputName=gb_books

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_dijk.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_dijk.w
InputName=gb_dijk

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_dijk.w
InputName=gb_dijk

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_econ.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_econ.w
InputName=gb_econ

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_econ.w
InputName=gb_econ

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_flip.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_flip.w
InputName=gb_flip

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_flip.w
InputName=gb_flip

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_games.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_games.w
InputName=gb_games

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_games.w
InputName=gb_games

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_gates.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_gates.w
InputName=gb_gates

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_gates.w
InputName=gb_gates

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_graph.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_graph.w
InputName=gb_graph

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_graph.w
InputName=gb_graph

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_io.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_io.w
InputName=gb_io

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_io.w
InputName=gb_io

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_lisa.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_lisa.w
InputName=gb_lisa

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_lisa.w
InputName=gb_lisa

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_miles.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_miles.w
InputName=gb_miles

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_miles.w
InputName=gb_miles

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_plane.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_plane.w
InputName=gb_plane

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_plane.w
InputName=gb_plane

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_raman.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_raman.w
InputName=gb_raman

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_raman.w
InputName=gb_raman

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_rand.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_rand.w
InputName=gb_rand

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_rand.w
InputName=gb_rand

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_roget.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_roget.w
InputName=gb_roget

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_roget.w
InputName=gb_roget

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_save.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_save.w
InputName=gb_save

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_save.w
InputName=gb_save

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_sort.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_sort.w
InputName=gb_sort

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_sort.w
InputName=gb_sort

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\gb_words.w

!IF  "$(CFG)" == "libgb - Win32 Release"

# Begin Custom Build
InputPath=..\gb_words.w
InputName=gb_words

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "libgb - Win32 Debug"

# Begin Custom Build
InputPath=..\gb_words.w
InputName=gb_words

"$(InputName).c" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	set CWEBINPUTS=.. 
	ctangle ../$(InputName).w ../PROTOTYPES/$(InputName).ch 
	
# End Custom Build

!ENDIF 

# End Source File
# End Group
# End Target
# End Project
