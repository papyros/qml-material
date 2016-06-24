project(Material)
cmake_minimum_required(VERSION 2.8)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(CMAKE_AUTOMOC on)
set(CMAKE_AUTORCC on)

find_package(Qt5Quick REQUIRED)

add_definitions(-DQPM_INIT)

set(
    Headers
    ${CMAKE_CURRENT_SOURCE_DIR}/src/plugin.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/device.h
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/units.h
)
set(
    Src
    ${CMAKE_CURRENT_SOURCE_DIR}/src/plugin.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/device.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/units.cpp
)

set(MaterialRCC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/material.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/components/components.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/controls/controls.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/core/core.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/extras/extras.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/listitems/listitems.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/popups/popups.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/styles/styles.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/src/window/window.qrc
    ${CMAKE_CURRENT_SOURCE_DIR}/icons/core_icons.qrc
)

add_library(${PROJECT_NAME} SHARED ${Src} ${Headers} ${MaterialRCC})

qt5_use_modules(${PROJECT_NAME} Quick )
