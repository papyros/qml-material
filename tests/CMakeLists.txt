include(ECMMarkAsTest)

set(SOURCES tests.cpp)

set(CMAKE_MACOSX_BUNDLE FALSE)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

add_executable(materialtests ${SOURCES})
target_link_libraries(materialtests Qt5::Core Qt5::Qml Qt5::Quick Qt5::Test Qt5::QuickTest)

add_test(NAME material COMMAND materialtests -import ${CMAKE_SOURCE_DIR}/modules)
ecm_mark_as_test(materialtests)
