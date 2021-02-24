
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.scheduledFunction = functions.pubsub
    .schedule("00 00 * * *")
    .timeZone("Asia/Kolkata")
    .onRun((context) => {
      console.log("Code triggered");
      const db = admin.firestore();
      const eventAngul = db.collection("Angul");
      eventAngul.get().then((querySnapshot)=>{
        querySnapshot.forEach((doc)=>{
          const list = doc.data()["stories"];
          for (let index = 0; index < list.length; index++) {
            if (list[index]["time"]) {
              console.log(admin.firestore.FieldValue.serverTimestamp());
            }
          }
        });
      });

      return null;
    });
