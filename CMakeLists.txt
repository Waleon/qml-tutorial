cmake_minimum_required(VERSION 3.14)

set(PROJECT "qmltutorial")
project(${PROJECT})

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Gui Qml Quick)

file(GLOB HEADER_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
file(GLOB SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

qt_add_resources(QRC_FILES qmltutorial.qrc)

qt_add_executable(${PROJECT} ${HEADER_FILES} ${SOURCE_FILES} ${QRC_FILES})

target_link_libraries(${PROJECT} PRIVATE Qt6::Gui Qt6::Qml Qt6::Quick)
