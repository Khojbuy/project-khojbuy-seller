const functions = require("firebase-functions");
const admin = require("firebase-admin");


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
exports.scheduledFunction = functions.pubsub.schedule("every 1 minute")
    .timeZone("Asia/Kolkata")
    .onRun((context) => {
      const ref = admin.firestore().collection("Trial").doc("a");
      const data = ref.get();
      const value = data["num"]++;
      ref.update({
        num: value,
      });
      console.log("This will be run every 60 minutes!");
      return null;
    });
