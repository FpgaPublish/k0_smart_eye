/********************************************************************************
** Form generated from reading UI file 'welcome_mdle.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WELCOME_MDLE_H
#define UI_WELCOME_MDLE_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_welcome_mdle
{
public:
    QHBoxLayout *horizontalLayout;
    QVBoxLayout *verticalLayout_2;
    QPushButton *ui_start;
    QVBoxLayout *ui_show;
    QVBoxLayout *verticalLayout;
    QPushButton *ui_help;
    QPushButton *ui_close;

    void setupUi(QWidget *welcome_mdle)
    {
        if (welcome_mdle->objectName().isEmpty())
            welcome_mdle->setObjectName(QString::fromUtf8("welcome_mdle"));
        welcome_mdle->resize(860, 564);
        horizontalLayout = new QHBoxLayout(welcome_mdle);
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        ui_start = new QPushButton(welcome_mdle);
        ui_start->setObjectName(QString::fromUtf8("ui_start"));

        verticalLayout_2->addWidget(ui_start);


        horizontalLayout->addLayout(verticalLayout_2);

        ui_show = new QVBoxLayout();
        ui_show->setObjectName(QString::fromUtf8("ui_show"));

        horizontalLayout->addLayout(ui_show);

        verticalLayout = new QVBoxLayout();
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        ui_help = new QPushButton(welcome_mdle);
        ui_help->setObjectName(QString::fromUtf8("ui_help"));

        verticalLayout->addWidget(ui_help);

        ui_close = new QPushButton(welcome_mdle);
        ui_close->setObjectName(QString::fromUtf8("ui_close"));

        verticalLayout->addWidget(ui_close);


        horizontalLayout->addLayout(verticalLayout);

        horizontalLayout->setStretch(0, 1);
        horizontalLayout->setStretch(1, 3);
        horizontalLayout->setStretch(2, 1);

        retranslateUi(welcome_mdle);

        QMetaObject::connectSlotsByName(welcome_mdle);
    } // setupUi

    void retranslateUi(QWidget *welcome_mdle)
    {
        welcome_mdle->setWindowTitle(QApplication::translate("welcome_mdle", "Form", nullptr));
        ui_start->setText(QApplication::translate("welcome_mdle", "\346\225\231\347\250\213", nullptr));
        ui_help->setText(QApplication::translate("welcome_mdle", "\345\270\256\345\212\251", nullptr));
        ui_close->setText(QApplication::translate("welcome_mdle", "\345\205\263\351\227\255", nullptr));
    } // retranslateUi

};

namespace Ui {
    class welcome_mdle: public Ui_welcome_mdle {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WELCOME_MDLE_H
