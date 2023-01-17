module.exports = app => {
    const doktorlar = require("../controllers/doktor.controller.js");
  
    var router = require("express").Router();
  
    // Create a new Tutorial
    router.post("/doktorlar", doktorlar.create);
  
    // Retrieve all Tutorials
    router.get("/doktorlar", doktorlar.findAll);
     
    router.get("/doktorlar/anabilimdali", doktorlar.findAnabilimdali);

    router.get("/doktorlar/uzmanliklar", doktorlar.findUzmanlik);
  
    // Retrieve a single Tutorial with id
    router.get("/doktorlar/:doktor_ID", doktorlar.findOne);
  
    // Update a Tutorial with id
    router.put("/doktorlar/:doktor_ID", doktorlar.update);
  
    // Delete a Tutorial with id
    router.delete("/:id", doktorlar.delete);
  
    // Delete all Tutorials
    router.delete("/", doktorlar.deleteAll);
  
    app.use('/api', router);
  };
