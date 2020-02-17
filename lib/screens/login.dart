import 'package:crossroads_events/services/auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Login extends StatefulWidget {
  final AuthService authService;

  const Login(this.authService);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  bool _obscureTextSignupConfirm = true;

  @override
  void initState() {
    widget.authService.getUser.then(
      (user) {
        if (user != null && user.isEmailVerified) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );

    super.initState();
  }

  void showSnackBar(String val, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: Duration(seconds: 3),
        content: Text(
          val,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        )));
  }

  void _togglePassword() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
//          gradient: LinearGradient(
//            colors: [
//              Theme.of(context).colorScheme.secondary,
//              Theme.of(context).colorScheme.primary
//
//            ],
//            begin: Alignment.topLeft,
//            end: Alignment.bottomRight,
//          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: FormBuilder(
                  key: _fbKey,
                  autovalidate: false,
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                          aspectRatio: 1.6,
                          child: FlareActor(
                            'assets/animations/dance.flr',
                            alignment: Alignment.center,
                            animation: 'dance',
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FormBuilderTextField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              style: Theme.of(context).textTheme.button,
                              cursorColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              attribute: 'email',
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(25.0)),
                                labelText: 'Email',
                                labelStyle: Theme.of(context).textTheme.button,
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.at,
                                  size: 22.0,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                errorStyle: Theme.of(context).textTheme.caption,
                              ),
                              validators: [
                                FormBuilderValidators.required(
                                    errorText: 'Champs requis'),
                                FormBuilderValidators.email(
                                    errorText:
                                        'Veuillez saisir un Email valide'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            FormBuilderTextField(
                              controller: _password,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              cursorColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              attribute: 'mot de passe',
                              obscureText: _obscureTextSignupConfirm,
                              maxLines: 1,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(25.0)),
                                labelText: 'Mot de passe',
                                labelStyle: Theme.of(context).textTheme.button,
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.key,
                                  size: 22.0,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: _togglePassword,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  iconSize: 20,
                                  icon: Icon(FontAwesomeIcons.eye),
                                ),
                                errorStyle: Theme.of(context).textTheme.caption,
                              ),
                              validators: [
                                /*Strong passwords with min 8 - max 15 character length, at least one uppercase letter, one lowercase letter, one number, one special character (all, not just defined), space is not allowed.*/

                                (val) {
                                  RegExp regex = new RegExp(
                                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d.*)[a-zA-Z0-9\S]{8,15}$');
                                  if (regex.allMatches(val).length == 0) {
                                    return 'Entre 8 et 15, 1 majuscule, 1 minuscule, 1 chiffre';
                                  }
                                }
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              child: Text(
                                'Se connecter',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                              onPressed: () {
                                if (_fbKey.currentState.validate()) {
                                  widget.authService
                                      .signIn(_email.text, _password.text)
                                      .then((user) {
                                    if (user != null) {
                                      if (user.isEmailVerified) {
                                        Navigator.pushReplacementNamed(
                                            context, '/home');
                                      } else {
                                        widget.authService.showSnackBar(
                                            "l'email n'est pas vérifié", context);
                                      }
                                    } else {
                                      widget.authService.showSnackBar(
                                          "il faut s'enregistrer", context);
                                    }
                                  }).catchError((e) {
                                    print(e);
                                    widget.authService.showSnackBar(
                                        "utilisateur inconnu", context);
                                  });
                                } else {
                                  widget.authService.showSnackBar(
                                      "le formulaire est invalide", context);
                                }
                              },
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 4,
                                    child: Divider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      thickness: 1,
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'ou',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.button,
                                    )),
                                Expanded(
                                    flex: 4,
                                    child: Divider(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      thickness: 1,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FloatingActionButton(
                                  onPressed: () {
                                    print('facebook');
                                  },
                                  backgroundColor: Colors.blue.shade800,
                                  child: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                  ),
                                  heroTag: null,
                                ),
                                FloatingActionButton(
                                    onPressed: () {
                                      widget.authService.googleSignIn().then((user){
                                        Navigator.pushReplacementNamed(context, 'home');
                                      });
                                    },
                                    backgroundColor: Colors.red.shade700,
                                    child: Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                    heroTag: null),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),

                            FlatButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/signUp',
                                  arguments: widget.authService),
                              child: Text(
                                'Pas de compte? S\'inscrire maintenant',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FlatButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/resetpsw',
                                  arguments: widget.authService),
                              child: Text(
                                'Mot de passe oublier?',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
//                      ProviderButton(
//                        text: 'AVEC GOOGLE',
//                        icon: FontAwesomeIcons.google,
//                        color: Colors.black45,
//                        loginMethod: auth.googleSignIn,
//                      ),
//                      ProviderButton(
//                        text: 'AVEC FACEBOOK',
//                        icon: FontAwesomeIcons.facebook,
//                        color: Colors.black45,
//                        loginMethod: auth.faceBookSignIn,
//                      ),
//                      ProviderButton(
//                          text: 'Continuer en tant qu\'invité' , loginMethod: auth.anonLogin),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
