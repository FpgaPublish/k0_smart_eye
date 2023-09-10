#include "fpga_subs.h"
#include "string.h"
#include "xil_io.h"

int fpga_set(struct SUdpPck pkg_recv)
{
    unsigned int *p1 =(unsigned int *) (AXI_CMD_BASE_ADDR + AXI_CMD_OFF1_ADDR);
    memcpy(p1, pkg_recv.pkg_dat, pkg_recv.pkg_len);
    //Xil_Out8(AXI_CMD_BASE_ADDR, pkg_recv.pkg_dat[0]);
#define DEBUG
#ifdef DEBUG
    uint8 data[pkg_recv.pkg_len];
    memcpy(data,p1,pkg_recv.pkg_len);
    //uint8 dat = Xil_In8(AXI_CMD_BASE_ADDR);
#endif
    return 0;
}
