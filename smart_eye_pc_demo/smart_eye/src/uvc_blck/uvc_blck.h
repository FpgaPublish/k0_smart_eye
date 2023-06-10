#ifndef UVC_BLCK_H
#define UVC_BLCK_H

#include <QWidget>
#include <QCameraInfo>
#include <QList>
#include "../MACRO.h"
namespace Ui {
class uvc_blck;
}

class uvc_blck : public QWidget
{
    Q_OBJECT

public:
    explicit uvc_blck(QWidget *parent = nullptr);
    ~uvc_blck();

private slots:
    void on_ui_read_clicked();

    void on_ui_write_clicked();

private:
    Ui::uvc_blck *ui;
// add camera info
    QList<QCameraInfo> l_camera_info;
    QList<QString> l_device_name;
    QCamera *camera;
    QList<QSize> l_resolution_size;
    QList<qreal> l_framerate;
    bool camera_init;
public:
    //get uvc speed
    int get_camera_spd();
signals:
    //info
    void info_trig(quint32,quint32,QString,QString);
};

#endif // UVC_BLCK_H
