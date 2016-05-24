var fs = require('fs');
var Patient = require("../models/patient.js")
var PatientTemperature = require("../models/patient_temperature.js")
var Restify = require("restify")
var server = Restify.createServer();
server.use(Restify.queryParser());
server.use(Restify.bodyParser());
const childProcess = require('child_process');

global.timer = null

server.post("/time", (req, res, next) => {
  var t = parseInt(req.params.time)
  console.log("Setting time to be " + t)
  childProcess.exec("sudo date --set -s '@" + t + "'", (err, stdout, stderr) => {
    if (error){
      res.send(200, "Time synced with client")
    } else {
      res.send(400, "Failed to set time")
    }
  })
})

server.post("/start", (req, res, next) => {
  global.timer = setInterval(() => {
    Patient.last_patient().then(p => p.record_temperature(pt => {console.log("Recorded temperature")}))
  }, 600)
  res.send(200, "Installed timer")
})

server.post("/stop", (req, res, n) => {
  clearInterval(global.timer);
  global.timer = null;
  res.send(200, "Removed timer")
})

server.get("/running", (req, res, n) => {
  res.send(200, !!global.timer)
})

server.get("/time", (req, res, next) => {
  var d = new Date();
  res.send(200, d.toTimeString())
})

server.post("/patient/new/:name", (req, res, n) => {
  console.log(req.params)
  Patient.create({name: req.params.name}).then(pt => res.send(200, "Patient created with id : " + pt.id))
})

server.get("/probe/present", (req, res, n) => {
  fs.stat("/sys/bus/w1/devices/28-0000053c9d05/w1_slave", (err, s) => {
    res.send(200, !err)
  })
})

server.listen(8081, function() {
  Patient.sync().then(p => {
    PatientTemperature.sync().then(pt => {
      console.log('%s listening at %s', server.name, server.url);
    })
  })
});
