module app_wi_fi_connection_notifier_for_android

open IoTBottomUp as base

open cap_switch

lone sig app_wi_fi_connection_notifier_for_android extends IoTApp {
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
  capabilities = app_wi_fi_connection_notifier_for_android.trigObj
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_wi_fi_connection_notifier_for_android.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



