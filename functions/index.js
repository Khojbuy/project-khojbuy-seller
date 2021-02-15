
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

admin.auth().getUser("RfuXBlAhWZMCH4klwVEV1kl1tMc2").console.log("Fetched");
exports.orderStatusChange = functions.firestore.document("Order").onUpdate(
    (change, context)=>
      console.log(change + context)
);
