//////////////////////////////////////////////////////////////////////////////////
// Company: Fpga Publish
// Engineer: F 
// 
// Create Date: 2023/06/21 22:02:29
// Design Name: 
// Module Name: ff_blck
// Project Name: 
// Target Devices: ZYNQ7010 & XAUG
// Tool Versions: vitis 2021.1
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
#include "ff_blck.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "ff.h"​
#include "xstatus.h"
#include "../info_blck/info_blck.h"
// ----------------------------------------------
// file sys control​
static FATFS fatfs;
<<<<<<< HEAD
uint SD_STATE;
=======
uint32 SD_STATE;
>>>>>>> origin/develop
int ff_sd_init()
{
    //file object
    FRESULT status;
    TCHAR *path ="0:/";
<<<<<<< HEAD
    uint8 work[FF_MAX_SS];
    //mount sd
    status = f_mount(&fatfs,path,1);
    if(status != PR_OK) {
=======
    //uint8 work[FF_MAX_SS];
    //mount sd
    status = f_mount(&fatfs,path,1);
    if(status != FR_OK) {
>>>>>>> origin/develop
        info_blck(CODE_SD_INFO,"error","SD mount error");
        return ERR_NO_DEVICE;
        SD_STATE = 0;
    }
    else {
        SD_STATE = 1;
        return ERR_NO_ERR;
    }
}
int ff_sd_wr(char *name_file,uint32 addr_file,uint32 len_file,uint8 md_write)
{
    //object
    FIL file;
    uint32 nb_byte_wr;
    //control
    if(SD_STATE == 0)
    {
        return ERR_NO_DEVICE;
    }
<<<<<<< HEAD
    f_open(&file,name_file,FDA_CREATE_ALWAYS | FA_WRITE);
    if(md_write == 0)
    {
        f_lseek(&file,0,SEEK_SET);
    }
    else 
    {
        f_lseek(&file,0,SEEK_END);
    }
    f_write(&file,(void *) addr_file,len_file,&nb_byte_wr);
    f_close($file);
=======
    f_open(&file,name_file,FA_CREATE_ALWAYS | FA_WRITE);
    if(md_write == 0)
    {
        f_lseek(&file,0);
    }
    else 
    {
        f_lseek(&file,f_size(&file));
    }
    f_write(&file,(void *) addr_file,len_file,&nb_byte_wr);
    f_close(&file);
>>>>>>> origin/develop
    return ERR_NO_ERR;
}
int ff_sd_rd(char *name_file,uint32 addr_file,uint32 len_file)
{
    //object
    FIL file;
    uint32 nb_byte_rd;
    //control
    if(SD_STATE == 0)
    {
        return ERR_NO_DEVICE;
    }
    f_open(&file, name_file,FA_READ);
<<<<<<< HEAD
    f_lseek(&fil,0);
    f_read(&file,(void*),addr_file,&nb_byte_rd);
=======
    f_lseek(&file,0);
    f_read(&file,(void*)addr_file,len_file,&nb_byte_rd);
>>>>>>> origin/develop
    f_close(&file);
    return ERR_NO_ERR;
}
