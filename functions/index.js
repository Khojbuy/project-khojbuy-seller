const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

// const db = admin.firestore();
const fcm = admin.messaging();

exports.displayDevice = functions.firestore
    .document("SellerData/{id}")
    .onUpdate((change, context)=>{
      const userId = context.params.id;
      const newValue = change.after.data();
      const previousValue = change.before.data();
      const oldPriority = previousValue.Priority;
      const newPriority = newValue.Priority;
      const token = newValue.FCM;
      if (oldPriority == false && newPriority == true) {
        const payload = userId;
        fcm.sendToDevice(
            token,
            payload
        );
      }
    });


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

