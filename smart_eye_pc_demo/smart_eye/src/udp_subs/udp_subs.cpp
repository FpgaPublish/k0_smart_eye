#include "udp_subs.h"
#include "ui_udp_subs.h"

// =====================================================
// user head file
#include <QTimer>
#include <qelapsedtimer.h>
#include <QDebug>
#include <QFile>
#include <QFileInfo>

udp_subs::udp_subs(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::udp_subs)
{
    ui->setupUi(this);
    // --------------------------------------------
    // UDP base class
    udp_driv = new QUdpSocket;
    connect(udp_driv,&QUdpSocket::readyRead,this,&udp_subs::udp_recv_blck);
    // --------------------------------------------
    // UDP init param
    s_master_ipv4 = "192.168.120.11";
    s_master_port = "5001";
    s_slaver_ipv4 = "192.168.120.10";
    s_slaver_port = "5001";
    ui->ui_master_ipv4_in->setText(s_master_ipv4);
    ui->ui_master_port_in->setText(s_master_port);
    ui->ui_slaver_ipv4_in->setText(s_slaver_ipv4);
    ui->ui_slaver_port_in->setText(s_slaver_port);
    udp_driv->bind(QHostAddress(s_master_ipv4),s_master_port.toUInt());
}

udp_subs::~udp_subs()
{
    delete  udp_driv;
    delete ui;
}

bool udp_subs::wait_signals( const unsigned int millisecond)
{
    bool result = true;

    QEventLoop loop;
    connect(this,SIGNAL(pkg_trig()), &loop, SLOT(quit()));

    QTimer timer;
    timer.setSingleShot(true);
    connect(&timer, &QTimer::timeout, [&loop, &result]{ result = false; loop.quit();});
    timer.start(millisecond);
    loop.exec();
    timer.stop();
    return result;
}

void udp_subs::udp_recv_blck()
{
    //give other module solve
    emit pkg_trig();
    //solve recv data
    while(udp_driv->hasPendingDatagrams())
        {
            QByteArray ba_pkg;
            ba_pkg.resize(udp_driv->pendingDatagramSize());
            udp_driv->readDatagram(ba_pkg.data(),ba_pkg.size());
            memcpy(&pkg_recv,(SUdpPck*)ba_pkg.data(),sizeof(pkg_recv));
        }
    //qDebug() << pkg_recv.pkg_code;
}

void udp_subs::send_udp_pkg()
{
    // --------------------------------------------
    // send UDP pkg
    QByteArray ba_dat;
    ba_dat.resize(sizeof(pkg_send));
    char *pba_dat = ba_dat.data();
    memcpy(pba_dat,&pkg_send,sizeof(pkg_send));
    udp_driv->writeDatagram(ba_dat,QHostAddress(s_slaver_ipv4),s_slaver_port.toUInt());
}

void udp_subs::send_udp_spd()
{
    // --------------------------------------------
    // send speed measure
    pkg_send.pkg_code = CODE_HELLO_PS;
    pkg_send.pkg_len  = 960;
    pkg_send.pkg_wid  = 1;
    pkg_send.pkg_wid  = pkg_send.pkg_wid << 16 | 1;
    int j = 0;
    QElapsedTimer timer;
    timer.start();
    while(j < 10)
    {
        pkg_send.pkg_xor  = 0;
        for(int i = 0; i < 960; i++)
        {
            pkg_send.pkg_dat[i] = i;
            pkg_send.pkg_xor = pkg_send.pkg_xor ^ i;
        }
        send_udp_pkg();
        wait_signals(100);
        j++;
        //qDebug() << j;
    }
    float n_spd = (double)10000000000 / (double)timer.nsecsElapsed();
    //qDebug() << n_spd;
    emit spd_trig(n_spd);
}

void udp_subs::m_send_udp_bmp(QString pns_bmp)
{
    QImage bmp(pns_bmp);
    bmp = bmp.convertToFormat(QImage::Format_RGB888);
    uchar *bits = bmp.bits();
    for(int i = 0; i < bmp.height(); i++)
    {
        qDebug() << bits[i];
    }
    //imag info
    int imag_h = bmp.height();
    int imag_w = bmp.width();
    //auto match width and send
    if(imag_w * 3 < 960)
    {
        pkg_send.pkg_len  = imag_w * 3;
        pkg_send.pkg_wid  = imag_h ;
    }
    else if(imag_w * 3 < 960 * 2)
    {
        pkg_send.pkg_len  = imag_w * 3 / 2;
        pkg_send.pkg_wid  = imag_h * 2;
    }
    else if(imag_w * 3 < 960 * 4)
    {
        pkg_send.pkg_len  = imag_w * 3/ 4;
        pkg_send.pkg_wid  = imag_h * 4;
    }
    else
    {
        pkg_send.pkg_len  = imag_w * 3 / 8;
        pkg_send.pkg_wid  = imag_h * 8;
    }
    pkg_send.pkg_code = CODE_BMP_FILE;
    //send udp data
    uint j = 0;
    uint sum_wid = pkg_send.pkg_wid;
    pkg_send.pkg_wid = pkg_send.pkg_wid << 16;
    while(j < sum_wid)
    {
        pkg_send.pkg_xor  = 0;
        pkg_send.pkg_wid = pkg_send.pkg_wid | (j+1);
        for(uint i = 0; i < pkg_send.pkg_len; i++)
        {
            pkg_send.pkg_dat[i] = bits[i + j * pkg_send.pkg_len];
            pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
        }
        send_udp_pkg();
        wait_signals(1);
        pkg_send.pkg_wid = pkg_send.pkg_wid & 0xffff0000;
        j++ ;
    }

}

void udp_subs::m_send_udp_dat(QString pns_dat,quint32 code)
{
    QFile f(pns_dat);
    QFileInfo fi(pns_dat);
    QList<quint32> l_dat_hex;
    switch (code)
    {
    case CODE_FPGA_SET:
        if(!fi.exists())
        {
            QString info = "no file " + pns_dat + " to read";
            emit info_trig(0,CODE_FPGA_SET,"error",info);
            return;
        }
        f.open(QIODevice::ReadOnly | QIODevice::Text);
        l_dat_hex.clear();
        int i = 0;
        while(!f.atEnd())
        {
            bool ok;
            QByteArray b_line =  f.readLine();
            QString s_line(b_line);
            s_line.remove("\n");
            l_dat_hex.append(QString::number(s_line.toInt(),16).toInt(&ok,16));

            i ++;
        }

        qDebug() << l_dat_hex;
        // --------------------------------------------
        // send data
        pkg_send.pkg_code = CODE_FPGA_SET;
        pkg_send.pkg_len  = l_dat_hex.size() * 4;
        pkg_send.pkg_wid  = 1;
        pkg_send.pkg_xor  = 0;
        qDebug() << l_dat_hex.size();
        pkg_send.pkg_wid = pkg_send.pkg_wid << 16;
        for(int i = 0; i < l_dat_hex.size(); i++)
        {
            pkg_send.pkg_dat[i*4+0] = l_dat_hex[i] >> 24;
            pkg_send.pkg_dat[i*4+1] = l_dat_hex[i] >> 16;
            pkg_send.pkg_dat[i*4+2] = l_dat_hex[i] >>  8;
            pkg_send.pkg_dat[i*4+3] = l_dat_hex[i] >>  0;
            pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i*4+0]
                                                ^ pkg_send.pkg_dat[i*4+1]
                                                ^ pkg_send.pkg_dat[i*4+2]
                                                ^ pkg_send.pkg_dat[i*4+3];

        }
        pkg_send.pkg_wid = pkg_send.pkg_wid | (1); //update cur width

        send_udp_pkg();
        if(wait_signals(1000))
        {
            QString info = "fpga cmd download ok";
            emit info_trig(0,CODE_FPGA_SET,"info",info);
        }
        else
        {
            QString info = "fpga cmd download error";
            emit info_trig(0,CODE_FPGA_SET,"error",info);
        }
        break;
    }

}

void udp_subs::on_buttonBox_accepted()
{
    // --------------------------------------------
    // set param to Net
    s_master_ipv4 = ui->ui_master_ipv4_in->text();
    s_master_port = ui->ui_master_port_in->text();
    s_slaver_ipv4 = ui->ui_slaver_ipv4_in->text();
    s_slaver_port = ui->ui_slaver_port_in->text();
    udp_driv->bind(QHostAddress(s_master_ipv4),s_master_port.toUInt());
    QString text = "net -m_ipv4 " + s_master_ipv4 +\
                      " -m_port " + s_master_port +\
                      " -s_ipv4 " + s_slaver_ipv4 +\
                      " -s_port " + s_slaver_port;
    emit info_trig(0,CODE_NET_SET,"info",text);
}

