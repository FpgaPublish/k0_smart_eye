//////////////////////////////////////////////////////////////////////////////////
// Company: Fpga Publish
// Engineer: F
//
// Create Date: 2023 12:05:15
// Design Name:
// Module Name: main.cpp
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
//          1. path = D:/demo rather than D:/demo/
//////////////////////////////////////////////////////////////////////////////////
#include "mainwindow.h"
// =====================================================
// file include
#include <QApplication>
#include "./src/MACRO.h"
#include <QStyleFactory>
int main(int argc, char *argv[])
{
    // =====================================================
    // run main window
    QApplication a(argc, argv);
    MainWindow mw;
    mw.setWindowTitle(APP_NAME);
    mw.show();
    // =====================================================
    // theme set
    //set dark
    qApp->setStyle(QStyleFactory::create("Fusion"));
    QPalette palette;
    palette.setColor(QPalette::Window, QColor(53, 53, 53));
    palette.setColor(QPalette::WindowText, Qt::white);
    palette.setColor(QPalette::Base, QColor(15, 15, 15));
    palette.setColor(QPalette::AlternateBase, QColor(53, 53, 53));
    palette.setColor(QPalette::ToolTipBase, Qt::white);
    palette.setColor(QPalette::ToolTipText, Qt::white);
    palette.setColor(QPalette::Text, Qt::white);
    palette.setColor(QPalette::Button, QColor(53, 53, 53));
    palette.setColor(QPalette::ButtonText, Qt::white);
    palette.setColor(QPalette::BrightText, Qt::red);
    //palette.setColor(QPalette::Highlight, QColor(142, 45, 197).lighter()); //紫色
    palette.setColor(QPalette::Highlight, QColor(161, 65, 13).lighter());//橙色
    palette.setColor(QPalette::HighlightedText, Qt::black);
    //palette.setColor(QPalette::Background,Qt::cyan);
    qApp->setPalette(palette);

    //set ICON
    QString p_icon_app = QApplication::applicationDirPath() + "/icons/reco_eye.ico";
    qDebug() << p_icon_app;
    a.setWindowIcon(QIcon(p_icon_app));
    // =====================================================
    // struct list
    //add struct of udp
    qRegisterMetaType<SUdpPck>("SUdpPck");


    // =====================================================
    // still run
    return a.exec();
}
