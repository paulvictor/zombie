var Sequelize = require("sequelize");

var env = process.env.NODE_ENV || "development";

var sequelize = new Sequelize(null, null, null, {storage: __dirname + `/../db/${env}.sqlite`, dialect: "sqlite"})

module.exports = sequelize;
