# Delphi-DLL-Prototype

Prototype of calling a C++ DLL from Delphi

This project contains 2 directories:
* ex_dll - contains a C++ project which builds a DLL
* TextEditor - a simple Delphi TextEditor desktop app which links to the Delphi DLL

## Building

Use CMake to build the DLL, from the `ex_dll` dir

```
cmake -A Win32 -B build
cmake --build build
```

Configuration above builds as 32-bit application as that is what Spectrum desktop uses and we ultimately want to target that.

Then open the TextEditor in RAD Studio and build it as 32-bit Windows application. I couldn't find a good way to link to the DLL when it is at a different path, all the options I tried in RAD Studio did not work, so instead I have a small script to copy it into place.

1. Ensure the CMake project has been configured
   ```
   cmake -A Win32 -B build
   ```
2. Build and copy the DLL into place
   ```
   ./ex_dll/build_dll.sh
   ```
3. Run the app from RAD studio
