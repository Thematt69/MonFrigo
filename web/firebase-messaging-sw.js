importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyDu2cvpD7_ht9FApb_t7HTmE_rVQK7QkK8",
  appId: "1:581070356908:web:a92bd1d491fc5a04d4ba09",
  messagingSenderId: "581070356908",
  projectId: "monfrigo-1b428",
  authDomain: "monfrigo-1b428.firebaseapp.com",
  storageBucket: "monfrigo-1b428.appspot.com",
});

const messaging = firebase.messaging();
