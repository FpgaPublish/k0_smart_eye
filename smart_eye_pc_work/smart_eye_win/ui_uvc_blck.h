/********************************************************************************
** Form generated from reading UI file 'uvc_blck.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_UVC_BLCK_H
#define UI_UVC_BLCK_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>
#include "qvideowidget.h"

QT_BEGIN_NAMESPACE

class Ui_uvc_blck
{
public:
    QVBoxLayout *verticalLayout;
    QVideoWidget *ui_display;
    QHBoxLayout *horizontalLayout;
    QLabel *label;
    QComboBox *ui_device;
    QLabel *label_2;
    QComboBox *ui_resolution;
    QLabel *label_3;
    QComboBox *ui_frame;
    QHBoxLayout *horizontalLayout_2;
    QPushButton *ui_read;
    QPushButton *ui_write;
    QPushButton *ui_close;

    void setupUi(QWidget *uvc_blck)
    {
        if (uvc_blck->objectName().isEmpty())
            uvc_blck->setObjectName(QString::fromUtf8("uvc_blck"));
        uvc_blck->resize(682, 572);
        verticalLayout = new QVBoxLayout(uvc_blck);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        ui_display = new QVideoWidget(uvc_blck);
        ui_display->setObjectName(QString::fromUtf8("ui_display"));

        verticalLayout->addWidget(ui_display);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        label = new QLabel(uvc_blck);
        label->setObjectName(QString::fromUtf8("label"));

        horizontalLayout->addWidget(label);

        ui_device = new QComboBox(uvc_blck);
        ui_device->setObjectName(QString::fromUtf8("ui_device"));

        horizontalLayout->addWidget(ui_device);

        label_2 = new QLabel(uvc_blck);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        horizontalLayout->addWidget(label_2);

        ui_resolution = new QComboBox(uvc_blck);
        ui_resolution->setObjectName(QString::fromUtf8("ui_resolution"));

        horizontalLayout->addWidget(ui_resolution);

        label_3 = new QLabel(uvc_blck);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        horizontalLayout->addWidget(label_3);

        ui_frame = new QComboBox(uvc_blck);
        ui_frame->setObjectName(QString::fromUtf8("ui_frame"));

        horizontalLayout->addWidget(ui_frame);


        verticalLayout->addLayout(horizontalLayout);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        ui_read = new QPushButton(uvc_blck);
        ui_read->setObjectName(QString::fromUtf8("ui_read"));

        horizontalLayout_2->addWidget(ui_read);

        ui_write = new QPushButton(uvc_blck);
        ui_write->setObjectName(QString::fromUtf8("ui_write"));

        horizontalLayout_2->addWidget(ui_write);

        ui_close = new QPushButton(uvc_blck);
        ui_close->setObjectName(QString::fromUtf8("ui_close"));

        horizontalLayout_2->addWidget(ui_close);


        verticalLayout->addLayout(horizontalLayout_2);

        verticalLayout->setStretch(0, 6);
        verticalLayout->setStretch(1, 1);
        verticalLayout->setStretch(2, 1);

        retranslateUi(uvc_blck);

        QMetaObject::connectSlotsByName(uvc_blck);
    } // setupUi

    void retranslateUi(QWidget *uvc_blck)
    {
        uvc_blck->setWindowTitle(QApplication::translate("uvc_blck", "Form", nullptr));
        label->setText(QApplication::translate("uvc_blck", "\350\256\276\345\244\207\345\220\215\347\247\260", nullptr));
        label_2->setText(QApplication::translate("uvc_blck", "\345\210\206\350\276\250\347\216\207", nullptr));
        label_3->setText(QApplication::translate("uvc_blck", "\345\270\247\347\216\207", nullptr));
        ui_read->setText(QApplication::translate("uvc_blck", "\350\257\273\345\217\226", nullptr));
        ui_write->setText(QApplication::translate("uvc_blck", "\345\206\231\345\205\245", nullptr));
        ui_close->setText(QApplication::translate("uvc_blck", "\345\205\263\351\227\255", nullptr));
    } // retranslateUi

};

namespace Ui {
    class uvc_blck: public Ui_uvc_blck {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_UVC_BLCK_H
