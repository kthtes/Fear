TEMPLATE = app

QT += qml quick multimedia
CONFIG += c++11 resources_big

CONFIG-=app_bundle

SOURCES += main.cpp b2file.cpp b2imageutil.cpp

HEADERS += b2file.h b2imageutil.h

RESOURCES += qml.qrc \
    res.qrc \
    scr.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
