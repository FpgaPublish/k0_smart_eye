#ifndef FF_BLCK_H
#define FF_BLCK_H
#include "../MACRO.h"

int ff_sd_init();
int ff_sd_wr(char *name_file,
            uint32 addr_file,
            uint32 len_file,
            uint8 md_write //0:wrtie from head, 1: write from end
            );
int ff_sd_rd(char *name_file,
			uint32 addr_file,
			uint32 len_file);

#endif
