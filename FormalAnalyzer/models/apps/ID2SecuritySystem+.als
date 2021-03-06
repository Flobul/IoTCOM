module app_ID2SecuritySystem

open IoTBottomUp as base

open cap_lock
open cap_switch
open cap_runIn
open cap_presenceSensor


one sig app_ID2SecuritySystem extends IoTApp {
  
  presence : one cap_presenceSensor,
  
  runIn : one cap_state,
  
  state : one cap_state,
  
  lock1 : some cap_lock,
  
  switches : some cap_switch,
} {
  rules = r
}

one sig cap_state extends cap_runIn {} {
  attributes = cap_state_attr + cap_runIn_attr
}
abstract sig cap_state_attr extends Attribute {}


// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_ID2SecuritySystem.presence
  attribute    = cap_presenceSensor_attr_presence
  no value        //= cap_presenceSensor_attr_presence_val
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_ID2SecuritySystem.lock1
  attribute    = cap_lock_attr_lock
  value        = cap_lock_attr_lock_val_locked
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_ID2SecuritySystem.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_present
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_ID2SecuritySystem.lock1
  attribute = cap_lock_attr_lock
  value = cap_lock_attr_lock_val_unlocked
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_ID2SecuritySystem.presence
  attribute    = cap_presenceSensor_attr_presence
  no value        //= cap_presenceSensor_attr_presence_val
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_ID2SecuritySystem.presence
  attribute    = cap_presenceSensor_attr_presence
  value        = cap_presenceSensor_attr_presence_val_not_present
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_ID2SecuritySystem.runIn
  attribute = cap_runIn_attr_runIn
  value = cap_runIn_attr_runIn_val_on
}

one sig r2 extends r {}{
  no triggers
  conditions = r2_cond
  commands   = r2_comm
}




abstract sig r2_cond extends Condition {}

one sig r2_cond0 extends r2_cond {} {
  capabilities = app_ID2SecuritySystem.runIn
  attribute    = cap_runIn_attr_runIn
  value        = cap_runIn_attr_runIn_val_on
}

abstract sig r2_comm extends Command {}

one sig r2_comm0 extends r2_comm {} {
  capability   = app_ID2SecuritySystem.switches
  attribute = cap_switch_attr_switch
  value = cap_switch_attr_switch_val_off
}
