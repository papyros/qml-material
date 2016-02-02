file(GLOB_RECURSE SOURCES *.cpp *.h)
file(GLOB QML_FILES *.qml)
file(GLOB JS_FILES *.js)

add_library(material SHARED ${SOURCES})
target_link_libraries(material
                      Qt5::Core
                      Qt5::Qml
                      Qt5::Quick
                      ${GTK2_LIBRARIES})

include_directories(${GTK2_INCLUDE_DIRS})

message("${GTK2_INCLUDE_DIRS}")

install(TARGETS material
        DESTINATION ${QML_INSTALL_DIR}/Material)
install(FILES ${QML_FILES} ${JS_FILES} qmldir
        DESTINATION ${QML_INSTALL_DIR}/Material)
install(DIRECTORY fonts icons
        DESTINATION ${QML_INSTALL_DIR}/Material)

add_subdirectory(Extras)
add_subdirectory(ListItems)
