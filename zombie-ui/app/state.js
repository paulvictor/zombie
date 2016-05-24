var redux = require("redux")

var backend = require("./backend.js")

var probeStatus = function(state = false, action){
  switch (action.type){
    case "FOUND_PROBE":
      return true
    default:
      return state
  }
}

var recording = function(state = "NOT RECORDING", action){
  switch (action.type){
    case "RUNNING":
      return "RECORDING"
    case "START":
      return "RECORDING"
    case "STOP":
      return "NOT RECORDING"
    default:
      return state
  }
}

var timeSynced = function(state = false, action){
  switch (action.type){
    case "SYNC":
      return true
    default:
      return state
  }
}
