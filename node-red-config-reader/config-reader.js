var fs = require("fs");

module.exports = function(RED) {
    console.log("reddddddd");
    fs.readFile('/data/config/config-cloud-gateway.json', 'utf8', function (err,data) {
      if (err) {
        return console.log(err);
      }
      console.log(data);
      // console.log(RED);
    });
    function ConfigReader(config) {
        RED.nodes.createNode(this,config);
        var node = this;

        console.log("redddddddyyyyyyy");
        console.log(this);
        console.log("redddddddyyyyyyy");
        console.log(config);
        console.log("redddddddyyyyyyy");
        var nodeContext = this.context();
        console.log(this.context())
        console.log("redddddddyyyyyyy");

        node.on('input', function(msg) {
            console.log('inputtttttt');
            msg.payload = msg.payload.toLowerCase();
            node.send(msg);
        });
    }
    RED.nodes.registerType("config-reader",ConfigReader);
}
