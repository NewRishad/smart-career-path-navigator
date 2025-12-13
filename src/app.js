import {__jacJsx, __jacSpawn} from "@jac-client/utils";
import { useState, useEffect } from "react";
import { Router, Routes, Route, Link, Navigate, useNavigate, jacLogin, jacSignup, jacLogout, jacIsLoggedIn } from "@jac-client/utils";
import "./global.css";
function HomePage() {
  if (jacIsLoggedIn()) {
    return __jacJsx(Navigate, {"to": "/dashboard"}, []);
  }
  return __jacJsx(Navigate, {"to": "/login"}, []);
}
function LoginPage(props) {
  let [username, setUsername] = useState("");
  let [password, setPassword] = useState("");
  let [error, setError] = useState("");
  if (jacIsLoggedIn()) {
    return __jacJsx("div", {"class": "p-5"}, [__jacJsx("h2", {"class": "text-xl font-bold"}, ["You're already logged in"]), __jacJsx("button", {"onClick": () => {
      jacLogout();
      props.setIsLoggedIn(false);
    }, "class": "mt-4 px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition"}, ["Logout"])]);
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
      props.setIsLoggedIn(true);
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
    errorDisplay = __jacJsx("div", {"class": "text-sm font-medium text-red-600 mt-2"}, [error]);
  }
  return __jacJsx("div", {"class": "flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8 bg-white"}, [__jacJsx("div", {"class": "sm:mx-auto sm:w-full sm:max-w-sm"}, [__jacJsx("img", {"src": "/static/assets/icon.svg", "alt": "Your Company", "class": "mx-auto h-10 w-auto"}, []), __jacJsx("h2", {"class": "mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900"}, ["Sign in to your account"])]), __jacJsx("div", {"class": "mt-10 sm:mx-auto sm:w-full sm:max-w-sm"}, [__jacJsx("form", {"onSubmit": handleLogin, "class": "space-y-6"}, [__jacJsx("div", {}, [__jacJsx("label", {"for": "username", "class": "block text-sm/6 font-medium text-gray-900"}, ["Username"]), __jacJsx("div", {"class": "mt-2"}, [__jacJsx("input", {"id": "username", "type": "text", "value": username, "onChange": handleUsernameChange, "required": true, "class": "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"}, [])])]), __jacJsx("div", {}, [__jacJsx("div", {"class": "flex items-center justify-between"}, [__jacJsx("label", {"for": "password", "class": "block text-sm/6 font-medium text-gray-900"}, ["Password"]), __jacJsx("div", {"class": "text-sm"}, [__jacJsx("p", {"href": "#", "class": "font-semibold text-indigo-600 hover:text-indigo-500"}, ["Forgot password?"])])]), __jacJsx("div", {"class": "mt-2"}, [__jacJsx("input", {"id": "password", "type": "password", "value": password, "onChange": handlePasswordChange, "required": true, "class": "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"}, [])])]), errorDisplay, __jacJsx("div", {}, [__jacJsx("button", {"type": "submit", "class": "flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"}, ["Sign in"])])]), __jacJsx("p", {"class": "mt-10 text-center text-sm/6 text-gray-500"}, ["Not a member?", __jacJsx(Link, {"to": "/signup", "class": "font-semibold text-indigo-600 hover:text-indigo-500"}, [" Click here to Register"])])])]);
}
function SignupPage(props) {
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
      props.setIsLoggedIn(true);
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
    errorDisplay = __jacJsx("div", {"class": "text-sm font-medium text-red-600 mt-2"}, [error]);
  }
  return __jacJsx("div", {"class": "flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8 bg-white"}, [__jacJsx("div", {"class": "sm:mx-auto sm:w-full sm:max-w-sm"}, [__jacJsx("img", {"src": "/static/assets/icon.svg", "alt": "Your Company", "class": "mx-auto h-10 w-auto"}, []), __jacJsx("h2", {"class": "mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900"}, ["Create your account"])]), __jacJsx("div", {"class": "mt-10 sm:mx-auto sm:w-full sm:max-w-sm"}, [__jacJsx("form", {"onSubmit": handleSignup, "class": "space-y-6"}, [__jacJsx("div", {}, [__jacJsx("label", {"for": "username", "class": "block text-sm/6 font-medium text-gray-900"}, ["Username"]), __jacJsx("div", {"class": "mt-2"}, [__jacJsx("input", {"id": "username", "type": "text", "value": username, "onChange": handleUsernameChange, "required": true, "class": "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"}, [])])]), __jacJsx("div", {}, [__jacJsx("label", {"for": "password", "class": "block text-sm/6 font-medium text-gray-900"}, ["Password"]), __jacJsx("div", {"class": "mt-2"}, [__jacJsx("input", {"id": "password", "type": "password", "value": password, "onChange": handlePasswordChange, "required": true, "class": "block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"}, [])])]), errorDisplay, __jacJsx("div", {}, [__jacJsx("button", {"type": "submit", "class": "flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"}, ["Sign Up"])])]), __jacJsx("p", {"class": "mt-10 text-center text-sm/6 text-gray-500"}, ["Already have an account? ", __jacJsx(Link, {"to": "/login", "class": "font-semibold text-indigo-600 hover:text-indigo-500"}, ["Login"])])])]);
}
function NotFoundPage() {
  return __jacJsx("div", {"class": "flex min-h-screen flex-col items-center justify-center p-12 text-center"}, [__jacJsx("h1", {"class": "text-4xl font-bold mb-4"}, ["404 - Page Not Found"]), __jacJsx(Link, {"to": "/", "class": "text-indigo-600 font-semibold hover:text-indigo-500"}, ["Go Home"])]);
}
function Navbar(props) {
  let isLoggedIn = jacIsLoggedIn();
  if (isLoggedIn) {
    return __jacJsx("nav", {"class": "bg-white shadow-md border-b border-gray-100 px-6 py-3 flex justify-between items-center"}, [__jacJsx("div", {"class": "text-indigo-600 font-bold text-lg tracking-tight"}, ["Loreim Ipsum"]), __jacJsx("div", {"class": "flex gap-4 items-center text-sm font-medium"}, [__jacJsx(Link, {"to": "/dashboard", "class": "text-gray-700 hover:text-indigo-600 transition-colors"}, ["Dashboard"]), __jacJsx("button", {"onClick": e => {
      e.preventDefault();
      jacLogout();
      props.setIsLoggedIn(false);
      window.location.href = "/page/app#/login";
    }, "class": "bg-indigo-600 text-white px-3 py-1 rounded-md cursor-pointer font-semibold hover:bg-indigo-700 transition-colors shadow-sm"}, ["Logout"])])]);
  }
  return __jacJsx("nav", {"class": "bg-white shadow-md border-b border-gray-100 px-6 py-3 flex justify-between items-center"}, [__jacJsx("div", {"class": "text-gray-900 font-bold text-lg tracking-tight"}, ["Loreim Ipsum"]), __jacJsx("div", {"class": "flex gap-4 items-center text-sm font-medium"}, [__jacJsx(Link, {"to": "/login", "class": "text-indigo-600 hover:text-indigo-500 transition-colors"}, ["Login"]), __jacJsx(Link, {"to": "/signup", "class": "bg-indigo-600 text-white px-3 py-1 rounded-md cursor-pointer font-semibold hover:bg-indigo-700 transition-colors shadow-sm"}, ["Sign Up"])])]);
}
function DashboardPage() {
  return __jacJsx("div", {"class": "flex flex-col items-center gap-6 p-7 md:flex-row rounded-2xl"}, [__jacJsx("div", {}, [__jacJsx("img", {"class": "size-48 shadow-xl rounded-md", "alt": "", "src": "/static/assets/cover.png"}, [])]), __jacJsx("div", {"class": "flex items-center"}, [__jacJsx("span", {"class": "text-2xl font-medium"}, ["Class Warfare"]), __jacJsx("span", {"class": "font-medium text-sky-500"}, ["The Anti-Patterns"]), __jacJsx("span", {"class": "flex gap-2 font-medium text-gray-600 dark:text-gray-400"}, [__jacJsx("span", {}, ["No. 4"]), __jacJsx("span", {}, ["·"]), __jacJsx("span", {}, ["2025"])])])]);
}
function app() {
  let [isLoggedIn, setIsLoggedIn] = useState(jacIsLoggedIn());
  return __jacJsx(Router, {}, [__jacJsx(Navbar, {"isLoggedIn": isLoggedIn, "setIsLoggedIn": setIsLoggedIn}, []), __jacJsx(Routes, {}, [__jacJsx(Route, {"path": "/", "element": __jacJsx(HomePage, {}, [])}, []), __jacJsx(Route, {"path": "/login", "element": __jacJsx(LoginPage, {"isLoggedIn": isLoggedIn, "setIsLoggedIn": setIsLoggedIn}, [])}, []), __jacJsx(Route, {"path": "/signup", "element": __jacJsx(SignupPage, {"isLoggedIn": isLoggedIn, "setIsLoggedIn": setIsLoggedIn}, [])}, []), __jacJsx(Route, {"path": "/dashboard", "element": __jacJsx(DashboardPage, {}, [])}, []), __jacJsx(Route, {"path": "*", "element": __jacJsx(NotFoundPage, {}, [])}, [])])]);
}
export { DashboardPage, HomePage, LoginPage, Navbar, NotFoundPage, SignupPage, app };
