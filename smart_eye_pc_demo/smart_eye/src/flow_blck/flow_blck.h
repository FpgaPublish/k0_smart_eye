#ifndef FLOW_BLCK_H
#define FLOW_BLCK_H

#include <QWidget>

namespace Ui {
class flow_blck;
}

class flow_blck : public QWidget
{
    Q_OBJECT

public:
    explicit flow_blck(QWidget *parent = nullptr);
    ~flow_blck();

private:
    Ui::flow_blck *ui;
public slots:
    void m_bmp_in(QString p_bmp);
signals:
    void bmp_udp_trig(QString p_bmp);
};

#endif // FLOW_BLCK_H
