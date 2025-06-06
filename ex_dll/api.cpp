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

DllExport void WINAPI addArraysInPlace(double* dataA, double* dataB, int d1, int d2, double* out) {
    #pragma EXPORT
    Eigen::TensorMap<Eigen::Tensor<double, 2>> tensorA(dataA, d1, d2);
    Eigen::TensorMap<Eigen::Tensor<double, 2>> tensorB(dataB, d1, d2);
    Eigen::TensorMap<Eigen::Tensor<double, 2>> outTensor(out, d1, d2);

    for (int i = 0; i < d1; ++i) {
        for (int j = 0; j < d2; ++j) {
            outTensor(i, j) = tensorA(i, j) + tensorB(i, j);
        }
    }
}

DllExport HRESULT WINAPI useSafecall(int i) {
    #pragma EXPORT
    if (i == 2) {
        return DISP_E_OVERFLOW;
    } else {
        return S_OK;
    }
}

#pragma pack(push, 8)
struct ArrayPair {
    double* A;
    double* B;
    int D1;
    int D2;
};

DllExport HRESULT WINAPI addPair(ArrayPair& pair, double* outData) {
    #pragma EXPORT
    if (!pair.A || !pair.B || !outData) {
        return E_POINTER;
    }
    Eigen::TensorMap<Eigen::Tensor<double, 2>> tensorA(pair.A, pair.D1, pair.D2);
    Eigen::TensorMap<Eigen::Tensor<double, 2>> tensorB(pair.B, pair.D1, pair.D2);
    Eigen::TensorMap<Eigen::Tensor<double, 2>> outTensor(outData, pair.D1, pair.D2);
    for (int i = 0; i < pair.D1; ++i) {
        for (int j = 0; j < pair.D2; ++j) {
            outTensor(i, j) = tensorA(i, j) + tensorB(i, j);
        }
    }
    return S_OK;
}

typedef void (WINAPI *CallbackFunction)(const char*);

DllExport HRESULT WINAPI callCallback(CallbackFunction fn) {
    #pragma EXPORT
    std::string myMsg = "Here is my message from C++";
    fn(myMsg.c_str());
    return S_OK;
}
