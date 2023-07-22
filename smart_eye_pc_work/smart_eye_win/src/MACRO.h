#ifndef MACRO_H
#define MACRO_H

#include <QMetaType>

// =====================================================
// DEBUG
#define DEBUG_MODE 0
// =====================================================
//
#define APP_NAME  "SMART_EYE"

// ========================================
// device list code
#define DEV_PC 1
#define DEV_PS 2
#define DEV_PL 3

// ========================================
//add code value
//PC(1) code
#define CODE_WELCOME   0x11000000
#define CODE_NET_SET   0x11000001

#define CODE_UART_INFO 0x11000002
#define CODE_UVC_INFO  0x11000003
#define CODE_FILE_INFO 0x11000004
//PC(1) and PS(2) code
#define CODE_HELLO_PS 0x12210000
#define CODE_BMP_FILE 0x12210001

#define CODE_UART_PS  0x00210002
//PC(1) and PL(3) code
#define CODE_FPGA_SET 0x13310000

//add struct
struct SUdpPck{
    quint32 pkg_code;      //class code
    quint32 pkg_len ;      //one pkg length
    quint32 pkg_wid ;      //current pkg width
    char    pkg_dat [960]; //pkg data
    quint32 pkg_xor ;      //pkg xor
};
Q_DECLARE_METATYPE(SUdpPck)


//add error macro
#define ERR_NO_ERR        0
#define ERR_TYPE_MATCH    1
#define ERR_NULL_VARIABLE 2

// ==========================================================
// color control
#define TEXT_COLOR_RED(STRING)    ("<font color=red>" + STRING + "</font>" "<font color=black> </font>")
#define TEXT_COLOR_BLUE(STRING)   ("<font color=blue>" + STRING + "</font>" "<font color=black> </font>")
#define TEXT_COLOR_GREEN(STRING)  ("<font color=green>" + STRING + "</font>" "<font color=black> </font>")
#define TEXT_COLOR_BLACK(STRING)  ("<font color=black>" + STRING + "</font>" "<font color=black> </font>")
#define TEXT_COLOR_WHITE(STRING)  ("<font color=white>" + STRING + "</font>" "<font color=black> </font>")

// =====================================================
// file mdle info
#define P_MAX_NUMB   10
#define P_VIDEO_FIFO 0
#define P_LOG_FILE   1
#define P_FPGA_FILE  2


// =====================================================
// public function name
#define F_SETWIN    setWindowFlags(Qt::WindowTitleHint  |   \
                    Qt::CustomizeWindowHint);


#endif // MACRO_H

