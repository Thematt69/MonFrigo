importScripts("https://www.gstatic.com/firebasejs/10.3.1/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/10.3.1/firebase-messaging.js"
);

const firebaseConfig = {
  apiKey: "AIzaSyDu2cvpD7_ht9FApb_t7HTmE_rVQK7QkK8",
  authDomain: "monfrigo-1b428.firebaseapp.com",
  projectId: "monfrigo-1b428",
  storageBucket: "monfrigo-1b428.appspot.com",
  messagingSenderId: "581070356908",
  appId: "1:581070356908:web:a92bd1d491fc5a04d4ba09",
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();
