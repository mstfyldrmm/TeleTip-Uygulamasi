const Doktor = require("../models/doktor.model");

// Create and Save a new Doktor
exports.create = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!"
    });
  }

  console.log(req)
  // Create a Doktor
  const doktor = new Doktor({
    doktor_ISIM: req.body.doktor_ISIM,
    doktor_SOYISIM: req.body.doktor_SOYISIM,
    doktor_MAIL: req.body.doktor_MAIL,
    doktor_SIFRE: req.body.doktor_SIFRE,
    doktor_AnaBilim : req.body.doktor_AnaBilim,
    doktor_uzmanliklar : req.body.doktor_uzmanliklar,
    doktor_mezunOkul : req.body.doktor_mezunOkul,
    doktor_calistigiKurum : req.body.doktor_calistigiKurum
  });

  // Save Doktor in the database
  Doktor.create(doktor, (err, data) => {
    if (err)
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Doktor."
      });
    else res.send(data);
  });
};

// Retrieve all Doktors from the database (with condition).
exports.findAll = (req, res) => {
    const doktor = req.query.doktor;
  
    Doktor.getAll(doktor, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

exports.findAnabilimdali = (req, res) => {
    const doktor = req.query.doktor;

    Doktor.getAllAnabilimdali(doktor, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

exports.findUzmanlik = (req, res) => {
    const doktor = req.query.doktor;

    Doktor.getAllUzmanlik(doktor, (err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };


// Find a single Doktor with a id
exports.findOne = (req, res) => {
    Doktor.findById(req.params.doktor_ID, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Doktor with id ${req.params.doktor_ID}.`
          });
        } else {
          res.status(500).send({
            message: "Error retrieving Doktor with id " + req.params.doktor_ID
          });
        }
      } else res.send(data);
    });
  };

// find all published Doktors
exports.findAllPublished = (req, res) => {
    Doktor.getAllPublished((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving tutorials."
        });
      else res.send(data);
    });
  };

// Update a Doktor identified by the id in the request
exports.update = (req, res) => {
    // Validate Request
    if (!req.body) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
    }
  
    console.log(req.body);
  
    Doktor.updateById(
      req.params.doktor_ID,
      new Doktor(req.body),
      (err, data) => {
        if (err) {
          if (err.kind === "not_found") {
            res.status(404).send({
              message: `Not found Doktor with id ${req.params.doktor_ID}.`
            });
          } else {
            res.status(500).send({
              message: "Error updating Doktor with id " + req.params.doktor_ID
            });
          }
        } else res.send(data);
      }
    );
  };

// Delete a Doktor with the specified id in the request
exports.delete = (req, res) => {
    Doktor.remove(req.params.doktor_ID, (err, data) => {
      if (err) {
        if (err.kind === "not_found") {
          res.status(404).send({
            message: `Not found Doktor with id ${req.params.doktor_ID}.`
          });
        } else {
          res.status(500).send({
            message: "Could not delete Doktor with id " + req.params.doktor_ID
          });
        }
      } else res.send({ message: `Doktor was deleted successfully!` });
    });
  };

// Delete all Doktors from the database.
exports.deleteAll = (req, res) => {
    Doktor.removeAll((err, data) => {
      if (err)
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all tutorials."
        });
      else res.send({ message: `All Doktors were deleted successfully!` });
    });
  };
