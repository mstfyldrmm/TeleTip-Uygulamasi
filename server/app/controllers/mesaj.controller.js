const Mesaj = require("../models/mesaj.model.js");

// Create and Save a new Mesaj
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
  }

  console.log(req)
  // Create a Mesaj
  const mesaj = new Mesaj({
    doktor_ID: req.body.doktor_ID,
    hasta_ID: req.body.hasta_ID,
    mesaj: req.body.mesaj,
    tarih : req.body.tarih,
    yon : req.body.yon,
    eklenti_path: req.body.eklenti_path || false
  });

  // Save Mesaj in the database
  Mesaj.create(mesaj, (err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Mesaj."
      });
    else res.send(data);
  });
};

// Retrieve all Mesajs from the database (with condition).
exports.findAll = (req, res) => {
    const mesaj = req.query.mesaj;
  
    Mesaj.getAll(mesaj, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

// Find a single Mesaj with a id
exports.findOne = (req, res) => {
    Mesaj.findById(req.params.mesaj_ID, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Mesaj with id ${req.params.mesaj_ID}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Mesaj with id " + req.params.mesaj_ID
          });
        }
      } else res.send(data);
    });
  };

// find all published Mesajs
exports.findAllPublished = (req, res) => {
    Mesaj.getAllPublished((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

// Update a Mesaj identified by the id in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    console.log(req.body);
  
    Mesaj.updateById(
      req.params.mesaj_ID,
      new Mesaj(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Mesaj with id ${req.params.mesaj_ID}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Mesaj with id " + req.params.mesaj_ID
            });
          }
        } else res.send(data);
      }
    );
  };

// Delete a Mesaj with the specified id in the request
exports.delete = (req, res) => {
    Mesaj.remove(req.params.mesaj_ID, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Mesaj with id ${req.params.mesaj_ID}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Mesaj with id " + req.params.mesaj_ID
          });
        }
      } else res.send({ message: `Mesaj was deleted successfully!` });
    });
  };

// Delete all Mesajs from the database.
exports.deleteAll = (req, res) => {
    Mesaj.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all tutorials."
        });
      else res.send({ message: `All Mesajs were deleted successfully!` });
    });
  };
