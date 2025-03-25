#include "impl.h"
#include <windows.h>

extern "C" __declspec(dllexport) int add(int a, int b) {
    return adder(a, b);
}
