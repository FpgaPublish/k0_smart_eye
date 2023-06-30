#ifndef FPGA_SUBS_H
#define FPGA_SUBS_H

#include <QWidget>
#include <QLineEdit>
#include <QTableWidget>
#include "../MACRO.h"
namespace Ui {
class fpga_subs;
}

class fpga_subs : public QWidget
{
    Q_OBJECT

public:
    explicit fpga_subs(QWidget *parent = nullptr);
    ~fpga_subs();

private:
    Ui::fpga_subs *ui;
private:
    QTableWidget *table;
public slots:
    void update_file_path(QList<QString>);
private slots:
    void on_ui_rd_param_clicked();

    void on_ui_wr_param_clicked();

private:
    QString p_fpga_file;
    QList<QString>l_fpga_set;
    const int row    = 32;
    const int column = 4 ;
signals:
    void info_trig(quint32,quint32,QString,QString);
    void udp_trig(QString,quint32);
};

#endif // FPGA_SUBS_H
