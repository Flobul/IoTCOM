module app_receive_a_notification_when_a_certain_device_disconnects_from_onhub

open IoTBottomUp as base

open cap_switch

lone sig app_receive_a_notification_when_a_certain_device_disconnects_from_onhub extends IoTApp {
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
  capabilities = app_receive_a_notification_when_a_certain_device_disconnects_from_onhub.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_receive_a_notification_when_a_certain_device_disconnects_from_onhub.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



