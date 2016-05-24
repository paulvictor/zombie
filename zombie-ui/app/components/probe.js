var React = require("react")

var backend = require("../backend.js")

module.exports = React.createClass({
  componentWillMount: function(){
    backend.probePresent().then(t => this.setState({probePresent: t.data}))
  },
  render: function(){
    return <div>
             Probe : {(this.state && this.state.probePresent) ? "Present" : "Not present"}
           </div>
  }
})
