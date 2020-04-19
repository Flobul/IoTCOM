module app_turn-on-sump-pump-when-water-detected

open IoTBottomUp as base

open cap_waterSensor
open cap_switch

lone sig app_turn-on-sump-pump-when-water-detected extends IoTApp {
  trigObj : one cap_waterSensor,
} {
  rules = r
}


// application rules base class

abstract sig r extends Rule {}

one sig r1 extends r {}{
  triggers   = r1_trig
  no conditions 
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_turn-on-sump-pump-when-water-detected.trigObj
  attribute    = cap_waterSensor_attr_water
  value        = cap_waterSensor_attr_water_val_wet
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_turn-on-sump-pump-when-water-detected.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


