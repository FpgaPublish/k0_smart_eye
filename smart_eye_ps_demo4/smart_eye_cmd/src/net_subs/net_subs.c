#include "net_subs.h"
#include "../MACRO.h"
#include "string.h"
#include "../fpga_subs/fpga_subs.h"
struct SUdpPck pkg_send;
struct SUdpPck pkg_recv;


int decode_hello_ps()
{
	pkg_send.pkg_code = CODE_HELLO_PS;
	pkg_send.pkg_len  = PKG_LEN;
	pkg_send.pkg_wid  = 1;
	//pkg_send.pkg_dat[960] = "hello PC\n\r";
	strcpy((char *)pkg_send.pkg_dat,"hello PC\n\r");
    pkg_send.pkg_xor = 0;
	for(int i = 0; i < 960; i++)
	{
		pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
	}
	return 0;
}
int decode_bmp_file()
{
    pkg_send.pkg_code = CODE_BMP_FILE;
	pkg_send.pkg_len  = PKG_LEN;
	pkg_send.pkg_wid  = 1;
	strcpy((char *)pkg_send.pkg_dat,"recv bmp data from PC\n\r");
    pkg_send.pkg_xor = 0;
	for(int i = 0; i < PKG_LEN; i++)
	{
		pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
	}
	return 0;
}
int decode_fpga_set()
{
    pkg_send.pkg_code = CODE_FPGA_SET;
	pkg_send.pkg_len  = PKG_LEN;
	pkg_send.pkg_wid  = 1;
	strcpy((char *)pkg_send.pkg_dat,"recv fpga set from PC\n\r");
    pkg_send.pkg_xor = 0;
	for(int i = 0; i < PKG_LEN; i++)
	{
		pkg_send.pkg_xor = pkg_send.pkg_xor ^ pkg_send.pkg_dat[i];
	}
    // ----------------------------------------------
    // add task logic

	return fpga_set(pkg_recv);
}
