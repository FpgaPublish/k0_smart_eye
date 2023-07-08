QT       += core gui
QT       += network
QT       += multimedia multimediawidgets
QT       += serialport
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    src/file_mdle/file_mdle.cpp \
    src/flow_blck/flow_blck.cpp \
    src/fpga_subs/fpga_subs.cpp \
    src/uart_blck/uart_blck.cpp \
    src/udp_subs/udp_subs.cpp \
    src/uvc_blck/uvc_blck.cpp \
    src/uvc_blck/videosurface_driv/videosurface_driv.cpp \
    src/welcome_mdle/welcome_mdle.cpp

HEADERS += \
    mainwindow.h \
    src/MACRO.h \
    src/file_mdle/file_mdle.h \
    src/flow_blck/flow_blck.h \
    src/fpga_subs/fpga_subs.h \
    src/uart_blck/uart_blck.h \
    src/udp_subs/udp_subs.h \
    src/uvc_blck/uvc_blck.h \
    src/uvc_blck/videosurface_driv/videosurface_driv.h \
    src/welcome_mdle/welcome_mdle.h

FORMS += \
    mainwindow.ui \
    src/file_mdle/file_mdle.ui \
    src/flow_blck/flow_blck.ui \
    src/fpga_subs/fpga_subs.ui \
    src/uart_blck/uart_blck.ui \
    src/udp_subs/udp_subs.ui \
    src/uvc_blck/uvc_blck.ui \
    src/welcome_mdle/welcome_mdle.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES +=
