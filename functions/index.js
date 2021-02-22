
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.newOrder = functions.firestore.document("/Order/{id}")
    .onCreate((snap, context)=> {
      console.log(snap.data());
      const ordeID = context.params.id;
      console.log(ordeID);
    });

exports.newUser = functions.firestore.document("SellerData/{id}")
    .onCreate(()=>{
      const messaging = admin.messaging();
      const payload = {
        notification: {
          title: "This is a Notification",
          body: "This is the body of the notification message.",
        },
        topic: "topic",
      };


      messaging.send(payload)
          .then((result) => {
            console.log(result);
          });
    });

exports.scheduledFunction = functions.pubsub.schedule("every 60 minutes")
    .onRun((context) => {
      console.log("This will be run every 60 minutes!");
      return null;
    });
