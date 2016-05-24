var React = require("react")
var ReactDOM = require("react-dom")

var Probe = require("./app/components/probe.js")
var Time = require("./app/components/time.js")
var Center = require("./app/components/center.js")

var App = React.createClass({
  render: function(){
    console.log("foo")
    return <div>
      <Probe />
      <Center />
      <Time />
    </div>
  }
})


ReactDOM.render(<App />, document.getElementById("root"))
