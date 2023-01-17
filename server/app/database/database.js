const mysql = require('mysql');


const mysqlConnection = mysql.createConnection({
  host : '127.0.0.1',
  port : '3306',
  user : 'root',
  password : 'password',
  database : 'db_hastane_teletip'
});

mysqlConnection.connect(function(err) {
  if(err) throw err;
  console.log('Database basarili bir sekilde baglanildi.'); 
})

module.exports = mysqlConnection;