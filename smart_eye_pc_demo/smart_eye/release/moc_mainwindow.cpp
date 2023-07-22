/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.11)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../smart_eye_pc_work/smart_eye_win/mainwindow.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.11. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MainWindow_t {
    QByteArrayData data[16];
    char stringdata0[304];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MainWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MainWindow_t qt_meta_stringdata_MainWindow = {
    {
QT_MOC_LITERAL(0, 0, 10), // "MainWindow"
QT_MOC_LITERAL(1, 11, 23), // "on_action_net_triggered"
QT_MOC_LITERAL(2, 35, 0), // ""
QT_MOC_LITERAL(3, 36, 26), // "on_ui_info_log_textChanged"
QT_MOC_LITERAL(4, 63, 9), // "info_blck"
QT_MOC_LITERAL(5, 73, 12), // "net_spd_driv"
QT_MOC_LITERAL(6, 86, 17), // "on_ui_net_clicked"
QT_MOC_LITERAL(7, 104, 13), // "uart_spd_driv"
QT_MOC_LITERAL(8, 118, 18), // "on_ui_uart_clicked"
QT_MOC_LITERAL(9, 137, 24), // "on_action_uart_triggered"
QT_MOC_LITERAL(10, 162, 26), // "on_ui_prot_log_textChanged"
QT_MOC_LITERAL(11, 189, 17), // "on_ui_uvc_clicked"
QT_MOC_LITERAL(12, 207, 23), // "on_action_uvc_triggered"
QT_MOC_LITERAL(13, 231, 24), // "on_action_file_triggered"
QT_MOC_LITERAL(14, 256, 23), // "on_ui_flow_ctrl_clicked"
QT_MOC_LITERAL(15, 280, 23) // "on_ui_flow_fpga_clicked"

    },
    "MainWindow\0on_action_net_triggered\0\0"
    "on_ui_info_log_textChanged\0info_blck\0"
    "net_spd_driv\0on_ui_net_clicked\0"
    "uart_spd_driv\0on_ui_uart_clicked\0"
    "on_action_uart_triggered\0"
    "on_ui_prot_log_textChanged\0on_ui_uvc_clicked\0"
    "on_action_uvc_triggered\0"
    "on_action_file_triggered\0"
    "on_ui_flow_ctrl_clicked\0on_ui_flow_fpga_clicked"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MainWindow[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   84,    2, 0x08 /* Private */,
       3,    0,   85,    2, 0x08 /* Private */,
       4,    4,   86,    2, 0x08 /* Private */,
       5,    1,   95,    2, 0x08 /* Private */,
       6,    0,   98,    2, 0x08 /* Private */,
       7,    1,   99,    2, 0x08 /* Private */,
       8,    0,  102,    2, 0x08 /* Private */,
       9,    0,  103,    2, 0x08 /* Private */,
      10,    0,  104,    2, 0x08 /* Private */,
      11,    0,  105,    2, 0x08 /* Private */,
      12,    0,  106,    2, 0x08 /* Private */,
      13,    0,  107,    2, 0x08 /* Private */,
      14,    0,  108,    2, 0x08 /* Private */,
      15,    0,  109,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::UInt, QMetaType::UInt, QMetaType::QString, QMetaType::QString,    2,    2,    2,    2,
    QMetaType::Void, QMetaType::Float,    2,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Float,    2,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MainWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->on_action_net_triggered(); break;
        case 1: _t->on_ui_info_log_textChanged(); break;
        case 2: _t->info_blck((*reinterpret_cast< quint32(*)>(_a[1])),(*reinterpret_cast< quint32(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 3: _t->net_spd_driv((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 4: _t->on_ui_net_clicked(); break;
        case 5: _t->uart_spd_driv((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 6: _t->on_ui_uart_clicked(); break;
        case 7: _t->on_action_uart_triggered(); break;
        case 8: _t->on_ui_prot_log_textChanged(); break;
        case 9: _t->on_ui_uvc_clicked(); break;
        case 10: _t->on_action_uvc_triggered(); break;
        case 11: _t->on_action_file_triggered(); break;
        case 12: _t->on_ui_flow_ctrl_clicked(); break;
        case 13: _t->on_ui_flow_fpga_clicked(); break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject MainWindow::staticMetaObject = { {
    &QMainWindow::staticMetaObject,
    qt_meta_stringdata_MainWindow.data,
    qt_meta_data_MainWindow,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow.stringdata0))
        return static_cast<void*>(this);
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
