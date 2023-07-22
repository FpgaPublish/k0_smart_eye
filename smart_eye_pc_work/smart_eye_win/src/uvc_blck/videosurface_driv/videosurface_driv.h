#ifndef VIDEOSURFACE_DRIV_H
#define VIDEOSURFACE_DRIV_H

#include <QAbstractVideoSurface>

class videosurface_driv : public QAbstractVideoSurface
{
    Q_OBJECT
public:
    explicit videosurface_driv(QObject *parent = nullptr);
    ~videosurface_driv() Q_DECL_OVERRIDE;
    bool present(const QVideoFrame &) Q_DECL_OVERRIDE;
    bool start(const QVideoSurfaceFormat &) Q_DECL_OVERRIDE;
    void stop() Q_DECL_OVERRIDE;
    bool isFormatSupported(const QVideoSurfaceFormat &) const Q_DECL_OVERRIDE;    //将视频流中像素格式转换成格式对等的图片格式，若无对等的格式，返回QImage::Format_Invalid
    QList<QVideoFrame::PixelFormat> supportedPixelFormats(QAbstractVideoBuffer::HandleType type = QAbstractVideoBuffer::NoHandle) const Q_DECL_OVERRIDE;
private:
    QVideoFrame m_currentFrame;
signals:
    void frame_trig(QVideoFrame);
};

#endif // VIDEOSURFACE_DRIV_H
