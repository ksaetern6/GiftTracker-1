import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

//final AuthGoogle authorize = AuthGoogle();

class AuthGoogle {
  final GoogleSignIn _gSignIn = GoogleSignIn();
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final Firestore _fireDB = Firestore.instance;

  //these 3 streams define our state that our widgets listen to them to update
  //the UI
  Observable<FirebaseUser> user; //firebase user
  Observable<Map<String, dynamic>> profile; // custom user data we will save in Fstore
  PublishSubject loading = PublishSubject(); //observable we can push no values in

  //constructor
  AuthGoogle() {
    //state initialized

    //get current user by setting an observable on the Auth object
    user = Observable(_fAuth.onAuthStateChanged);

    //to get user value from firestore we need to get their user id
    //switchMap lets us listen to the value of the user observable and
    //lets us switch to a different observable
    //this instance we are switching to a different user observable
    profile = user.switchMap((FirebaseUser fUser) {
      if (fUser != null) {
        return _fireDB
            .collection('users')
            .document(fUser.uid)
            .snapshots()
            .map((snap) => snap.data); //maps snapshot to their data payload
      }
      //if user isn't signed in we are not going to have a user id
      //so we return an observable with an empty object
      else {
        return Observable.just({ });
      }
    });
  }//AuthGoogle constructor

  Future<FirebaseUser> googleSignIn() async {
    //as soon as the user clicks on the user sign in button we are going to
    //flip the loading state to true
    loading.add(true);

    //signing in user
    //call google sign in method to trigger sign in process
    //returns user's id token and auth token
    GoogleSignInAccount googleUser = await _gSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    //depreciated signInWithGoogle
    //We are logged into Google but not Firebase, so pass tokens into
    //Firebase to login.

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    FirebaseUser user = await _fAuth.signInWithCredential(credential);

    /*
    FirebaseUser user = await _fAuth.signInWithGoogle(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    */
    print("singed in" + user.displayName);




    //update user data in Firestore
    updateUserData(user);
    //flip loading state to false
    loading.add(false);

    return user;
  }//googleSignIn

  void updateUserData(FirebaseUser user) async {
    //reference to same firestore document (from passed in user)

    DocumentReference ref = _fireDB.collection('users').document(user.uid);

    //custom data we are putting into firebase
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true); //merge true doesn't overwrite existing user data

  }//updateUserData

  void signOut() {
    //signs out user
    _fAuth.signOut();
  }
}
