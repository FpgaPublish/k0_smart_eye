#include "videosurface_driv.h"
#include <QDebug>
#include <QVideoFrame>
#include <QVideoSurfaceFormat>
videosurface_driv::videosurface_driv(QObject *parent)
    : QAbstractVideoSurface(parent)
{

}

videosurface_driv::~videosurface_driv()
{

}

bool videosurface_driv::present(const QVideoFrame &frame)
{
    if (frame.isValid())
    {
            QVideoFrame cloneFrame(frame);                                      //每一帧视频都会进入present中，内部机制
            emit frame_trig(cloneFrame);                                    //直接把视频帧发送出去
            return true;
    }
    stop();
    return false;
}

bool videosurface_driv::start(const QVideoSurfaceFormat &videoformat)
{
    if(QVideoFrame::imageFormatFromPixelFormat(videoformat.pixelFormat()) != QImage::Format_Invalid && !videoformat.frameSize().isEmpty())
    {
            QAbstractVideoSurface::start(videoformat);
            return true;
    }
    return false;
}

void videosurface_driv::stop()
{
    QAbstractVideoSurface::stop();
}

bool videosurface_driv::isFormatSupported(const QVideoSurfaceFormat &videoformat) const
{
    return QVideoFrame::imageFormatFromPixelFormat(videoformat.pixelFormat()) != QImage::Format_Invalid;
}

QList<QVideoFrame::PixelFormat> videosurface_driv::supportedPixelFormats(QAbstractVideoBuffer::HandleType handleType) const
{
    if(handleType == QAbstractVideoBuffer::NoHandle)
    {
        return QList<QVideoFrame::PixelFormat>() << QVideoFrame::Format_RGB32
                                                 << QVideoFrame::Format_ARGB32
                                                 << QVideoFrame::Format_ARGB32_Premultiplied
                                                 << QVideoFrame::Format_RGB565
                                                 << QVideoFrame::Format_RGB555;
        qDebug() << QList<QVideoFrame::PixelFormat>() << QVideoFrame::Format_RGB32;
    }
    else
    {
        return QList<QVideoFrame::PixelFormat>();
    }
}


