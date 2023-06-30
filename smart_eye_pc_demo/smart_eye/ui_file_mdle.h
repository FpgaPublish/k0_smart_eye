/********************************************************************************
** Form generated from reading UI file 'file_mdle.ui'
**
** Created by: Qt User Interface Compiler version 5.12.11
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_FILE_MDLE_H
#define UI_FILE_MDLE_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QRadioButton>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_file_mdle
{
public:
    QVBoxLayout *verticalLayout_2;
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout_2;
    QLabel *label_2;
    QLineEdit *ui_file_ini;
    QRadioButton *ui_file_ini_state;
    QHBoxLayout *horizontalLayout_3;
    QLabel *label;
    QLineEdit *ui_dir_camera;
    QHBoxLayout *horizontalLayout_4;
    QLabel *label_3;
    QLineEdit *ui_log_file;
    QHBoxLayout *horizontalLayout_9;
    QLabel *label_7;
    QLineEdit *ui_fpga_file;
    QHBoxLayout *horizontalLayout;
    QPushButton *ui_read_set;
    QPushButton *ui_write_set;

    void setupUi(QWidget *file_mdle)
    {
        if (file_mdle->objectName().isEmpty())
            file_mdle->setObjectName(QString::fromUtf8("file_mdle"));
        file_mdle->resize(655, 328);
        verticalLayout_2 = new QVBoxLayout(file_mdle);
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        verticalLayout = new QVBoxLayout();
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setObjectName(QString::fromUtf8("horizontalLayout_2"));
        label_2 = new QLabel(file_mdle);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        horizontalLayout_2->addWidget(label_2);

        ui_file_ini = new QLineEdit(file_mdle);
        ui_file_ini->setObjectName(QString::fromUtf8("ui_file_ini"));
        ui_file_ini->setStyleSheet(QString::fromUtf8(""));

        horizontalLayout_2->addWidget(ui_file_ini);

        ui_file_ini_state = new QRadioButton(file_mdle);
        ui_file_ini_state->setObjectName(QString::fromUtf8("ui_file_ini_state"));

        horizontalLayout_2->addWidget(ui_file_ini_state);


        verticalLayout->addLayout(horizontalLayout_2);

        horizontalLayout_3 = new QHBoxLayout();
        horizontalLayout_3->setObjectName(QString::fromUtf8("horizontalLayout_3"));
        label = new QLabel(file_mdle);
        label->setObjectName(QString::fromUtf8("label"));

        horizontalLayout_3->addWidget(label);

        ui_dir_camera = new QLineEdit(file_mdle);
        ui_dir_camera->setObjectName(QString::fromUtf8("ui_dir_camera"));

        horizontalLayout_3->addWidget(ui_dir_camera);


        verticalLayout->addLayout(horizontalLayout_3);

        horizontalLayout_4 = new QHBoxLayout();
        horizontalLayout_4->setObjectName(QString::fromUtf8("horizontalLayout_4"));
        label_3 = new QLabel(file_mdle);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        horizontalLayout_4->addWidget(label_3);

        ui_log_file = new QLineEdit(file_mdle);
        ui_log_file->setObjectName(QString::fromUtf8("ui_log_file"));

        horizontalLayout_4->addWidget(ui_log_file);


        verticalLayout->addLayout(horizontalLayout_4);

        horizontalLayout_9 = new QHBoxLayout();
        horizontalLayout_9->setObjectName(QString::fromUtf8("horizontalLayout_9"));
        label_7 = new QLabel(file_mdle);
        label_7->setObjectName(QString::fromUtf8("label_7"));

        horizontalLayout_9->addWidget(label_7);

        ui_fpga_file = new QLineEdit(file_mdle);
        ui_fpga_file->setObjectName(QString::fromUtf8("ui_fpga_file"));

        horizontalLayout_9->addWidget(ui_fpga_file);


        verticalLayout->addLayout(horizontalLayout_9);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        ui_read_set = new QPushButton(file_mdle);
        ui_read_set->setObjectName(QString::fromUtf8("ui_read_set"));

        horizontalLayout->addWidget(ui_read_set);

        ui_write_set = new QPushButton(file_mdle);
        ui_write_set->setObjectName(QString::fromUtf8("ui_write_set"));

        horizontalLayout->addWidget(ui_write_set);


        verticalLayout->addLayout(horizontalLayout);


        verticalLayout_2->addLayout(verticalLayout);


        retranslateUi(file_mdle);

        QMetaObject::connectSlotsByName(file_mdle);
    } // setupUi

    void retranslateUi(QWidget *file_mdle)
    {
        file_mdle->setWindowTitle(QApplication::translate("file_mdle", "Form", nullptr));
        label_2->setText(QApplication::translate("file_mdle", "\351\205\215\347\275\256\346\226\207\344\273\266\345\220\215", nullptr));
        ui_file_ini_state->setText(QString());
        label->setText(QApplication::translate("file_mdle", "\346\221\204\345\203\217\345\244\264\346\225\260\346\215\256", nullptr));
        label_3->setText(QApplication::translate("file_mdle", "\346\227\245\345\277\227\346\226\207\344\273\266\345\220\215", nullptr));
        label_7->setText(QApplication::translate("file_mdle", "FPGA\351\205\215\347\275\256\346\226\207\344\273\266", nullptr));
        ui_read_set->setText(QApplication::translate("file_mdle", "\350\257\273\345\217\226", nullptr));
        ui_write_set->setText(QApplication::translate("file_mdle", "\345\206\231\345\205\245", nullptr));
    } // retranslateUi

};

namespace Ui {
    class file_mdle: public Ui_file_mdle {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FILE_MDLE_H
