module app_wifi_off_upon_arrival_at_work

open IoTBottomUp as base

open cap_switch

lone sig app_wifi_off_upon_arrival_at_work extends IoTApp {
  trigObj : one cap_switch,
  switch : one cap_switch,
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
  capabilities = app_wifi_off_upon_arrival_at_work.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_wifi_off_upon_arrival_at_work.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}



