var sequelize = require("./sequelize.js");
var Sequelize = require("sequelize");
var PatientTemperature = require("./patient_temperature.js");
var Observable = require("rx").Observable;
var fs = require('fs');

module.exports = sequelize.define("patients", {
  id: {type:Sequelize.INTEGER, autoIncrement: true, primaryKey: true},
  arrivedOn: {type:Sequelize.DATE, defaultValue: Sequelize.NOW},
  name: {type: Sequelize.STRING, allowNull: false}
},{
  timestamps: true,
  underscored: true,
  classMethods: {
    last_patient: function(){
      return this.findOne({order: [["id", "DESC"]]});
    }
  },
  instanceMethods: {
    record_temperature: function(cb){
      fs.readFile("/sys/bus/w1/devices/28-0000053c9d05/w1_slave", (err, contents) => {
        if (err){
          console.log("error reading temperature")
        } else {
          var lines = contents.split("\n");
          var tempLine = lines[lines.length() - 1]
          var temp = parseFloat(tempLine.split("=")[1])
          PatientTemperature.create({temperature: temp, patient_id: this.id}).then(cb)
        }
      })
    }
  }
});
