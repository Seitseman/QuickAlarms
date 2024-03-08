cmake_minimum_required(VERSION 3.16)

project(Alarms VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

find_package(Qt6 6.7 COMPONENTS Quick REQUIRED)
qt_standard_project_setup()

qt_add_executable(appAlarms
    main.cpp
)

#conf.qrc
set(qml_resource_files
    "AlarmDelegate.qml"
    "AlarmDialog.qml"
    "AlarmModel.qml"
    "TumblerDelegate.qml"
    "main.qml"
)

qt_add_resources(appAlarms "qml"
    PREFIX
        "/alarms/"
    FILES
        ${qml_resource_files}
)

qt_add_resources(appAlarms "controls_conf"
    PREFIX
        "/"
    FILES
        "qtquickcontrols2.conf"
)

qt_add_qml_module(appAlarms
    URI Alarms
    VERSION 1.0
    QML_FILES
        main.qml
        AlarmDialog.qml
        AlarmModel.qml
        TumblerDelegate.qml
    RESOURCES
        qtquickcontrols2.conf
)

set_target_properties(appAlarms PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appAlarms
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appAlarms PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
)
