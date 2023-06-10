#include "uvc_blck.h"
#include "ui_uvc_blck.h"

#include <QDebug>

uvc_blck::uvc_blck(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::uvc_blck)
{
    ui->setupUi(this);
    camera_init = 0;
    //read default device
    on_ui_read_clicked();
    //set dafult device

}

uvc_blck::~uvc_blck()
{
    delete camera;
    delete ui;
}

void uvc_blck::on_ui_read_clicked()
{
    //device
    l_camera_info = QCameraInfo::availableCameras();
    int index = l_camera_info.size();
    int last_dev = 0;
    int current_dev = 0;
    current_dev = ui->ui_device->currentIndex();
    ui->ui_device->clear();
    l_device_name.clear();
    for(int i = 0; i < index; i++)
    {
        //qDebug() << "device" << i << l_camera_info.at(i).description();
        l_device_name.append(l_camera_info.at(i).deviceName());
        ui->ui_device->addItem(l_camera_info.at(i).description());
        last_dev = i;
    }
    qDebug() << current_dev;
    ui->ui_device->setCurrentIndex(current_dev);
    //create camera
    if(camera_init == 0)
    {
        ui->ui_device->setCurrentIndex(last_dev);
        camera = new QCamera(l_device_name[ui->ui_device->currentIndex()].toUtf8(),this);
        camera_init = 1;
        //camera mode set
        camera->setCaptureMode(QCamera::CaptureStillImage);
        //camera->setCaptureMode(QCamera::CaptureVideo);
        camera->setViewfinder(ui->ui_display);
        camera->start();
    }
    //resolution
    l_resolution_size.clear();
    l_resolution_size = camera->supportedViewfinderResolutions();
    ui->ui_resolution->clear();
    int resolution_last = 0;
    foreach(QSize msize,l_resolution_size)
    {
        ui->ui_resolution->addItem(QString::number(msize.width(),10)+"*"
                                  +QString::number(msize.height(),10));
        resolution_last++;

    }
    ui->ui_resolution->setCurrentIndex(resolution_last - 1);
    //frame
    l_framerate.clear();
    int max_rate = 0;
    ui->ui_frame->clear();
    for(int j = 0; j < camera->supportedViewfinderFrameRateRanges().length();j++)
    {
        qreal framerate = camera->supportedViewfinderFrameRateRanges().at(j).maximumFrameRate;
        l_framerate.append(framerate);
        ui->ui_frame->addItem(QString::number(framerate));
        max_rate = j;
    }
    ui->ui_frame->setCurrentIndex(max_rate);
    if(camera_init == 1)
    {
        emit info_trig(0,CODE_UVC_INFO,"info","read curret camera function");
    }
}


void uvc_blck::on_ui_write_clicked()
{
    delete camera;
    camera = new QCamera(l_device_name[ui->ui_device->currentIndex()].toUtf8(),this);
    //rate set
    QCameraViewfinderSettings set;
    set.setResolution(l_resolution_size[ui->ui_resolution->currentIndex()]);
    set.setMaximumFrameRate(l_framerate[ui->ui_frame->currentIndex()]);
    camera->setViewfinderSettings(set);
    //camera mode set
    camera->setCaptureMode(QCamera::CaptureStillImage);
    //camera->setCaptureMode(QCamera::CaptureVideo);
    camera->setViewfinder(ui->ui_display);
    camera->start();
    QString info_cmd = "set_camera -dev "
                     + ui->ui_device->currentText()
                     + " -res "
                     + ui->ui_resolution->currentText()
                     + " -frm "
                     + ui->ui_frame->currentText();
    emit info_trig(0,CODE_UVC_INFO,"info",info_cmd);
}

int uvc_blck::get_camera_spd()
{
    QSize cur_resolution = l_resolution_size[ui->ui_resolution->currentIndex()];
    int spd = cur_resolution.width()*cur_resolution.height();
    QString info = "current uvc resolution is"
                 + QString::number(cur_resolution.width())
                 + "*"
                 + QString::number(cur_resolution.height());
    emit info_trig(0,CODE_UVC_INFO,"info",info);
    return spd;

}

