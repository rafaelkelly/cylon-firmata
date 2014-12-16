var Cylon = require('cylon');

Cylon
  .robot()
  .connection('arduino', { adaptor: 'firmata', port: '/dev/ttyACM0' })
  .device('mpl115a2', { driver: 'mpl115a2' })
  .on('ready', function(bot) {
    bot.mpl115a2.getTemperature(function(err, data) {
      var temp = data['temperature'],
      pressure = data['pressure'];

      console.log("temperature " + temp  + " pressure " + pressure);
    });
  });

Cylon.start();