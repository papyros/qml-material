file(GLOB QML_FILES *.qml)
file(GLOB JS_FILES *.js)

install(FILES ${QML_FILES} ${JS_FILES} qmldir
        DESTINATION ${QML_INSTALL_DIR}/Material)
install(DIRECTORY fonts icons
        DESTINATION ${QML_INSTALL_DIR}/Material/Extras)

add_subdirectory(Extras)
add_subdirectory(ListItems)
