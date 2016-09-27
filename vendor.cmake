set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(VENDOR_SOURCES ${VENDOR_SOURCES}
            ${CMAKE_CURRENT_LIST_DIR}/src/plugin.h
            ${CMAKE_CURRENT_LIST_DIR}/src/core/device.h
            ${CMAKE_CURRENT_LIST_DIR}/src/core/units.h
            ${CMAKE_CURRENT_LIST_DIR}/src/plugin.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/core/device.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/core/units.cpp
            ${CMAKE_CURRENT_LIST_DIR}/src/material.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/components/components.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/controls/controls.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/core/core.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/extras/extras.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/listitems/listitems.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/popups/popups.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/styles/styles.qrc
            ${CMAKE_CURRENT_LIST_DIR}/src/window/window.qrc
            ${CMAKE_CURRENT_LIST_DIR}/icons/core_icons.qrc)
