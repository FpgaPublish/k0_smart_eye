/********************************************************************************
** Form generated from reading UI file 'flow_blck.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_FLOW_BLCK_H
#define UI_FLOW_BLCK_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QRadioButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_flow_blck
{
public:
    QVBoxLayout *verticalLayout;
    QGridLayout *gridLayout;
    QRadioButton *ui_video_in;
    QRadioButton *ui_net_in;
    QRadioButton *ui_uart_in;
    QRadioButton *ui_uart_out;
    QRadioButton *ui_net_out;
    QLabel *label;
    QComboBox *ui_video_to_net;
    QPushButton *ui_close;

    void setupUi(QWidget *flow_blck)
    {
        if (flow_blck->objectName().isEmpty())
            flow_blck->setObjectName(QString::fromUtf8("flow_blck"));
        flow_blck->resize(832, 610);
        verticalLayout = new QVBoxLayout(flow_blck);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        gridLayout = new QGridLayout();
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        ui_video_in = new QRadioButton(flow_blck);
        ui_video_in->setObjectName(QString::fromUtf8("ui_video_in"));

        gridLayout->addWidget(ui_video_in, 1, 0, 1, 1);

        ui_net_in = new QRadioButton(flow_blck);
        ui_net_in->setObjectName(QString::fromUtf8("ui_net_in"));

        gridLayout->addWidget(ui_net_in, 2, 0, 1, 1);

        ui_uart_in = new QRadioButton(flow_blck);
        ui_uart_in->setObjectName(QString::fromUtf8("ui_uart_in"));

        gridLayout->addWidget(ui_uart_in, 3, 0, 1, 1);

        ui_uart_out = new QRadioButton(flow_blck);
        ui_uart_out->setObjectName(QString::fromUtf8("ui_uart_out"));

        gridLayout->addWidget(ui_uart_out, 0, 1, 1, 1);

        ui_net_out = new QRadioButton(flow_blck);
        ui_net_out->setObjectName(QString::fromUtf8("ui_net_out"));

        gridLayout->addWidget(ui_net_out, 0, 2, 1, 1);

        label = new QLabel(flow_blck);
        label->setObjectName(QString::fromUtf8("label"));
        label->setAlignment(Qt::AlignCenter);

        gridLayout->addWidget(label, 0, 0, 1, 1);

        ui_video_to_net = new QComboBox(flow_blck);
        ui_video_to_net->setObjectName(QString::fromUtf8("ui_video_to_net"));

        gridLayout->addWidget(ui_video_to_net, 1, 2, 1, 1);


        verticalLayout->addLayout(gridLayout);

        ui_close = new QPushButton(flow_blck);
        ui_close->setObjectName(QString::fromUtf8("ui_close"));

        verticalLayout->addWidget(ui_close);

        verticalLayout->setStretch(0, 5);

        retranslateUi(flow_blck);

        QMetaObject::connectSlotsByName(flow_blck);
    } // setupUi

    void retranslateUi(QWidget *flow_blck)
    {
        flow_blck->setWindowTitle(QApplication::translate("flow_blck", "Form", nullptr));
        ui_video_in->setText(QApplication::translate("flow_blck", "\346\221\204\345\203\217", nullptr));
        ui_net_in->setText(QApplication::translate("flow_blck", "\347\275\221\345\217\243", nullptr));
        ui_uart_in->setText(QApplication::translate("flow_blck", "\344\270\262\345\217\243", nullptr));
        ui_uart_out->setText(QApplication::translate("flow_blck", "\344\270\262\345\217\243", nullptr));
        ui_net_out->setText(QApplication::translate("flow_blck", "\347\275\221\345\217\243", nullptr));
        label->setText(QApplication::translate("flow_blck", "\350\276\223\345\205\245 \\ \350\276\223\345\207\272", nullptr));
        ui_close->setText(QApplication::translate("flow_blck", "\351\200\200\345\207\272", nullptr));
    } // retranslateUi

};

namespace Ui {
    class flow_blck: public Ui_flow_blck {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FLOW_BLCK_H
