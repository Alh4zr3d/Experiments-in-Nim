type
    HANDLE* = int
    HWND* = HANDLE
    UINT* = int32
    LPCSTR* = cstring

proc MessageBox*(hWnd: HWND, lpText: LPCSTR, lpCaption: LPCSTR, uType: UINT): int32
    {.discardable, stdcall, dynlib: "user32", importc: "MessageBoxA".}

MessageBox(0, "Hello, world!", "Cthulhu fhtagn!", 0)