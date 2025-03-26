cmake_minimum_required(VERSION 3.10)

project(MyDll)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add the source files to the project
set(SOURCE_FILES
    api.cpp
)

# Add the header files to the project
set(HEADER_FILES
    impl.h
)

find_package(Eigen3 REQUIRED)

# Create the shared library (DLL)
add_library(CppWrapper SHARED ${HEADER_FILES} ${SOURCE_FILES})
target_link_libraries(CppWrapper Eigen3::Eigen)
