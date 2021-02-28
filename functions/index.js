/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

// const db = admin.firestore();
const fcm = admin.messaging();

exports.orderCreate = functions.firestore
  .document('Order/{id}')
  .onCreate(async (snap, context) => {
    const newValue = snap.data();

    const sellerToken = await admin
      .firestore()
      .collection('SellerData')
      .doc(newValue.Seller)
      .get();

    const payload = {
      notification: {
        title: `${newValue.CustomerName} has sent a new order`,
        body: 'Check out your recent order',
      },
    };
    fcm.sendToCondition(sellerToken.data().FCM, payload);
  });

  exports.orderUpdate = functions.firestore
    .document('Order/{id}')
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
  
      const sellerToken = await admin
        .firestore()
        .collection('SellerData')
        .doc(newValue.Seller)
        .get();
  
      const customerToken = await admin
        .firestore()
        .collection('BuyerData')
        .doc(newValue.Customer)
        .get();
  
      const payload = {
        notification: {
          title: `Order ID - ${context.params.id} has an update`,
          body: 'Check out the update on your recent order',
        },
      };
  
      if (newValue.status === 'waiting') {
        fcm.sendToDevice(customerToken.data().FCM, payload);
      }
      if (newValue.status === 'to pack') {
        fcm.sendToDevice(sellerToken.data().FCM, payload);
      }
    });

    exports.requestUpdate = functions.firestore
    .document('Request/{id}/SellerName/{responseID}')
    .onCreate(async (snap, context) => {
      const request = await admin
        .firestore()
        .collection('Request')
        .doc(context.params.id)
        .get(); 
      console.log(context.params.id);
       const buyer = await admin
        .firestore()
        .collection('BuyerData')
        .doc(request.id)
        .get();
  
      const payload = {
        notification: {
          title: 'You have a new response',
          body: `Check out this response from ${snap.data().ShopName}`,
        },
      };
  
      fcm.sendToDevice(buyer.data().FCM, payload); 
    });

    exports.displayDevice = functions.firestore
    .document('SellerData/{id}')
    .onUpdate((change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();
  
      const oldPriority = previousValue.Priority;
      const newPriority = newValue.Priority;
  
      const token = newValue.FCM;
  
      if (oldPriority === false && newPriority === true) {
        const payload = {
          notification: {
            title: 'You have been authorised',
            body: 'You have been authorised as a seller by Khojbuy',
          },
        };
        fcm.sendToDevice(token, payload);
      }
    });


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

