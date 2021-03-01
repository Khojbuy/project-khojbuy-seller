/* eslint-disable */
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// const db = admin.firestore();
const fcm = admin.messaging();
var options = {
  priority: 'high',
  timeToLive: 60 * 60 * 24
};

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
    fcm.send()
    fcm.sendToCondition(sellerToken.data().FCM, payload, options)
      .then(function (response) {
      console.log('Successfully sent message:', response);
    })
    .catch(function(error) {
      console.log('Error sending message:', error);
    });
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
        fcm.sendToDevice(customerToken.data().FCM, payload, options)
          .then(function (response) {
          console.log('Successfully sent message:', response);
        })
        .catch(function(error) {
          console.log('Error sending message:', error);
        });
      }
      if (newValue.status === 'to pack') {
        fcm.sendToDevice(sellerToken.data().FCM, payload, options)
          .then(function (response) {
          console.log('Successfully sent message:', response);
        })
        .catch(function(error) {
          console.log('Error sending message:', error);
        });
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
  
      fcm.sendToDevice(buyer.data().FCM, payload, options)
        .then(function (response) {
        console.log('Successfully sent message:', response);
      })
      .catch(function(error) {
        console.log('Error sending message:', error);
      }); 
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
        fcm.sendToDevice(token, payload, options)
          .then(function (response) {
          console.log('Successfully sent message:', response);
        })
        .catch(function(error) {
          console.log('Error sending message:', error);
        });
      }
    });


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

