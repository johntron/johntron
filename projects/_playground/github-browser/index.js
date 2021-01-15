const express = require('express');
const passport = require('passport');
const bodyParser = require('body-parser');
const GitHubStrategy = require('passport-github2').Strategy;
const partials = require('express-partials');
const pkg = require('./package.json');

const [ GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET ] = process.env.GITHUB_CLIENT.split(':')
const PORT = process.env.PORT || 8080
const HOSTNAME = process.env.HOSTNAME || 'oauth.johntron.com'

passport.serializeUser(function(user, done) {
  done(null, user);
});

passport.deserializeUser(function(obj, done) {
  done(null, obj);
});

passport.use(new GitHubStrategy({
    clientID: GITHUB_CLIENT_ID,
    clientSecret: GITHUB_CLIENT_SECRET,
    callbackURL: `https://${HOSTNAME}/auth/github/callback`
  },
  function(accessToken, refreshToken, profile, done) {
    process.nextTick(function () {
      return done(null, profile);
    });
  }
));

const app = express();
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(partials());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(passport.initialize());
app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res){
  res.render('index', { user: req.user });
});

app.get('/login', function(req, res){
  res.render('login', { user: req.user });
});

app.get('/auth/github',
  passport.authenticate('github', { scope: [ 'user:email' ] }),
  function(req, res){});

app.get('/auth/github/callback', 
  passport.authenticate('github', { failureRedirect: '/login' }),
  function(req, res) {
    const token = req.query.code
    res.json({ token })
  });

app.get('/logout', function(req, res){
  req.logout();
  res.redirect('/');
});

app.listen(PORT, () => {
  console.log(`Started ${pkg.name} on port ${PORT}`)
});

