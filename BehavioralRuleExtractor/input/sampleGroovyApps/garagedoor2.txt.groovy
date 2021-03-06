/**
 *  Open Garage, Open Door when I arrive
 *  Modified from: Ridiculously Automated Garage Door by SmartThings
 *
 *  Author: SmartThings
 *  Date: 2013-03-10
 *
 * Monitors arrival and departure of car(s) and
 *
 *    1) opens door when car arrives,
 *    2) closes door after car has departed (for N minutes),  
 *    3) closes door when door was opened due to arrival,
 */


// Automatically generated. Make future change here.
definition(
    name: "garage door 2",
    namespace: "",
    author: "dinkie89@comcast.net",
    description: "auto open close garage door",
    category: "My Apps",
    iconUrl: "https://s3.amazonaws.com/smartapp-icons/Convenience/Cat-Convenience.png",
    iconX2Url: "https://s3.amazonaws.com/smartapp-icons/Convenience/Cat-Convenience%402x.png")

preferences {

	section("Garage door") {
		input "doorSensor", "capability.contactSensor", title: "Which sensor?"
		input "momentarySwitch", "capability.switch", title: "Which switch?"
		input "openThreshold", "number", title: "Warn when open longer than (optional)",description: "Number of minutes", required: false
		input "phone", "phone", title: "Warn with text message (optional)", description: "Phone Number", required: false
	}
	section("Car(s) using this garage door") {
		input "cars", "capability.presenceSensor", title: "Presence sensor", description: "Which car(s)?", multiple: true, required: false
		
	}
	
	section("False alarm threshold (defaults to 10 min)") {
		input "falseAlarmThreshold", "number", title: "Number of minutes", required: false
	}
}

def installed() {
	log.trace "installed()"
	subscribe()
}

def updated() {
	log.trace "updated()"
	unsubscribe()
	subscribe()
}

def subscribe() {
	log.debug "present: ${cars.collect{it.displayName + ': ' + it.currentPresence}}"
	subscribe(doorSensor, "contact", garageDoorContact)

	subscribe(cars, "presence", carPresence)
	
		}


def doorOpenCheck()
{
	final thresholdMinutes = openThreshold
	if (thresholdMinutes) {
		def currentState = doorSensor.contactState
		log.debug "doorOpenCheck"
		if (currentState?.value == "open") {
			log.debug "open for ${now() - currentState.date.time}, openDoorNotificationSent: ${state.openDoorNotificationSent}"
			if (!state.openDoorNotificationSent && now() - currentState.date.time > thresholdMinutes * 60 *1000) {
				def msg = "${doorSensor.displayName} has been open for ${thresholdMinutes} minutes"
				log.info msg
				sendPush msg
				if (phone) {
					sendSms phone, msg
				}
				state.openDoorNotificationSent = true
			}
		}
		else {
			state.openDoorNotificationSent = false
		}
	}
}

def carPresence(evt)
{
	log.info "$evt.name: $evt.value"
	// time in which there must be no "not present" events in order to open the door
	final openDoorAwayInterval = falseAlarmThreshold ? falseAlarmThreshold * 60 : 60

	if (evt.value == "present") {
		// A car comes home

		def car = getCar(evt)
		def t0 = new Date(now() - (openDoorAwayInterval * 1000))
		def states = car.statesSince("presence", t0)
		def recentNotPresentState = states.find{it.value == "not present"}

		if (recentNotPresentState) {
			log.debug "Not opening ${momentarySwitch.displayName} since car was not present at ${recentNotPresentState.date}, less than ${openDoorAwayInterval} sec ago"
		}
		else {
			if (doorSensor.currentContact == "closed") {
				openDoor()
				sendPush "Opening garage door due to arrival of ${car.displayName}"
				state.appOpenedDoor = now()
			}
			else {
				log.debug "Not opening ${doorSensor.displayName} because its already open"
			}
            
    	}
	}
	else {
		// A car departs
		if (doorSensor.currentContact == "open") {
			closeDoor()
			log.debug "Closing ${momentarySwitch.displayName} after departure"
			sendPush("Closing ${momentarySwitch.displayName} after departure")
		}
		else {
			log.debug "Not closing ${momentarySwitch.displayName} because its already closed"
		}
	}
}

    

def garageDoorContact(evt)
{
	log.info "garageDoorContact, $evt.name: $evt.value"
	if (evt.value == "open") {
		schedule("0 * * * * ?", "doorOpenCheck")
	}
	else {
		unschedule("doorOpenCheck")
	}
}



	


def accelerationActive(evt)
{
	log.info "$evt.name: $evt.value"

	
	}


private openDoor()
{
	if (doorSensor.currentContact == "closed") {
		log.debug "opening door"
		momentarySwitch.on()
        momentarySwitch.off(delay: 4000)
	}
}

private closeDoor()
{
	if (doorSensor.currentContact == "open") {
		log.debug "closing door"
		momentarySwitch.on()
        momentarySwitch.off(delay: 4000)
	}
}

private getCar(evt)
{
	cars.find{it.id == evt.deviceId}
}
