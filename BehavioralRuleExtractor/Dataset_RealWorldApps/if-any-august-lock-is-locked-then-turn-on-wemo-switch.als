module app_if_any_august_lock_is_locked_then_turn_on_wemo_switch

open IoTBottomUp as base

open cap_lock
open cap_switch

lone sig app_if_any_august_lock_is_locked_then_turn_on_wemo_switch extends IoTApp {
  trigObj : one cap_lock,
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
  capabilities = app_if_any_august_lock_is_locked_then_turn_on_wemo_switch.trigObj
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}


abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_if_any_august_lock_is_locked_then_turn_on_wemo_switch.switch
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}



