import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useEffect } from "react";
import { Router, Routes, Route, Link, Navigate, useNavigate, jacLogin, jacSignup, jacLogout, jacIsLoggedIn } from "@jac-client/utils";
function HomePage() {
  if (jacIsLoggedIn()) {
    return __jacJsx(Navigate, {"to": "/dashboard"}, []);
  }
  return __jacJsx(Navigate, {"to": "/login"}, []);
}
function LoginPage() {
  let [username, setUsername] = useState("");
  let [password, setPassword] = useState("");
  let [error, setError] = useState("");
  if (jacIsLoggedIn()) {
    return __jacJsx("div", {"style": {"padding": "20px"}}, [__jacJsx("h2", {}, ["You're already logged in"]), __jacJsx("button", {"onClick": () => {
      jacLogout();
    }}, ["Logout"])]);
  }
  async function handleLogin(e) {
    e.preventDefault();
    setError("");
    if (!username || !password) {
      setError("Please fill in all fields");
      return;
    }
    let success = await jacLogin(username, password);
    if (success) {
      window.location.href = "/page/app#/dashboard";
    } else {
      setError("Invalid credentials");
    }
  }
  function handleUsernameChange(e) {
    setUsername(e.target.value);
  }
  function handlePasswordChange(e) {
    setPassword(e.target.value);
  }
  let errorDisplay = null;
  if (error) {
    errorDisplay = __jacJsx("div", {"style": {"color": "#dc2626", "fontSize": "14px", "marginBottom": "10px"}}, [error]);
  }
  return __jacJsx("div", {"style": {"minHeight": "100vh", "display": "flex", "alignItems": "center", "justifyContent": "center", "background": "#f5f5f5"}}, [__jacJsx("div", {"style": {"background": "#ffffff", "padding": "30px", "borderRadius": "8px", "width": "280px", "boxShadow": "0 2px 4px rgba(0,0,0,0.1)"}}, [__jacJsx("h2", {"style": {"marginBottom": "20px"}}, ["Login"]), __jacJsx("form", {"onSubmit": handleLogin}, [__jacJsx("input", {"type": "text", "value": username, "onChange": handleUsernameChange, "placeholder": "Username", "style": {"width": "100%", "padding": "8px", "marginBottom": "10px", "border": "1px solid #ddd", "borderRadius": "4px", "boxSizing": "border-box"}}, []), __jacJsx("input", {"type": "password", "value": password, "onChange": handlePasswordChange, "placeholder": "Password", "style": {"width": "100%", "padding": "8px", "marginBottom": "10px", "border": "1px solid #ddd", "borderRadius": "4px", "boxSizing": "border-box"}}, []), errorDisplay, __jacJsx("button", {"type": "submit", "style": {"width": "100%", "padding": "8px", "background": "#3b82f6", "color": "#ffffff", "border": "none", "borderRadius": "4px", "cursor": "pointer", "fontWeight": "600"}}, ["Login"])]), __jacJsx("p", {"style": {"textAlign": "center", "marginTop": "12px", "fontSize": "14px"}}, ["Need an account? ", __jacJsx(Link, {"to": "/signup"}, ["Sign up"])])])]);
}
function SignupPage() {
  let [username, setUsername] = useState("");
  let [password, setPassword] = useState("");
  let [error, setError] = useState("");
  async function handleSignup(e) {
    e.preventDefault();
    setError("");
    if (!username || !password) {
      setError("Please fill in all fields");
      return;
    }
    let result = await jacSignup(username, password);
    if (result["success"]) {
      window.location.href = "/page/app#/dashboard";
    } else {
      setError(result["error"] ? result["error"] : "Signup failed");
    }
  }
  function handleUsernameChange(e) {
    setUsername(e.target.value);
  }
  function handlePasswordChange(e) {
    setPassword(e.target.value);
  }
  let errorDisplay = null;
  if (error) {
    errorDisplay = __jacJsx("div", {"style": {"color": "#dc2626", "fontSize": "14px", "marginBottom": "10px"}}, [error]);
  }
  return __jacJsx("div", {"style": {"minHeight": "100vh", "display": "flex", "alignItems": "center", "justifyContent": "center", "background": "#f5f5f5"}}, [__jacJsx("div", {"style": {"background": "#ffffff", "padding": "30px", "borderRadius": "8px", "width": "280px", "boxShadow": "0 2px 4px rgba(0,0,0,0.1)"}}, [__jacJsx("h2", {"style": {"marginBottom": "20px"}}, ["Sign Up"]), __jacJsx("form", {"onSubmit": handleSignup}, [__jacJsx("input", {"type": "text", "value": username, "onChange": handleUsernameChange, "placeholder": "Username", "style": {"width": "100%", "padding": "8px", "marginBottom": "10px", "border": "1px solid #ddd", "borderRadius": "4px", "boxSizing": "border-box"}}, []), __jacJsx("input", {"type": "password", "value": password, "onChange": handlePasswordChange, "placeholder": "Password", "style": {"width": "100%", "padding": "8px", "marginBottom": "10px", "border": "1px solid #ddd", "borderRadius": "4px", "boxSizing": "border-box"}}, []), errorDisplay, __jacJsx("button", {"type": "submit", "style": {"width": "100%", "padding": "8px", "background": "#3b82f6", "color": "#ffffff", "border": "none", "borderRadius": "4px", "cursor": "pointer", "fontWeight": "600"}}, ["Sign Up"])]), __jacJsx("p", {"style": {"textAlign": "center", "marginTop": "12px", "fontSize": "14px"}}, ["Have an account? ", __jacJsx(Link, {"to": "/login"}, ["Login"])])])]);
}
function NotFoundPage() {
  return __jacJsx("div", {"style": {"textAlign": "center", "padding": "50px"}}, [__jacJsx("h1", {}, ["404 - Page Not Found"]), __jacJsx(Link, {"to": "/"}, ["Go Home"])]);
}
function Navbar() {
  let isLoggedIn = jacIsLoggedIn();
  if (isLoggedIn) {
    return __jacJsx("nav", {"style": {"padding": "12px 24px", "background": "#3b82f6", "color": "#ffffff", "display": "flex", "justifyContent": "space-between"}}, [__jacJsx("div", {"style": {"fontWeight": "600"}}, ["Smart Career Path Navigator"]), __jacJsx("div", {"style": {"display": "flex", "gap": "16px"}}, [__jacJsx(Link, {"to": "/dashboard", "style": {"color": "#ffffff", "textDecoration": "none"}}, ["Dashboard"]), __jacJsx("button", {"onClick": e => {
      e.preventDefault();
      jacLogout();
      window.location.href = "/page/app#/login";
    }, "style": {"background": "none", "color": "#ffffff", "border": "1px solid #ffffff", "padding": "2px 10px", "borderRadius": "4px", "cursor": "pointer"}}, ["Logout"])])]);
  }
  return __jacJsx("nav", {"style": {"padding": "12px 24px", "background": "#3b82f6", "color": "#ffffff", "display": "flex", "justifyContent": "space-between"}}, [__jacJsx("div", {"style": {"fontWeight": "600"}}, ["Todo App"]), __jacJsx("div", {"style": {"display": "flex", "gap": "16px"}}, [__jacJsx(Link, {"to": "/login", "style": {"color": "#ffffff", "textDecoration": "none"}}, ["Login"]), __jacJsx(Link, {"to": "/signup", "style": {"color": "#ffffff", "textDecoration": "none"}}, ["Sign Up"])])]);
}
function DashboardPage() {
  return __jacJsx("div", {}, [__jacJsx("h1", {}, ["⚠️ Dashboard page in progress"])]);
}
function app() {
  return __jacJsx(Router, {}, [__jacJsx(Navbar, {}, []), __jacJsx(Routes, {}, [__jacJsx(Route, {"path": "/", "element": __jacJsx(HomePage, {}, [])}, []), __jacJsx(Route, {"path": "/login", "element": __jacJsx(LoginPage, {}, [])}, []), __jacJsx(Route, {"path": "/signup", "element": __jacJsx(SignupPage, {}, [])}, []), __jacJsx(Route, {"path": "/dashboard", "element": __jacJsx(DashboardPage, {}, [])}, []), __jacJsx(Route, {"path": "*", "element": __jacJsx(NotFoundPage, {}, [])}, [])])]);
}
export { DashboardPage, HomePage, LoginPage, Navbar, NotFoundPage, SignupPage, app };
