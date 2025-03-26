#include "impl.h"
#include <unsupported/Eigen/CXX11/Tensor>
#include <windows.h>

#define DllExport extern "C"
#define EXPORT comment(linker, "/EXPORT:" __FUNCTION__ "=" __FUNCDNAME__)

DllExport int WINAPI add(int a, int b) {
    #pragma EXPORT
    return adder(a, b);
}

DllExport double WINAPI addArrays(double* dataA, double* dataB, int d1, int d2) {
    #pragma EXPORT
    Eigen::TensorMap<Eigen::Tensor<double, 2>> tensorA(dataA, d1, d2);
    Eigen::TensorMap<Eigen::Tensor<double, 2>> tensorB(dataB, d1, d2);

    double out = 0.0;
    for (int i = 0; i < d1; ++i) {
        for (int j = 0; j < d2; ++j) {
            out += tensorA(i, j) + tensorB(i, j);
        }
    }
    return out;
}
