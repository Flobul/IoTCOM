module app_DoubleTapSwitchforHelloHomeAction

open IoTBottomUp as base

open cap_userInput
open cap_switch


one sig app_DoubleTapSwitchforHelloHomeAction extends IoTApp {
  
  flashLights : some cap_switch,
  
  sendPushMessage : one cap_userInput,
  state : one cap_state,
  master : lone cap_switch,
} {
  rules = r
}

one sig cap_userInput_attr_sendPushMessage_val_yes extends cap_userInput_attr_sendPushMessage_val {}
one sig cap_userInput_attr_sendPushMessage_val_no extends cap_userInput_attr_sendPushMessage_val {}

one sig cap_userInput_attr_sendPushMessage extends cap_userInput_attr {}
{
    values = cap_userInput_attr_sendPushMessage_val
} 
abstract sig cap_userInput_attr_sendPushMessage_val extends cap_userInput_attr_value_val {}

one sig cap_state extends Capability {} {
  attributes = cap_state_attr
}
abstract sig cap_state_attr extends Attribute {}


one sig cap_state_attr_lastActivated extends cap_state_attr{} {
  values = cap_state_attr_lastActivated_val
}

abstract sig cap_state_attr_lastActivated_val extends AttrValue {}


// application rules base class

abstract sig r extends Rule {}

one sig r0 extends r {}{
  triggers   = r0_trig
  conditions = r0_cond
  commands   = r0_comm
}

abstract sig r0_trig extends Trigger {}

one sig r0_trig0 extends r0_trig {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  no value
}


abstract sig r0_cond extends Condition {}

one sig r0_cond0 extends r0_cond {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_on
}
one sig r0_cond1 extends r0_cond {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val
}

abstract sig r0_comm extends Command {}

one sig r0_comm0 extends r0_comm {} {
  capability   = app_DoubleTapSwitchforHelloHomeAction.state
  attribute = cap_state_attr_lastActivated
  value = cap_state_attr_lastActivated_val
}

one sig r1 extends r {}{
  triggers   = r1_trig
  conditions = r1_cond
  commands   = r1_comm
}

abstract sig r1_trig extends Trigger {}

one sig r1_trig0 extends r1_trig {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  no value
}


abstract sig r1_cond extends Condition {}

one sig r1_cond0 extends r1_cond {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val - cap_switch_attr_switch_val_on
}
one sig r1_cond1 extends r1_cond {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val_off
}
one sig r1_cond2 extends r1_cond {} {
  capabilities = app_DoubleTapSwitchforHelloHomeAction.master
  attribute    = cap_switch_attr_switch
  value        = cap_switch_attr_switch_val
}

abstract sig r1_comm extends Command {}

one sig r1_comm0 extends r1_comm {} {
  capability   = app_DoubleTapSwitchforHelloHomeAction.state
  attribute = cap_state_attr_lastActivated
  value = cap_state_attr_lastActivated_val
}



