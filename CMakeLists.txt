cmake_minimum_required(VERSION 3.18)
project(MobileCppApp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置输出目录
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# 包含目录
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# 源文件
file(GLOB_RECURSE SOURCES 
    "src/*.cpp"
    "src/*.c"
)

file(GLOB_RECURSE HEADERS 
    "include/*.h"
    "include/*.hpp"
)

# 创建共享库
add_library(mobile_cpp_lib SHARED ${SOURCES} ${HEADERS})

# Android特定配置
if(ANDROID)
    target_compile_definitions(mobile_cpp_lib PRIVATE ANDROID_PLATFORM)
    set_target_properties(mobile_cpp_lib PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${ANDROID_ABI}"
    )
endif()

# iOS特定配置
if(IOS)
    target_compile_definitions(mobile_cpp_lib PRIVATE IOS_PLATFORM)
    set_target_properties(mobile_cpp_lib PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION A
        MACOSX_FRAMEWORK_IDENTIFIER com.mobileapp.framework
    )
endif()

# 链接库
target_link_libraries(mobile_cpp_lib)

