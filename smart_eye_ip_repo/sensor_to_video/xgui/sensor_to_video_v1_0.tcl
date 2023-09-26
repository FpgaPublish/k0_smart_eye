# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "MD_SIM_ABLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NB_CLK_FRE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_CONFIG_INFO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_ERR_INFO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_SENSOR_DATA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_VIDEO_DATA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_VIDEO_INFO" -parent ${Page_0}


}

proc update_PARAM_VALUE.MD_SIM_ABLE { PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to update MD_SIM_ABLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MD_SIM_ABLE { PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to validate MD_SIM_ABLE
	return true
}

proc update_PARAM_VALUE.NB_CLK_FRE { PARAM_VALUE.NB_CLK_FRE } {
	# Procedure called to update NB_CLK_FRE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NB_CLK_FRE { PARAM_VALUE.NB_CLK_FRE } {
	# Procedure called to validate NB_CLK_FRE
	return true
}

proc update_PARAM_VALUE.WD_CONFIG_INFO { PARAM_VALUE.WD_CONFIG_INFO } {
	# Procedure called to update WD_CONFIG_INFO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_CONFIG_INFO { PARAM_VALUE.WD_CONFIG_INFO } {
	# Procedure called to validate WD_CONFIG_INFO
	return true
}

proc update_PARAM_VALUE.WD_ERR_INFO { PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to update WD_ERR_INFO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_ERR_INFO { PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to validate WD_ERR_INFO
	return true
}

proc update_PARAM_VALUE.WD_SENSOR_DATA { PARAM_VALUE.WD_SENSOR_DATA } {
	# Procedure called to update WD_SENSOR_DATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_SENSOR_DATA { PARAM_VALUE.WD_SENSOR_DATA } {
	# Procedure called to validate WD_SENSOR_DATA
	return true
}

proc update_PARAM_VALUE.WD_VIDEO_DATA { PARAM_VALUE.WD_VIDEO_DATA } {
	# Procedure called to update WD_VIDEO_DATA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_VIDEO_DATA { PARAM_VALUE.WD_VIDEO_DATA } {
	# Procedure called to validate WD_VIDEO_DATA
	return true
}

proc update_PARAM_VALUE.WD_VIDEO_INFO { PARAM_VALUE.WD_VIDEO_INFO } {
	# Procedure called to update WD_VIDEO_INFO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_VIDEO_INFO { PARAM_VALUE.WD_VIDEO_INFO } {
	# Procedure called to validate WD_VIDEO_INFO
	return true
}


proc update_MODELPARAM_VALUE.MD_SIM_ABLE { MODELPARAM_VALUE.MD_SIM_ABLE PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MD_SIM_ABLE}] ${MODELPARAM_VALUE.MD_SIM_ABLE}
}

proc update_MODELPARAM_VALUE.NB_CLK_FRE { MODELPARAM_VALUE.NB_CLK_FRE PARAM_VALUE.NB_CLK_FRE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NB_CLK_FRE}] ${MODELPARAM_VALUE.NB_CLK_FRE}
}

proc update_MODELPARAM_VALUE.WD_CONFIG_INFO { MODELPARAM_VALUE.WD_CONFIG_INFO PARAM_VALUE.WD_CONFIG_INFO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_CONFIG_INFO}] ${MODELPARAM_VALUE.WD_CONFIG_INFO}
}

proc update_MODELPARAM_VALUE.WD_VIDEO_INFO { MODELPARAM_VALUE.WD_VIDEO_INFO PARAM_VALUE.WD_VIDEO_INFO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_VIDEO_INFO}] ${MODELPARAM_VALUE.WD_VIDEO_INFO}
}

proc update_MODELPARAM_VALUE.WD_VIDEO_DATA { MODELPARAM_VALUE.WD_VIDEO_DATA PARAM_VALUE.WD_VIDEO_DATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_VIDEO_DATA}] ${MODELPARAM_VALUE.WD_VIDEO_DATA}
}

proc update_MODELPARAM_VALUE.WD_SENSOR_DATA { MODELPARAM_VALUE.WD_SENSOR_DATA PARAM_VALUE.WD_SENSOR_DATA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_SENSOR_DATA}] ${MODELPARAM_VALUE.WD_SENSOR_DATA}
}

proc update_MODELPARAM_VALUE.WD_ERR_INFO { MODELPARAM_VALUE.WD_ERR_INFO PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_ERR_INFO}] ${MODELPARAM_VALUE.WD_ERR_INFO}
}

