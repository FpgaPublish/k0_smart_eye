#include "net_subs.h"
#include "../MACRO.h"
#include "string.h"
#include "../ff_blck/ff_blck.h"
struct SUdpPck pkg_send;
struct SUdpPck pkg_recv;


int decode_hello_ps()
{
	pkg_send.pkg_code = CODE_HELLO_PS;
	pkg_send.pkg_len  = 20;
	pkg_send.pkg_wid  = 1;
    pkg_send.pkg_wid  = pkg_send.pkg_wid << 16 | 1;
    
	//pkg_send.pkg_dat[960] = "hello PC\n\r";
	strcpy((char *)pkg_send.pkg_dat,"hello PC\n\r");
    pkg_send.pkg_xor = 0;
	for(int i = 0; i < WD_PKG_DATA; i++)
	{
		pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
	}
	return 0;
}

int decode_bmp_file()
{
    //write SD
    ff_sd_wr("decode_bmp_file.txt",pkg_recv.pkg_dat,pkg_recv.pkg_len,1);
    //reply PC(0)
    pkg_send.pkg_code = CODE_BMP_FILE;
    pkg_send.pkg_len  = 20;
    pkg_send.pkg_wid  = pkg_send.pkg_wid << 16 | 1;
    char str1[] = "Receive BMP at.";
    char str2[] = "\n\r";
    char *str=(char*)malloc(strlen(str1) + 4 + strlen(str2));
    sprintf(str,"%s%d%s",str1,pkg_recv.pkg_wid,str2);
    strcpy((char *)pkg_send.pkg_dat,str);
    pkg_send.pkg_xor = 0;
    for(int i = 0; i < WD_PKG_DATA; i++)
	{
		pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
	}
	return 0;
}
