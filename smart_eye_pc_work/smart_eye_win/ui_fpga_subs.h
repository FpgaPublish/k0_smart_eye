/********************************************************************************
** Form generated from reading UI file 'fpga_subs.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_FPGA_SUBS_H
#define UI_FPGA_SUBS_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_fpga_subs
{
public:
    QVBoxLayout *verticalLayout;
    QVBoxLayout *ui_table_layout;
    QHBoxLayout *horizontalLayout;
    QPushButton *ui_rd_param;
    QPushButton *ui_wr_param;
    QPushButton *ui_close;

    void setupUi(QWidget *fpga_subs)
    {
        if (fpga_subs->objectName().isEmpty())
            fpga_subs->setObjectName(QString::fromUtf8("fpga_subs"));
        fpga_subs->resize(710, 514);
        verticalLayout = new QVBoxLayout(fpga_subs);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        ui_table_layout = new QVBoxLayout();
        ui_table_layout->setObjectName(QString::fromUtf8("ui_table_layout"));

        verticalLayout->addLayout(ui_table_layout);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        ui_rd_param = new QPushButton(fpga_subs);
        ui_rd_param->setObjectName(QString::fromUtf8("ui_rd_param"));

        horizontalLayout->addWidget(ui_rd_param);

        ui_wr_param = new QPushButton(fpga_subs);
        ui_wr_param->setObjectName(QString::fromUtf8("ui_wr_param"));

        horizontalLayout->addWidget(ui_wr_param);

        ui_close = new QPushButton(fpga_subs);
        ui_close->setObjectName(QString::fromUtf8("ui_close"));

        horizontalLayout->addWidget(ui_close);


        verticalLayout->addLayout(horizontalLayout);

        verticalLayout->setStretch(0, 5);
        verticalLayout->setStretch(1, 1);

        retranslateUi(fpga_subs);

        QMetaObject::connectSlotsByName(fpga_subs);
    } // setupUi

    void retranslateUi(QWidget *fpga_subs)
    {
        fpga_subs->setWindowTitle(QApplication::translate("fpga_subs", "Form", nullptr));
        ui_rd_param->setText(QApplication::translate("fpga_subs", "\350\257\273\345\217\226fpga_ini.dat", nullptr));
        ui_wr_param->setText(QApplication::translate("fpga_subs", "\345\206\231\345\205\245fpga_ini.dat", nullptr));
        ui_close->setText(QApplication::translate("fpga_subs", "\351\200\200\345\207\272", nullptr));
    } // retranslateUi

};

namespace Ui {
    class fpga_subs: public Ui_fpga_subs {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FPGA_SUBS_H
