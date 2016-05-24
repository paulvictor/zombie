var Axios = require("axios")

var backend = Axios.create({
  baseURL: "http://localhost:1337/localhost:8081"
});

module.exports = {
  probePresent: () => backend.get("/probe/present"),
  newPatient: name => backend.post("/patient/new/" + name),
  start: () => backend.post("/start"),
  stop: () => backend.post("/stop"),
  sync: () => {
    var d = parseInt(new Date().getTime() / 1000)
    return backend.post("/time", {time: d})
  },
  timeAtDevice: () => backend.get("/time"),
  running: () => backend.get("/running")
}
