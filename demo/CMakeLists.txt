project(Demo)
cmake_minimum_required(VERSION 2.8)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(CMAKE_AUTOMOC on)
set(CMAKE_AUTORCC on)

add_subdirectory(../ ${CMAKE_CURRENT_BINARY_DIR}/Material)

find_package(Qt5Quick REQUIRED)
set(
    DemoSrc
    main.cpp
)

set(
    DemoRcc
    demo.qrc
)

add_executable(${PROJECT_NAME} ${DemoRcc} ${DemoSrc})
target_link_libraries(${PROJECT_NAME} Material)

qt5_use_modules(${PROJECT_NAME} Quick )
