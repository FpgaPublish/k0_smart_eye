# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "MD_SIM_ABLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NB_ACK_BIT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NB_BYT_ONC" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NB_SCL_PER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NB_SYS_PER" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_ERR_INFO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_SHK_ADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_SHK_DATA" -parent ${Page_0}


}

proc update_PARAM_VALUE.MD_SIM_ABLE { PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to update MD_SIM_ABLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MD_SIM_ABLE { PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to validate MD_SIM_ABLE
	return true
}

proc update_PARAM_VALUE.NB_ACK_BIT { PARAM_VALUE.NB_ACK_BIT } {
	# Procedure called to update NB_ACK_BIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NB_ACK_BIT { PARAM_VALUE.NB_ACK_BIT } {
	# Procedure called to validate NB_ACK_BIT
	return true
}

proc update_PARAM_VALUE.NB_BYT_ONC { PARAM_VALUE.NB_BYT_ONC } {
	# Procedure called to update NB_BYT_ONC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NB_BYT_ONC { PARAM_VALUE.NB_BYT_ONC } {
	# Procedure called to validate NB_BYT_ONC
	return true
}

proc update_PARAM_VALUE.NB_SCL_PER { PARAM_VALUE.NB_SCL_PER } {
	# Procedure called to update NB_SCL_PER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NB_SCL_PER { PARAM_VALUE.NB_SCL_PER } {
	# Procedure called to validate NB_SCL_PER
	return true
}

proc update_PARAM_VALUE.NB_SYS_PER { PARAM_VALUE.NB_SYS_PER } {
	# Procedure called to update NB_SYS_PER when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NB_SYS_PER { PARAM_VALUE.NB_SYS_PER } {
	# Procedure called to validate NB_SYS_PER
	return true
}

proc update_PARAM_VALUE.WD_ERR_INFO { PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to update WD_ERR_INFO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_ERR_INFO { PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to validate WD_ERR_INFO
	return true
}

proc update_PARAM_VALUE.WD_SHK_ADDR { PARAM_VALUE.WD_SHK_ADDR } {
	# Procedure called to update WD_SHK_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_SHK_ADDR { PARAM_VALUE.WD_SHK_ADDR } {
	# Procedure called to validate WD_SHK_ADDR
	return true
}

proc update_PARAM_VALUE.WD_SHK_DATA { PARAM_VALUE.WD_SHK_DATA } {
	# Procedure called to update WD_SHK_DATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_SHK_DATA { PARAM_VALUE.WD_SHK_DATA } {
	# Procedure called to validate WD_SHK_DATA
	return true
}


proc update_MODELPARAM_VALUE.MD_SIM_ABLE { MODELPARAM_VALUE.MD_SIM_ABLE PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MD_SIM_ABLE}] ${MODELPARAM_VALUE.MD_SIM_ABLE}
}

proc update_MODELPARAM_VALUE.NB_SYS_PER { MODELPARAM_VALUE.NB_SYS_PER PARAM_VALUE.NB_SYS_PER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NB_SYS_PER}] ${MODELPARAM_VALUE.NB_SYS_PER}
}

proc update_MODELPARAM_VALUE.NB_SCL_PER { MODELPARAM_VALUE.NB_SCL_PER PARAM_VALUE.NB_SCL_PER } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NB_SCL_PER}] ${MODELPARAM_VALUE.NB_SCL_PER}
}

proc update_MODELPARAM_VALUE.NB_BYT_ONC { MODELPARAM_VALUE.NB_BYT_ONC PARAM_VALUE.NB_BYT_ONC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NB_BYT_ONC}] ${MODELPARAM_VALUE.NB_BYT_ONC}
}

proc update_MODELPARAM_VALUE.NB_ACK_BIT { MODELPARAM_VALUE.NB_ACK_BIT PARAM_VALUE.NB_ACK_BIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NB_ACK_BIT}] ${MODELPARAM_VALUE.NB_ACK_BIT}
}

proc update_MODELPARAM_VALUE.WD_SHK_DATA { MODELPARAM_VALUE.WD_SHK_DATA PARAM_VALUE.WD_SHK_DATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_SHK_DATA}] ${MODELPARAM_VALUE.WD_SHK_DATA}
}

proc update_MODELPARAM_VALUE.WD_SHK_ADDR { MODELPARAM_VALUE.WD_SHK_ADDR PARAM_VALUE.WD_SHK_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_SHK_ADDR}] ${MODELPARAM_VALUE.WD_SHK_ADDR}
}

proc update_MODELPARAM_VALUE.WD_ERR_INFO { MODELPARAM_VALUE.WD_ERR_INFO PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_ERR_INFO}] ${MODELPARAM_VALUE.WD_ERR_INFO}
}

