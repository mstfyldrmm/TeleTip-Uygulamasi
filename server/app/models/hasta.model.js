const mysql = require("../database/database");

// constructor
const Hasta = function(hasta) {
  this.hasta_ISIM = hasta.hasta_ISIM;
  this.hasta_SOYISIM = hasta.hasta_SOYISIM;
  this.hasta_MAIL = hasta.hasta_MAIL;
  this.hasta_SIFRE = hasta.hasta_SIFRE;
};

Hasta.create = (newHasta, result) => {
  mysql.query("INSERT INTO Hastalar SET ?", newHasta, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("Hasta kaydedildi: ", { id: res.insertId, ...newHasta});
    result(null, { id: res.insertId, ...newHasta});
  });
};

Hasta.findById = (hasta_ID, result) => {
  mysql.query(`SELECT * FROM Hastalar WHERE hasta_ID = ${hasta_ID}`, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    if (res.length) {
      console.log("found tutorial: ", res[0]);
      result(null, res[0]);
      return;
    }

    // not found Hasta.with the id
    result({ kind: "bulunamadi" }, null);
  });
};

Hasta.getAll = (hasta, result) => {
  let query = "SELECT * FROM Hastalar";

  if (hasta) {
    query += ` WHERE hasta_AD LIKE '%${hasta}%'`;
  }

  mysql.query(query, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("tutorials: ", res);
    result(null, res);
  });
};

Hasta.getAllPublished = result => {
  mysql.query("SELECT * FROM tutorials WHERE published=true", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("tutorials: ", res);
    result(null, res);
  });
};

Hasta.updateById = (hasta_ID, hasta, result) => {
  mysql.query(
    "UPDATE Hastalar SET hasta_ISIM = ?, hasta_SOYISIM = ?, hasta_MAIL = ?, hasta_SIFRE = ? WHERE hasta_ID = ?",
    [hasta.hasta_ISIM, hasta.hasta_SOYISIM, hasta.hasta_MAIL, hasta.hasta_SIFRE, hasta_ID],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Hasta.with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("hasta bilgileri guncellendi: ", { hasta_ID: hasta_ID, ...hasta });
      result(null, { hasta_ID: hasta_ID, ...hasta });
    }
  );
};

Hasta.remove = (id, result) => {
  mysql.query("DELETE FROM tutorials WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      // not found Hasta.with the id
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted tutorial with id: ", id);
    result(null, res);
  });
};

Hasta.removeAll = result => {
  mysql.query("DELETE FROM tutorials", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} tutorials`);
    result(null, res);
  });
};

module.exports = Hasta;
