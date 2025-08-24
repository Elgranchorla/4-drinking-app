const admin = require("firebase-admin");
const data = require("./firestore_seed.json"); // Ajusta la ruta a tu archivo
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function importData() {
  // Wines
  for (const wine of data.wines) {
    await db.collection("wines").doc(wine.id).set(wine);
  }

  // Shops
  for (const shop of data.shops) {
    await db.collection("shops").doc(shop.id).set(shop);
  }

  // WineShops (relaciones N:N)
  for (const ws of data.wineShops) {
    await db.collection("wineShops").add(ws);
  }

  // Tasting Notes
  for (const note of data.tastingNotes) {
    await db
      .collection("wines")
      .doc(note.wineId)
      .collection("tastingNotes")
      .add(note);
  }

  // Questions
  for (const question of data.questions) {
    await db.collection("questions").add(question);
  }

  // Users
  for (const user of data.users) {
    await db.collection("users").doc(user.uid).set(user);
  }

  console.log("✅ Datos importados correctamente.");
}

importData();
