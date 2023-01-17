module.exports = app => {
    const mesajlar = require("../controllers/mesaj.controller.js");
  
    var router = require("express").Router();
  
    // Create a new Tutorial
    router.post("/mesajlar", mesajlar.create);
  
    // Retrieve all Tutorials
    router.get("/mesajlar", mesajlar.findAll);
   
    // Retrieve a single Tutorial with id
    router.get("/mesajlar/:mesaj_ID", mesajlar.findOne);
  
    // Update a Tutorial with id
    router.put("/mesajlar/:mesaj_ID", mesajlar.update);
  
    // Delete a Tutorial with id
    router.delete("/:id", mesajlar.delete);
  
    // Delete all Tutorials
    router.delete("/", mesajlar.deleteAll);
  
    app.use('/api', router);
  };
