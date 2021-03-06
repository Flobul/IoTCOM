module app_DufourGarageDoorMonitor

open IoTBottomUp as base

open cap_contactSensor


one sig app_DufourGarageDoorMonitor extends IoTApp {
  
  state : one cap_state,
  
  contact : one cap_contactSensor,
} {
  rules = r
}



one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_motionStopTime extends cap_state_attr{} {
  values = cap_state_attr_motionStopTime_val
}

abstract sig cap_state_attr_motionStopTime_val extends AttrValue {}

one sig cap_state_attr_runIn extends cap_state_attr {} {
  values = cap_state_attr_runIn_val
}

abstract sig cap_state_attr_runIn_val extends AttrValue {}
one sig cap_state_attr_runIn_val_on extends cap_state_attr_runIn_val {}
one sig cap_state_attr_runIn_val_off extends cap_state_attr_runIn_val {}



// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_DufourGarageDoorMonitor.contact
  attribute    = cap_contactSensor_attr_contact
  value        = cap_contactSensor_attr_contact_val_open
}


abstract sig r0_cond extends Condition {}


abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DufourGarageDoorMonitor.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}

one sig r1 extends r {}{
  no triggers
  conditions = r1_cond
  commands   = r1_comm
}




abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_DufourGarageDoorMonitor.state
  attribute    = cap_state_attr_runIn
  value        = cap_state_attr_runIn_val_on
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_DufourGarageDoorMonitor.state
  attribute    = cap_state_attr_motionStopTime
  value        = cap_state_attr_motionStopTime_val
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DufourGarageDoorMonitor.state
  attribute = cap_state_attr_runIn
  value = cap_state_attr_runIn_val_on
}



