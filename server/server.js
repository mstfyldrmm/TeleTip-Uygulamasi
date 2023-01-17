const express = require("express");
const cors = require("cors");


const app = express();

var corsOptions = {
  origin: "http::8081"
};

app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(express.json());

// // parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

// simple route
app.get("/", (_req, res) => {
  res.json({ message: "Basarili." });
});

//hasta icin gerekli moduller dahil edildi
require("./app/routes/hasta.routes")(app);

//Doktor icin gerekli moduller dahil edildi
require("./app/routes/doktor.routes.js")(app);

require("./app/routes/mesaj.routes.js")(app);

var server = app.listen(8081, function () {
  var host = server.address().address
  var port = server.address().port
  
  console.log("Example app listening at http://%s:%s", host, port)
})


const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});