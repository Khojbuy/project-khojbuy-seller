const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

// const db = admin.firestore();
const fcm = admin.messaging();

exports.orderCreate = functions.firestore
    .document("Order/{id}")
    .onCreate((snap, context) => {
      const newValue = snap.data();
      const sellerToken = admin.firestore().collection("SellerData")
          .doc(newValue.Seller)
          .get();
      const payload = {
        notifications: {
          title: `${newValue.CustomerName} has sent a new order`,
          body: "Check out your recent order",
        },
      };
      fcm.sendToCondition(sellerToken.FCM, payload);
    });

exports.orderUpdate = functions.firestore
    .document("Order/{id}")
    .onUpdate( (change, context) => {
      const newValue = change.after.data();

      const sellerToken = admin.firestore().collection("SellerData")
          .doc(newValue.Seller)
          .get();
      const customerToken = admin.firestore().collection("BuyerData")
          .doc(newValue.Customer)
          .get();

      const payload = {
        notifications: {
          title: `Order ID - ${context.params.id} has an update`,
          body: "Check out the update on your recent order",
        },

      };

      if (newValue.status == "waiting") {
        fcm.sendToDevice(customerToken, payload);
      }
      if (newValue.status == "to pack") {
        fcm.sendToDevice(sellerToken, payload);
      }
    }
    );

exports.requestChange = functions.firestore
    .document("Request/{id}/SellerResponses")
    .onCreate((snap, context) => {
      const sellerId = admin.firestore().collection("Request")
          .doc(context.params.id).get().data().id;
      const seller = admin.firestore().collection("BuyerData")
          .doc(sellerId).get().data().FCM;
      const payload = {
        notifications: {
          title: "You have a new response",
          body: `Check out this response from ${snap.data().ShopName}`,
        },
      };
      fcm.sendToDevice(seller, payload);
    }
    );

exports.displayDevice = functions.firestore
    .document("SellerData/{id}")
    .onUpdate((change, context)=>{
      const newValue = change.after.data();
      const previousValue = change.before.data();
      const oldPriority = previousValue.Priority;
      const newPriority = newValue.Priority;
      const token = newValue.FCM;
      if (oldPriority == false && newPriority == true) {
        const payload = {
          notifications: {
            title: "You have been authorised",
            body: "You have been authorised as a seller by Khojbuy",
          },
        };
        fcm.sendToDevice(
            token,
            payload
        );
      }
    });


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

