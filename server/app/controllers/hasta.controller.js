const Hasta = require("../models/hasta.model.js");

// Create and Save a new Hasta
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
  }

  console.log(req)
  // Create a Hasta
  const hasta = new Hasta({
    hasta_ISIM: req.body.hasta_ISIM,
    hasta_SOYISIM: req.body.hasta_SOYISIM,
    hasta_MAIL: req.body.hasta_MAIL,
    hasta_SIFRE: req.body.hasta_SIFRE
  });

  // Save Hasta in the database
  Hasta.create(hasta, (err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Hasta."
      });
    else res.send(data);
  });
};

// Retrieve all Hastas from the database (with condition).
exports.findAll = (req, res) => {
    const hasta = req.query.hasta;
  
    Hasta.getAll(hasta, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

// Find a single Hasta with a id
exports.findOne = (req, res) => {
    Hasta.findById(req.params.hasta_ID, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Hasta with id ${req.params.hasta_ID}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Hasta with id " + req.params.hasta_ID
          });
        }
      } else res.send(data);
    });
  };

// find all published Hastas
exports.findAllPublished = (req, res) => {
    Hasta.getAllPublished((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

// Update a Hasta identified by the id in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    console.log(req.body);
  
    Hasta.updateById(
      req.params.hasta_ID,
      new Hasta(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Hasta with id ${req.params.hasta_ID}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Hasta with id " + req.params.hasta_ID
            });
          }
        } else res.send(data);
      }
    );
  };

// Delete a Hasta with the specified id in the request
exports.delete = (req, res) => {
    Hasta.remove(req.params.hasta_ID, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Hasta with id ${req.params.hasta_ID}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Hasta with id " + req.params.hasta_ID
          });
        }
      } else res.send({ message: `Hasta was deleted successfully!` });
    });
  };

// Delete all Hastas from the database.
exports.deleteAll = (req, res) => {
    Hasta.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all tutorials."
        });
      else res.send({ message: `All Hastas were deleted successfully!` });
    });
  };
