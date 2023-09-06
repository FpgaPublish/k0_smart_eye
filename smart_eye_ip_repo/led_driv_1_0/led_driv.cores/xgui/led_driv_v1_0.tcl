# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "MD_SIM_ABLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NB_LED_STILL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_ERR_INFO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WD_LED_NUMB" -parent ${Page_0}
  #Adding Group
  set led_set_every_4bit [ipgui::add_group $IPINST -name "led set every 4bit" -parent ${Page_0} -layout horizontal]
  ipgui::add_param $IPINST -name "MD_LED_TASK" -parent ${led_set_every_4bit}
  ipgui::add_static_text $IPINST -name "LED task" -parent ${led_set_every_4bit} -text {0: led to state
1: led to flash 
2: led to breath}

  #Adding Group
  set signal_set_every_4bit [ipgui::add_group $IPINST -name "signal set every 4bit" -parent ${Page_0} -layout horizontal]
  ipgui::add_param $IPINST -name "MD_SIG_TRIG" -parent ${signal_set_every_4bit}
  ipgui::add_static_text $IPINST -name "signal trig" -parent ${signal_set_every_4bit} -text {0: high volt trig
1: posedge trig}



}

proc update_PARAM_VALUE.MD_LED_TASK { PARAM_VALUE.MD_LED_TASK } {
	# Procedure called to update MD_LED_TASK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MD_LED_TASK { PARAM_VALUE.MD_LED_TASK } {
	# Procedure called to validate MD_LED_TASK
	return true
}

proc update_PARAM_VALUE.MD_SIG_TRIG { PARAM_VALUE.MD_SIG_TRIG } {
	# Procedure called to update MD_SIG_TRIG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MD_SIG_TRIG { PARAM_VALUE.MD_SIG_TRIG } {
	# Procedure called to validate MD_SIG_TRIG
	return true
}

proc update_PARAM_VALUE.MD_SIM_ABLE { PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to update MD_SIM_ABLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MD_SIM_ABLE { PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to validate MD_SIM_ABLE
	return true
}

proc update_PARAM_VALUE.NB_LED_STILL { PARAM_VALUE.NB_LED_STILL } {
	# Procedure called to update NB_LED_STILL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NB_LED_STILL { PARAM_VALUE.NB_LED_STILL } {
	# Procedure called to validate NB_LED_STILL
	return true
}

proc update_PARAM_VALUE.WD_ERR_INFO { PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to update WD_ERR_INFO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_ERR_INFO { PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to validate WD_ERR_INFO
	return true
}

proc update_PARAM_VALUE.WD_LED_NUMB { PARAM_VALUE.WD_LED_NUMB } {
	# Procedure called to update WD_LED_NUMB when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WD_LED_NUMB { PARAM_VALUE.WD_LED_NUMB } {
	# Procedure called to validate WD_LED_NUMB
	return true
}


proc update_MODELPARAM_VALUE.MD_SIM_ABLE { MODELPARAM_VALUE.MD_SIM_ABLE PARAM_VALUE.MD_SIM_ABLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MD_SIM_ABLE}] ${MODELPARAM_VALUE.MD_SIM_ABLE}
}

proc update_MODELPARAM_VALUE.MD_SIG_TRIG { MODELPARAM_VALUE.MD_SIG_TRIG PARAM_VALUE.MD_SIG_TRIG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MD_SIG_TRIG}] ${MODELPARAM_VALUE.MD_SIG_TRIG}
}

proc update_MODELPARAM_VALUE.MD_LED_TASK { MODELPARAM_VALUE.MD_LED_TASK PARAM_VALUE.MD_LED_TASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MD_LED_TASK}] ${MODELPARAM_VALUE.MD_LED_TASK}
}

proc update_MODELPARAM_VALUE.NB_LED_STILL { MODELPARAM_VALUE.NB_LED_STILL PARAM_VALUE.NB_LED_STILL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NB_LED_STILL}] ${MODELPARAM_VALUE.NB_LED_STILL}
}

proc update_MODELPARAM_VALUE.WD_LED_NUMB { MODELPARAM_VALUE.WD_LED_NUMB PARAM_VALUE.WD_LED_NUMB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_LED_NUMB}] ${MODELPARAM_VALUE.WD_LED_NUMB}
}

proc update_MODELPARAM_VALUE.WD_ERR_INFO { MODELPARAM_VALUE.WD_ERR_INFO PARAM_VALUE.WD_ERR_INFO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WD_ERR_INFO}] ${MODELPARAM_VALUE.WD_ERR_INFO}
}

