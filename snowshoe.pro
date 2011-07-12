TEMPLATE = app
TARGET = snowshoe

QT += declarative

SOURCES += \
    main.cpp \
    BrowserWindow.cpp \
    PageWidget.cpp \
    DeclarativeDesktopWebView.cpp

HEADERS += \
    BrowserWindow.h \
    PageWidget.h \
    DeclarativeDesktopWebView.h

RESOURCES += \
    snowshoe.qrc

MOC_DIR = .moc/
RCC_DIR = .rcc/
OBJECTS_DIR = .obj/

WEBKIT_SOURCE_DIR = $$(WEBKIT_SOURCE_DIR)
isEmpty(WEBKIT_SOURCE_DIR) {
    error(Please set WEBKIT_SOURCE_DIR environment variable)
} else {
    message(Using WebKit source from $$WEBKIT_SOURCE_DIR)
}

WEBKIT_BUILD_DIR = $$(WEBKIT_BUILD_DIR)
isEmpty(WEBKIT_BUILD_DIR) {
    WEBKIT_BUILD_DIR = $$WEBKIT_SOURCE_DIR/WebKitBuild/Release
}

message(Using WebKit build from $$WEBKIT_BUILD_DIR)

INCLUDEPATH += $$WEBKIT_SOURCE_DIR/Source/
INCLUDEPATH += $$WEBKIT_SOURCE_DIR/Source/WebKit2/UIProcess/API/qt
INCLUDEPATH += $$WEBKIT_SOURCE_DIR/Source/WebKit2/UIProcess/API/C
INCLUDEPATH += $$WEBKIT_SOURCE_DIR/Source/WebKit2/UIProcess/API/cpp
INCLUDEPATH += $$WEBKIT_SOURCE_DIR/Source/WebKit/qt/Api

INCLUDEPATH += $$WEBKIT_BUILD_DIR/include/
INCLUDEPATH += $$WEBKIT_BUILD_DIR/include/WebKit2

# WebKit needs to be the first, just in case the Qt build contains already a QtWebKit.
QMAKE_LFLAGS = -L$$WEBKIT_BUILD_DIR/lib $$QMAKE_LFLAGS

macx {
    LIBS += -framework QtWebKit
} else {
    # Make sure that again the custom WebKit is the first in the rpath otherwise it will not pick the right one.
    unix : QMAKE_RPATHDIR = $$WEBKIT_BUILD_DIR/lib $$QMAKE_RPATHDIR
    LIBS += -lQtWebKit
}

OTHER_FILES += \
    qml/main.qml \
    qml/UrlEdit.qml \
    qml/UrlBar.qml