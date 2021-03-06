!include "x64.nsh" 

; Installer settings
SetCompressor /SOLID lzma
SetDatablockOptimize on
VIProductVersion "2.56.111.0"
VIAddVersionKey "ProductName" "Aquamark3"
VIAddVersionKey "Comments" "This setup will install Aquamark3 and its dependencies."
VIAddVersionKey "CompanyName" "GENiEBEN"
VIAddVersionKey "FileVersion" "2.56.111"

XPStyle on

; The name of the installer
Name "Install Aquamark3 v2.56.111"
BrandingText "(c) 2012-2014 GENiEBEN"

; The file to write
OutFile "Install Aquamark³.exe"

; The default installation directory
InstallDir $PROGRAMFILES\GENiEBEN\UBW

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKCU "Software\GENiEBEN\UBW\Aquamark3" "InstallLocation"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

;--------------------------------

; Pages

Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Main Files (required)"

	SectionIn RO

	; Set output path to the installation directory.-
	SetOutPath $INSTDIR

	; Create directories
	CreateDirectory "$INSTDIR\benchmark"
	CreateDirectory "$INSTDIR\benchmark\docs"
	CreateDirectory "$INSTDIR\benchmark\pak"
	CreateDirectory "$INSTDIR\platforms"
	CreateDirectory "$INSTDIR\wget"

	; Put file there
	File /r "src\release\benchmark\aquamark3"
	File /r "src\release\wget"
	File /r "src\release\plugins"
	File /r "src\release\*.dll"
	File /r "src\release\*.exe"
	File /r "src\release\*.reg"
	File /r "src\release\*.manifest"

	; Write application settings into registry
	
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "InstallLocation" "$INSTDIR"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "Background" ""
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "ProcessPrio" "High"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "SystemInfo" "Enabled"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "Theme" "Fusion (Dark)"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "Screenshot" "JPG"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW" "SS_Quality" "80"
	
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW_Aquamark3" "InstallLocation" "$INSTDIR\benchmark\aquamark3"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW_Aquamark3" "HideError" "True"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW_Aquamark3" "HideLogo" "True"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW_Aquamark3" "OSDStats" "True"
	WriteRegStr HKCU "SOFTWARE\GENiEBEN\UBW_Aquamark3" "RunMode" "AUTO"


	; Write the uninstall keys for Windows
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "DisplayName" "HWBOT Aquamark3"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "DisplayVersion" "2.56.111"  
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "DisplayIcon" "$INSTDIR\ubw.exe"   
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "UninstallString" "$INSTDIR\uninstall.exe"  

	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "URLInfoAbout" "http:\\elgenieben.blogspot.com"   
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "URLUpdateInfo" "http:\\forum.hwbot.org\showthread.php?t=67632"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "Publisher" "GENiEBEN"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "HelpLink" "http:\\forum.hwbot.org\forumdisplay.php?f=110"  
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3" "NoRepair" 1
	WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Shortcuts"
	CreateDirectory "$SMPROGRAMS\GENiEBEN\Aquamark3"
	CreateShortCut "$SMPROGRAMS\GENiEBEN\Aquamark3\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
	CreateShortCut "$SMPROGRAMS\GENiEBEN\Aquamark3\HWBOT Aquamark3.lnk" "$INSTDIR\ubw.exe" "" "$INSTDIR\ubw.exe" 0
	CreateShortCut "$DESKTOP\Aquamark3.lnk" "$INSTDIR\ubw.exe" "" "$INSTDIR\ubw.exe" 0
SectionEnd


; These are the programs that are needed to run properly
SubSection "Prerequisites"
	Section "Visual C++ 2008"
		CreateDirectory "$INSTDIR\redis"
		SetOutPath "$INSTDIR\redis"
		File "src\release\redis\vcredist_2008_x64.exe"
		File "src\release\redis\vcredist_2008_x86.exe"
		ExecWait "$INSTDIR\redis\vcredist_2008_x86.exe /q"
		${if} ${RunningX64}
		ExecWait "$INSTDIR\redis\vcredist_2008_x64.exe /q"	
		${endif}
		RMDir /r "$INSTDIR\redis"
		;delete temp files
		Delete "C:\install.exe"
		Delete "C:\install.res.1028.dll"
		Delete "C:\install.res.1031.dll"
		Delete "C:\install.res.1033.dll"
		Delete "C:\install.res.1036.dll"
		Delete "C:\install.res.1040.dll"
		Delete "C:\install.res.1041.dll"
		Delete "C:\install.res.1042.dll"
		Delete "C:\install.res.2052.dll"
		Delete "C:\install.res.3082.dll"
		Delete "C:\vcredist.bmp"
		Delete "C:\globdata.ini"
		Delete "C:\install.ini"
		Delete "C:\eula.1028.txt"
		Delete "C:\eula.1031.txt"
		Delete "C:\eula.1033.txt"
		Delete "C:\eula.1036.txt"
		Delete "C:\eula.1040.txt"
		Delete "C:\eula.1041.txt"
		Delete "C:\eula.1042.txt"
		Delete "C:\eula.2052.txt"
		Delete "C:\eula.3082.txt"
		Delete "C:\VC_RED.MSI"
		Delete "C:\VC_RED.cab"
		Delete "D:\install.exe"
		Delete "D:\install.res.1028.dll"
		Delete "D:\install.res.1031.dll"
		Delete "D:\install.res.1033.dll"
		Delete "D:\install.res.1036.dll"
		Delete "D:\install.res.1040.dll"
		Delete "D:\install.res.1041.dll"
		Delete "D:\install.res.1042.dll"
		Delete "D:\install.res.2052.dll"
		Delete "D:\install.res.3082.dll"
		Delete "D:\vcredist.bmp"
		Delete "D:\globdata.ini"
		Delete "D:\install.ini"
		Delete "D:\eula.1028.txt"
		Delete "D:\eula.1031.txt"
		Delete "D:\eula.1033.txt"
		Delete "D:\eula.1036.txt"
		Delete "D:\eula.1040.txt"
		Delete "D:\eula.1041.txt"
		Delete "D:\eula.1042.txt"
		Delete "D:\eula.2052.txt"
		Delete "D:\eula.3082.txt"
		Delete "D:\VC_RED.MSI"
		Delete "D:\VC_RED.cab"
	SectionEnd
	Section "Visual C++ 2010"
		CreateDirectory "$INSTDIR\redis"
		SetOutPath "$INSTDIR\redis"
		File "src\release\redis\vcredist_2010_x64.exe"
		File "src\release\redis\vcredist_2010_x86.exe"
		ExecWait "$INSTDIR\redis\vcredist_2010_x86.exe /q"
		${if} ${RunningX64}
		ExecWait "$INSTDIR\redis\vcredist_2010_x64.exe /q"
		${endif}
		RMDir /r "$INSTDIR\redis"
	SectionEnd
SubSectionEnd
;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\UBW_Aquamark3"
  DeleteRegKey HKLM "SOFTWARE\GENiEBEN\UBW\Aquamark3"

  ; Remove files and uninstaller
  Delete "$INSTDIR\*.*"
  Delete "$DESKTOP\Aquamark3.lnk"

  ; Remove directories used
  RMDir /r "$SMPROGRAMS\GENiEBEN\Aquamark3\"
  RMDir /r "$INSTDIR"

SectionEnd
