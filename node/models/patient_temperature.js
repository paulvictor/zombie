var sequelize = require("./sequelize.js");
var Sequelize = require("sequelize");
var Patient = require("./patient.js");

var PatientTemperature = sequelize.define("patient_temperatures", {
  sampledAt: {type: Sequelize.DATE, defaultValue: Sequelize.NOW},
  temperature: {type: Sequelize.FLOAT},
  patient_id: {type: Sequelize.INTEGER}
});


module.exports = PatientTemperature;
