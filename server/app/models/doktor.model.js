const sql = require("../database/database");

// constructor
const Doktor = function(doktor) {
  this.doktor_ISIM = doktor.doktor_ISIM;
  this.doktor_SOYISIM = doktor.doktor_SOYISIM;
  this.doktor_MAIL = doktor.doktor_MAIL;
  this.doktor_SIFRE = doktor.doktor_SIFRE;
  this.doktor_AnaBilim = doktor.doktor_AnaBilim;
  this.doktor_uzmanliklar = doktor.doktor_uzmanliklar;
  this.doktor_mezunOkul = doktor.doktor_mezunOkul;
  this.doktor_calistigiKurum = doktor.doktor_calistigiKurum;
};

Doktor.create = (newDoktor, result) => {
  sql.query("INSERT INTO Doktorlar SET ?", newDoktor, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
      return;
    }

    console.log("Doktor sisteme kaydedildi: ", { id: res.insertId, ...newDoktor});
    result(null, { id: res.insertId, ...newDoktor});
  });
};

Doktor.findById = (doktor_ID, result) => {
  sql.query(`SELECT * FROM Doktorlar WHERE doktor_ID = ${doktor_ID}`, (err, res) => {
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

    // not found Doktor.with the id
    result({ kind: "not_found" }, null);
  });
};

Doktor.getAll = (doktor, result) => {
  let query = "SELECT * FROM Doktorlar";

  if (doktor) {
    query += ` WHERE doktor_AD LIKE '%${doktor}%'`;
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


Doktor.getAllAnabilimdali = (doktor, result) => {
  let query = "SELECT doktor_ISIM, doktor_SOYISIM , doktor_AnaBilim FROM Doktorlar;";


  sql.query(query, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("Doktorlar ve anabilimdallari: ", res);
    result(null, res);
  });
};


Doktor.getAllUzmanlik = (doktor, result) => {
  let query = "SELECT doktor_ISIM, doktor_SOYISIM, doktor_uzmanliklar FROM Doktorlar;";


  sql.query(query, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    console.log("Doktorlar ve uzmanliklari: ", res);
    result(null, res);
  });
};



Doktor.updateById = (doktor_ID, doktor, result) => {
  sql.query(
    "UPDATE Doktorlar SET doktor_MAIL = ?, doktor_SIFRE = ?, doktor_AnaBilim = ?, doktor_calistigiKurum = ?, doktor_uzmanliklar = ? WHERE doktor_ID = ?",
    [doktor.doktor_MAIL, doktor.doktor_SIFRE, doktor.doktor_AnaBilim, doktor.doktor_calistigiKurum, doktor.doktor_uzmanliklar, doktor_ID],
    (err, res) => {
      if (err) {
        console.log("error: ", err);
        result(null, err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Doktor.with the id
        result({ kind: "not_found" }, null);
        return;
      }

      console.log("doktor bilgileri guncellendi: ", { doktor_ID: doktor_ID, ...doktor });
      result(null, { doktor_ID: doktor_ID, ...doktor });
    }
  );
};

Doktor.remove = (id, result) => {
  sql.query("DELETE FROM tutorials WHERE id = ?", id, (err, res) => {
    if (err) {
      console.log("error: ", err);
      result(null, err);
      return;
    }

    if (res.affectedRows == 0) {
      // not found Doktor.with the id
      result({ kind: "not_found" }, null);
      return;
    }

    console.log("deleted tutorial with id: ", id);
    result(null, res);
  });
};

Doktor.removeAll = result => {
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

module.exports = Doktor;
