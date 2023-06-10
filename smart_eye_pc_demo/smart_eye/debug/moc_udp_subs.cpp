/****************************************************************************
** Meta object code from reading C++ file 'udp_subs.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.11)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../src/udp_subs/udp_subs.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'udp_subs.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.11. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_udp_subs_t {
    QByteArrayData data[8];
    char stringdata0[87];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_udp_subs_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_udp_subs_t qt_meta_stringdata_udp_subs = {
    {
QT_MOC_LITERAL(0, 0, 8), // "udp_subs"
QT_MOC_LITERAL(1, 9, 8), // "pkg_trig"
QT_MOC_LITERAL(2, 18, 0), // ""
QT_MOC_LITERAL(3, 19, 9), // "info_trig"
QT_MOC_LITERAL(4, 29, 8), // "spd_trig"
QT_MOC_LITERAL(5, 38, 13), // "udp_recv_blck"
QT_MOC_LITERAL(6, 52, 21), // "on_buttonBox_accepted"
QT_MOC_LITERAL(7, 74, 12) // "send_udp_spd"

    },
    "udp_subs\0pkg_trig\0\0info_trig\0spd_trig\0"
    "udp_recv_blck\0on_buttonBox_accepted\0"
    "send_udp_spd"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_udp_subs[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,
       3,    4,   45,    2, 0x06 /* Public */,
       4,    1,   54,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    0,   57,    2, 0x08 /* Private */,
       6,    0,   58,    2, 0x08 /* Private */,
       7,    0,   59,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::UInt, QMetaType::UInt, QMetaType::QString, QMetaType::QString,    2,    2,    2,    2,
    QMetaType::Void, QMetaType::Float,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void udp_subs::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<udp_subs *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->pkg_trig(); break;
        case 1: _t->info_trig((*reinterpret_cast< quint32(*)>(_a[1])),(*reinterpret_cast< quint32(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 2: _t->spd_trig((*reinterpret_cast< float(*)>(_a[1]))); break;
        case 3: _t->udp_recv_blck(); break;
        case 4: _t->on_buttonBox_accepted(); break;
        case 5: _t->send_udp_spd(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (udp_subs::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&udp_subs::pkg_trig)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (udp_subs::*)(quint32 , quint32 , QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&udp_subs::info_trig)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (udp_subs::*)(float );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&udp_subs::spd_trig)) {
                *result = 2;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject udp_subs::staticMetaObject = { {
    &QDialog::staticMetaObject,
    qt_meta_stringdata_udp_subs.data,
    qt_meta_data_udp_subs,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *udp_subs::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *udp_subs::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_udp_subs.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int udp_subs::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void udp_subs::pkg_trig()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void udp_subs::info_trig(quint32 _t1, quint32 _t2, QString _t3, QString _t4)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)), const_cast<void*>(reinterpret_cast<const void*>(&_t4)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void udp_subs::spd_trig(float _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
