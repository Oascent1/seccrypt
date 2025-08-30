@echo off
echo Building SecureCrypt executable...

:: Create version file for executable metadata
echo # UTF-8 > version.txt
echo. >> version.txt
echo VSVersionInfo( >> version.txt
echo   ffi=FixedFileInfo( >> version.txt
echo     filevers=(2, 0, 0, 0), >> version.txt
echo     prodvers=(2, 0, 0, 0), >> version.txt
echo     mask=0x3f, >> version.txt
echo     flags=0x0, >> version.txt
echo     OS=0x40004, >> version.txt
echo     fileType=0x1, >> version.txt
echo     subtype=0x0, >> version.txt
echo     date=(0, 0) >> version.txt
echo   ), >> version.txt
echo   kids=[ >> version.txt
echo     StringFileInfo( >> version.txt
echo       [ >> version.txt
echo         StringTable( >> version.txt
echo           u'040904B0', >> version.txt
echo           [StringStruct(u'CompanyName', u'SecureCrypt Pro'), >> version.txt
echo           StringStruct(u'FileDescription', u'Secure File Encryption Tool'), >> version.txt
echo           StringStruct(u'FileVersion', u'2.0.0.0'), >> version.txt
echo           StringStruct(u'InternalName', u'SecureCryptPro'), >> version.txt
echo           StringStruct(u'LegalCopyright', u'Copyright 2023 SecureCrypt Pro'), >> version.txt
echo           StringStruct(u'OriginalFilename', u'SecureCryptPro.exe'), >> version.txt
echo           StringStruct(u'ProductName', u'SecureCrypt Pro'), >> version.txt
echo           StringStruct(u'ProductVersion', u'2.0.0.0')] >> version.txt
echo         ) >> version.txt
echo       ] >> version.txt
echo     ), >> version.txt
echo     VarFileInfo([VarStruct(u'Translation', [1033, 1200])]) >> version.txt
echo   ] >> version.txt
echo ) >> version.txt

:: Create a temporary spec file with the required settings
echo # -*- mode: python ; coding: utf-8 -*- > temp_spec.spec
echo. >> temp_spec.spec
echo a = Analysis( >> temp_spec.spec
echo     ['app.py'], >> temp_spec.spec
echo     pathex=[], >> temp_spec.spec
echo     binaries=[], >> temp_spec.spec
echo     datas=[('templates', 'templates'), ('static', 'static')], >> temp_spec.spec
echo     hiddenimports=['waitress', 'psutil', 'Crypto', 'Crypto.PublicKey', 'Crypto.Signature', 'Crypto.Hash'], >> temp_spec.spec
echo     hookspath=[], >> temp_spec.spec
echo     hooksconfig={}, >> temp_spec.spec
echo     runtime_hooks=[], >> temp_spec.spec
echo     excludes=[], >> temp_spec.spec
echo     noarchive=False, >> temp_spec.spec
echo     optimize=0, >> temp_spec.spec
echo ) >> temp_spec.spec
echo pyz = PYZ(a.pure) >> temp_spec.spec
echo. >> temp_spec.spec
echo exe = EXE( >> temp_spec.spec
echo     pyz, >> temp_spec.spec
echo     a.scripts, >> temp_spec.spec
echo     a.binaries, >> temp_spec.spec
echo     a.datas, >> temp_spec.spec
echo     [], >> temp_spec.spec
echo     name='SecureCryptPro', >> temp_spec.spec
echo     debug=False, >> temp_spec.spec
echo     bootloader_ignore_signals=False, >> temp_spec.spec
echo     strip=False, >> temp_spec.spec
echo     upx=True, >> temp_spec.spec
echo     upx_exclude=[], >> temp_spec.spec
echo     runtime_tmpdir=None, >> temp_spec.spec
echo     console=True,  >> temp_spec.spec
echo     disable_windowed_traceback=False, >> temp_spec.spec
echo     argv_emulation=False, >> temp_spec.spec
echo     target_arch=None, >> temp_spec.spec
echo     codesign_identity=None, >> temp_spec.spec
echo     entitlements_file=None, >> temp_spec.spec
echo     version='version.txt'  # Version metadata >> temp_spec.spec
echo ) >> temp_spec.spec

:: Use the temporary spec file to build
pyinstaller temp_spec.spec

:: Clean up temporary files
del temp_spec.spec
del version.txt
rmdir /s /q build

echo Build complete! The executable 'SecureCryptPro.exe' is in the 'dist' folder.
echo.
echo Note: If Windows Defender flags the executable, you may need to:
echo 1. Add an exclusion for the file/folder in Windows Security
echo 2. Submit the file to Microsoft for analysis: https://www.microsoft.com/en-us/wdsi/filesubmission
pause