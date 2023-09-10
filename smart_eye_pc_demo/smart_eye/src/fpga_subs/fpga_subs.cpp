#include "fpga_subs.h"
#include "ui_fpga_subs.h"
#include <QFile>
#include <QFileInfo>
#include <QDebug>
#include <QTableWidgetItem>
fpga_subs::fpga_subs(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::fpga_subs)
{
    ui->setupUi(this);
    table = new QTableWidget(row,column+1,this);
    ui->ui_table_layout->addWidget(table);
    table->resize(900,350);
    QStringList head_lab;
    head_lab << "0x0000" << "0x0001" << "0x0002" << "0x0003" << "note";
    table->setHorizontalHeaderLabels(head_lab);
    QStringList column_lab;

    for(int i = 0; i < row * column; i=i+4)
    {
        column_lab << QString::number(i);
        table->setVerticalHeaderLabels(column_lab);
    }

}

fpga_subs::~fpga_subs()
{
    delete ui;
}

void fpga_subs::update_file_path(QList<QString> p_list)
{
    p_fpga_file = p_list[P_FPGA_FILE]; //path update
    on_ui_rd_param_clicked(); //update chart
}


void fpga_subs::on_ui_rd_param_clicked()
{
    QString pns_ini;
    pns_ini = p_fpga_file + "fpga_ini.dat";
    QFile f(pns_ini);
    QFileInfo fi(pns_ini);

    qDebug() << pns_ini;
    if(!fi.exists())
    {
        QString info = "no file " + pns_ini + " to read";
        emit info_trig(0,CODE_FPGA_SET,"error",info);
        return;
    }
    f.open(QIODevice::ReadOnly | QIODevice::Text);
    l_fpga_set.clear();
    for(int j = 0; j < row * column; j++)
    {
        l_fpga_set.append("0");
    }
    int i = 0;
    while(!f.atEnd() && i < row * column)
    {
        QByteArray b_line =  f.readLine();
        QString s_line(b_line);
        s_line.remove("\n");
        l_fpga_set.replace(i,s_line);
        i ++;
    }
    f.close();
    //qDebug() << l_fpga_set;

    for(int i = 0; i <row;i++)
    {
        for(int j = 0; j < column; j++)
        {
            //table->item(i,j)->setText(l_fpga_set[i*4+j]);
             QTableWidgetItem *item = new QTableWidgetItem;
             item->setText(l_fpga_set[i*column+j]);
             table->setItem(i,j,item);
             //delete item;
        }
    }
    for(int i = 0; i < row;i++)
    {
        QTableWidgetItem *item = new QTableWidgetItem;

        switch(i)
        {
            case 0: item->setText("0:imag set\n 1: rgb set \n 2: ycbcr set\n 3: size set"); break;
            case 1: item->setText("led"); break;
            default: item->setText("---"); break;
        }
        table->setItem(i,column,item);
    }
    table->resizeColumnsToContents(); //auto size
    table->resizeRowsToContents();
}
void fpga_subs::on_ui_wr_param_clicked()
{
    QRegExp regx("[A-Fa-f0-9]{1,4}");
    l_fpga_set.clear();
    for(int i = 0; i <row;i++)
    {
        for(int j = 0; j < column; j++)
        {
            //table->item(i,j)->setText(l_fpga_set[i*4+j]);
             QTableWidgetItem *item_rd = new QTableWidgetItem;
             item_rd = table->item(i,j);
             if(item_rd == NULL)
             {
                l_fpga_set.append("0");
             }
             else if(regx.exactMatch(item_rd->text()))
             {
                l_fpga_set.append(item_rd->text());
             }
             else //data not match
             {
                l_fpga_set.append("0");
             }
        }
    }
    //write file
    QString pns_ini;
    pns_ini = p_fpga_file + "fpga_ini.dat";
    QFile f(pns_ini);
    f.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream f_out(&f);
    f.seek(0);
    for(int i = 0; i < row * column; i++)
    {
        f_out << l_fpga_set[i] << "\n";
    }
    f.close();
    on_ui_rd_param_clicked();
    // --------------------------------------------
    // send signal to UDP to tran to ARM
    emit udp_trig(pns_ini,CODE_FPGA_SET);

}

