var React = require("react")

var backend = require("../backend.js")

module.exports = React.createClass({
  componentDidMount: function(){
    backend.running().then(r => {this.setState({recording: r.data})})
  },
  toggleRecording: function(){
    if (this.state.recording){
      backend.stop().then(r => {
        backend.running().then(r => {this.setState({recording: r.data})})
      })
    } else {
      backend.start().then(r => {
        backend.running().then(r => {this.setState({recording: r.data})})
      })
    }
  },
  render: function(){
    return <div>
      Current recording status : {this.state && this.state.recording}
      <button onClick = {this.toggleRecording}>{this.state && this.state.recording ? "STOP" : "START"}</button>
    </div>
  }
})
