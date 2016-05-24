var React = require("react")

var backend = require("../backend.js")

module.exports = React.createClass({
  componentDidMount: function(){
    backend.timeAtDevice().then(t => this.setState({time: t}))
  },
  syncTime: function(){
    backend.sync().then(resp => {
      backend.timeAtDevice().then(t => this.setState({time: t}))
    })
  },
  render: function(){
    return <div>
             Time at server: {this.state && this.state.time}
             <button onClick = {this.syncTime}>Sync</button>
           </div>
  }
})
