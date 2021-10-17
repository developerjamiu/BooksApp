const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const auth = admin.auth();
const firestore = admin.firestore();

exports.deleteUserAccount = functions.https.onCall(async (data, context) => {
  try {
    await firestore.collection("users").doc(context.auth.uid).delete();
    
    await auth.deleteUser(context.auth.uid);

    return 'User was successfully deleted';
  } catch (error) {
    throw 'Error deleting User';
  }
});