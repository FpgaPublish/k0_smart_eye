#ifndef FILE_MDLE_H
#define FILE_MDLE_H

#include <QWidget>
#include <QList>
#include "../MACRO.h"
namespace Ui {
class file_mdle;
}

class file_mdle : public QWidget
{
    Q_OBJECT

public:
    explicit file_mdle(QWidget *parent = nullptr);
    ~file_mdle();

private:
    Ui::file_mdle *ui;
private:
    QList<QString> l_env_path;
    QString pns_ini;
signals:
    void    info_trig(quint32,quint32,QString,QString);
    void    update_trig(QList<QString>);
private slots:
    void on_ui_write_set_clicked();
    void on_ui_read_set_clicked();
    void on_pushButton_clicked();

public:
    QList<QString> m_get_path();

};

#endif // FILE_MDLE_H
