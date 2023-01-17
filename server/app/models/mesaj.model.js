const sql = require("../database/database");

// constructor
const Mesaj = function(mesaj) {
  this.doktor_ID = mesaj.doktor_ID;
  this.hasta_ID = mesaj.hasta_ID;
  this.mesaj = mesaj.mesaj;
  this.eklenti_path = mesaj.eklenti_path;
  this.tarih = mesaj.tarih;
  this.yon = mesaj.yon
};

Mesaj.create = (newMesaj, result) => {
  sql.query("INSERT INTO Mesajlar SET ?", newMesaj, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("created mesaj: ", { id: res.insertId, ...newMesaj});
    result(null, { id: res.insertId, ...newMesaj});
  });
};

Mesaj.findById = (mesaj_ID, result) => {
  sql.query(`SELECT * FROM Mesajlar WHERE mesaj_ID = ${mesaj_ID}`, (err, res) => {
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

    // not found Mesaj.with the id
    result({ kind: "not_found" }, null);
  });
};

Mesaj.getAll = (mesaj, result) => {
  let query = "SELECT * FROM Mesajlar ORDER BY tarih ASC";

  if (mesaj) {
    query += ` WHERE mesaj_AD LIKE '%${mesaj}%'`;
  }

  sql.query(query, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("tutorials: ", res);
    result(null, res);
  });
};

Mesaj.getAllPublished = result => {
  sql.query("SELECT * FROM tutorials WHERE published=true", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("tutorials: ", res);
    result(null, res);
  });
};

Mesaj.updateById = (mesaj_ID, mesaj, result) => {
  sql.query(
    "UPDATE Mesajlar SET mesaj_ISIM = ?, mesaj_SOYISIM = ?, mesaj_MAIL = ?, mesaj_SIFRE = ? WHERE mesaj_ID = ?",
    [mesaj.mesaj_ISIM, mesaj.mesaj_SOYISIM, mesaj.mesaj_MAIL, mesaj.mesaj_SIFRE, mesaj_ID],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Mesaj.with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("updated mesaj: ", { mesaj_ID: mesaj_ID, ...mesaj });
      result(null, { mesaj_ID: mesaj_ID, ...mesaj });
    }
  );
};

Mesaj.remove = (id, result) => {
  sql.query("DELETE FROM tutorials WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      // not found Mesaj.with the id
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted tutorial with id: ", id);
    result(null, res);
  });
};

Mesaj.removeAll = result => {
  sql.query("DELETE FROM tutorials", (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log(`deleted ${res.affectedRows} tutorials`);
    result(null, res);
  });
};

module.exports = Mesaj;
