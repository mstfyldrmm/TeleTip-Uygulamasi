module.exports = app => {
    const hastalar = require("../controllers/hasta.controller.js");
  
    var router = require("express").Router();
  
    // Create a new Tutorial
    router.post("/hastalar", hastalar.create);
  
    // Retrieve all Tutorials
    router.get("/hastalar", hastalar.findAll);
  
    // Retrieve a single Tutorial with id
    router.get("/hastalar/:hasta_ID", hastalar.findOne);
  
    // Update a Tutorial with id
    router.put("/hastalar/:hasta_ID", hastalar.update);
  
    // Delete a Tutorial with id
    router.delete("/:id", hastalar.delete);
  
    // Delete all Tutorials
    router.delete("/", hastalar.deleteAll);
  
    app.use('/api', router);
  };
