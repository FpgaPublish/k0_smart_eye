#include "flow_blck.h"
#include "ui_flow_blck.h"

flow_blck::flow_blck(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::flow_blck)
{
    ui->setupUi(this);
    //video - udp set default
    ui->ui_video_to_net->addItem("bmp mode");
    ui->ui_video_to_net->setCurrentIndex(0);

}

flow_blck::~flow_blck()
{
    delete ui;
}

void flow_blck::m_bmp_in(QString p_bmp)
{
    //every input just control by one switch
    switch(ui->ui_video_to_net->currentIndex())
    {
    case(0): emit bmp_udp_trig(p_bmp); break;
    default: emit bmp_udp_trig(p_bmp); break;
    }

}
