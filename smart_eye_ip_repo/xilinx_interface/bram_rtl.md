## BRAM RTL

```verilog
output  [WD_BRAM_ADDR-1:0]  m_bram_0_addr,
output                      m_bram_0_clk ,
output  [WD_BRAM_DATA-1:0]  m_bram_0_din ,
input   [WD_BRAM_DATA-1:0]  m_bram_0_dout,
output                      m_bram_0_en  ,
output                      m_bram_0_rst ,
output                      m_bram_0_we  ,

input   [WD_BRAM_ADDR-1:0]  s_bram_0_addr,
input                       s_bram_0_clk ,
input   [WD_BRAM_DATA-1:0]  s_bram_0_din ,
output  [WD_BRAM_DATA-1:0]  s_bram_0_dout,
input                       s_bram_0_en  ,
input                       s_bram_0_rst ,
input                       s_bram_0_we  ,


```
