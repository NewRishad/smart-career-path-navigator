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
  return __jacJsx("div", {"class": "flex min-h-screen flex-col items-center justify-center p-12 text-center"}, [__jacJsx("h1", {"class": "text-4xl font-bold mb-4"}, ["404 - Page Not Found"]), __jacJsx(Link, {"to": "/dashboard", "class": "text-indigo-600 font-semibold hover:text-indigo-500"}, ["Go Home"])]);
}
function Navbar(props) {
  let isLoggedIn = props.isLoggedIn;
  let navigate = useNavigate();
  if (!isLoggedIn) {}
  let [path, setPath] = useState(window.location.hash);
  function isActive(path) {
    if (window.location.href.includes(path)) {
      return "text-indigo-600 border-b-2 border-indigo-600";
    } else {
      return "text-gray-600 hover:text-indigo-600 transition-colors";
    }
  }
  function handleLogout() {
    props.setIsLoggedIn(false);
    jacLogout();
    navigate("/login");
  }
  return __jacJsx("nav", {"class": "bg-white shadow-lg"}, [__jacJsx("div", {"class": "max-w-7xl mx-auto px-4"}, [__jacJsx("div", {"class": "flex justify-between items-center h-16"}, [__jacJsx("div", {"class": "flex items-center space-x-8"}, [__jacJsx(Link, {"to": "/dashboard", "class": "text-2xl font-bold text-blue-600"}, ["KaziPath"]), __jacJsx("div", {"class": "hidden md:flex space-x-6"}, [__jacJsx(Link, {"to": "/dashboard", "class": "px-2 py-1 " + isActive("/dashboard"), "onClick": () => {
    setPath("/dashboard");
  }}, ["Dashboard"]), __jacJsx(Link, {"to": "/assessment", "class": "px-2 py-1 " + isActive("/assessment"), "onClick": () => {
    setPath("/assessment");
  }}, ["Assessment"]), __jacJsx(Link, {"to": "/courses", "class": "px-2 py-1 " + isActive("/courses"), "onClick": () => {
    setPath("/courses");
  }}, ["Courses"]), __jacJsx(Link, {"to": "/jobs", "class": "px-2 py-1 " + isActive("/jobs"), "onClick": () => {
    setPath("/jobs");
  }}, ["Jobs"]), __jacJsx(Link, {"to": "/chat", "class": "px-2 py-1 " + isActive("/chat"), "onClick": () => {
    setPath("/chat");
  }}, ["AI Assistant"])])]), __jacJsx("div", {"class": "flex items-center space-x-4"}, [__jacJsx("div", {"class": "flex items-center space-x-2"}, [__jacJsx("span", {"class": "text-yellow-500"}, ["⭐"]), __jacJsx("span", {"class": "text-sm font-medium"}, ["0 points"])]), __jacJsx(Link, {"to": "/profile", "class": "text-gray-600 hover:text-blue-600"}, ["👤 Rishad"]), __jacJsx("button", {"class": "bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600", "onclick": handleLogout}, ["Logout"])]), " "])])]);
}
function DashboardPage() {
  return __jacJsx("div", {"class": "max-w-7xl mx-auto px-4 py-6"}, [__jacJsx("div", {"class": "bg-gradient-to-r from-blue-600 to-purple-600 rounded-lg p-6 text-white mb-6"}, [__jacJsx("h1", {"class": "text-3xl font-bold mb-2"}, ["Welcome back!"]), __jacJsx("p", {"class": "text-blue-100"}, ["Ready to continue your learning journey? Let's achieve your career goals together!"])]), __jacJsx("div", {"class": "grid grid-cols-1 md:grid-cols-4 gap-6 mb-6"}, [__jacJsx("div", {"class": "bg-white p-6 rounded-lg shadow"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("div", {"class": "p-2 bg-green-100 rounded-lg"}, [__jacJsx("span", {"class": "text-2xl"}, ["📚"])]), __jacJsx("div", {"class": "ml-4"}, [__jacJsx("p", {"class": "text-sm text-gray-600"}, ["Completed Courses"]), __jacJsx("p", {"class": "text-2xl font-bold text-green-600"}, ["3"])])])]), __jacJsx("div", {"class": "bg-white p-6 rounded-lg shadow"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("div", {"class": "p-2 bg-yellow-100 rounded-lg"}, [__jacJsx("span", {"class": "text-2xl"}, ["⭐"])]), __jacJsx("div", {"class": "ml-4"}, [__jacJsx("p", {"class": "text-sm text-gray-600"}, ["Total Points"]), __jacJsx("p", {"class": "text-2xl font-bold text-yellow-600"}, ["100"])])])]), __jacJsx("div", {"class": "bg-white p-6 rounded-lg shadow"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("div", {"class": "p-2 bg-orange-100 rounded-lg"}, [__jacJsx("span", {"class": "text-2xl"}, ["🔥"])]), __jacJsx("div", {"class": "ml-4"}, [__jacJsx("p", {"class": "text-sm text-gray-600"}, ["Current Streak"]), __jacJsx("p", {"class": "text-2xl font-bold text-orange-600"}, ["7"])])])]), __jacJsx("div", {"class": "bg-white p-6 rounded-lg shadow"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("div", {"class": "p-2 bg-purple-100 rounded-lg"}, [__jacJsx("span", {"class": "text-2xl"}, ["🏆"])]), __jacJsx("div", {"class": "ml-4"}, [__jacJsx("p", {"class": "text-sm text-gray-600"}, ["Leaderboard Rank"]), __jacJsx("p", {"class": "text-2xl font-bold text-purple-600"}, ["1123"])])])])]), __jacJsx("div", {"class": "grid grid-cols-1 lg:grid-cols-3 gap-6"}, [__jacJsx("div", {"class": "bg-white rounded-lg shadow p-6"}, [__jacJsx("h3", {"class": "text-lg font-semibold mb-4"}, ["Quick Actions"]), __jacJsx("div", {"class": "space-y-3"}, [__jacJsx(Link, {"to": "/assessment", "class": "block p-4 bg-blue-50 rounded-lg hover:bg-blue-100 transition-colors"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("span", {"class": "text-2xl mr-3"}, ["📝"]), __jacJsx("div", {}, [__jacJsx("h4", {"class": "font-medium"}, ["Take Assessment"]), __jacJsx("p", {"class": "text-sm text-gray-600"}, ["Discover your learning style"])])])]), __jacJsx(Link, {"to": "/courses", "class": "block p-4 bg-green-50 rounded-lg hover:bg-green-100 transition-colors"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("span", {"class": "text-2xl mr-3"}, ["🎓"]), __jacJsx("div", {}, [__jacJsx("h4", {"class": "font-medium"}, ["Browse Courses"]), __jacJsx("p", {"class": "text-sm text-gray-600"}, ["Find your next course"])])])]), __jacJsx(Link, {"to": "/jobs", "class": "block p-4 bg-purple-50 rounded-lg hover:bg-purple-100 transition-colors"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("span", {"class": "text-2xl mr-3"}, ["💼"]), __jacJsx("div", {}, [__jacJsx("h4", {"class": "font-medium"}, ["Job Matching"]), __jacJsx("p", {"class": "text-sm text-gray-600"}, ["Find perfect opportunities"])])])]), __jacJsx(Link, {"to": "/chat", "class": "block p-4 bg-yellow-50 rounded-lg hover:bg-yellow-100 transition-colors"}, [__jacJsx("div", {"class": "flex items-center"}, [__jacJsx("span", {"class": "text-2xl mr-3"}, ["🤖"]), __jacJsx("div", {}, [__jacJsx("h4", {"class": "font-medium"}, ["AI Assistant"]), __jacJsx("p", {"class": "text-sm text-gray-600"}, ["Get personalized guidance"])])])])])]), __jacJsx("div", {"class": "bg-white rounded-lg shadow p-6"}, [__jacJsx("h3", {"class": "text-lg font-semibold mb-4"}, ["Continue Learning"]), __jacJsx("p", {"class": "text-gray-500 text-center py-8"}, ["No courses started yet. ", __jacJsx(Link, {"to": "/courses", "class": "text-blue-600"}, ["Explore courses"])])]), __jacJsx("div", {"class": "space-y-6"}, [__jacJsx("div", {"class": "bg-white rounded-lg shadow p-6"}, [__jacJsx("h3", {"class": "text-lg font-semibold mb-4"}, ["Job Matches"]), __jacJsx("p", {"class": "text-gray-500 text-center text-sm"}, ["Complete your profile to see job matches"])])])])]);
}
function AssessmentPage() {
  function fetchQuestions() {}
  let answers = [];
  let currentQuestion = 0;
  let results = 1;
  let loading = false;
  let submitting = false;
  function handleAnswer(optionIndex) {}
  function nextQuestion() {}
  function previousQuestion() {}
  function submitAssessment() {}
  if (loading) {
    return __jacJsx("div", {"class": "flex justify-center items-center h-64"}, [__jacJsx("div", {"class": "animate-spin rounded-full h-16 w-16 border-b-2 border-blue-500"}, [])]);
  }
  if (results) {
    return __jacJsx("div", {"class": "max-w-4xl mx-auto px-4 py-8"}, [__jacJsx("div", {"class": "bg-white rounded-lg shadow-lg p-8"}, [__jacJsx("div", {"class": "text-center mb-8"}, [__jacJsx("h2", {"class": "text-3xl font-bold text-gray-900 mb-4"}, ["🎉 Assessment Complete!"]), __jacJsx("p", {"class": "text-lg text-gray-600"}, ["Here are your personalized results and recommendations"])]), __jacJsx("div", {"class": "grid grid-cols-1 md:grid-cols-2 gap-6 mb-8"}, [__jacJsx("div", {"class": "bg-gradient-to-r from-blue-50 to-blue-100 p-6 rounded-lg"}, [__jacJsx("h3", {"class": "text-xl font-semibold mb-2"}, ["Your Learning Style"]), __jacJsx("p", {"class": "text-2xl font-bold text-blue-600 mb-2"}, []), __jacJsx("p", {"class": "text-sm text-gray-600"}, [])]), __jacJsx("div", {"class": "bg-gradient-to-r from-green-50 to-green-100 p-6 rounded-lg"}, [__jacJsx("h3", {"class": "text-xl font-semibold mb-2"}, ["Skill Level"]), __jacJsx("p", {"class": "text-2xl font-bold text-green-600 mb-2"}, []), __jacJsx("p", {"class": "text-sm text-gray-600"}, ["Courses will be tailored to your current level"])])]), __jacJsx("div", {"class": "mb-8"}, [__jacJsx("h3", {"class": "text-2xl font-semibold mb-4"}, ["Recommended Learning Path"]), __jacJsx("div", {"class": "grid grid-cols-1 md:grid-cols-2 gap-4"}, [__jacJsx("div", {"class": "border rounded-lg p-4 hover:shadow-md transition-shadow"}, [__jacJsx("h4", {"class": "font-semibold text-lg mb-2"}, []), __jacJsx("p", {"class": "text-gray-600 text-sm mb-3"}, []), __jacJsx("div", {"class": "flex justify-between items-center text-sm"}, [__jacJsx("span", {"class": "px-2 py-1 bg-blue-100 text-blue-800 rounded"}, []), __jacJsx("span", {"class": "text-gray-500"}, [])]), __jacJsx("div", {"class": "mt-2"}, [__jacJsx("p", {"class": "text-xs text-gray-500"}, ["Skills you'll learn:"]), __jacJsx("div", {"class": "flex flex-wrap gap-1 mt-1"}, [__jacJsx("span", {"class": "text-xs px-2 py-1 bg-gray-100 rounded"}, [])])])])])]), __jacJsx("div", {"class": "text-center space-x-4"}, [__jacJsx("button", {"onClick": () => {
      navigate("/courses");
    }, "class": "bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-medium"}, ["Start Learning"]), __jacJsx("button", {"onClick": () => {
      navigate("/dashboard");
    }, "class": "bg-gray-200 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-300 font-medium"}, ["Return to Dashboard"])])])]);
  }
}
function ChatPage() {
  let messages = [{id: 1, "key": "bot", content: "Hello! I'm your CareerNavigator-AI assistant. I'm here to help you with your learning journey, career guidance, and job search. What can I help you with today?", timestamp: "Wed Dec 17 2025 23:33:15 GMT+0300 (East Africa Time)"}];
  let inputMessage = "";
  let isTyping = true;
  let messagesEndRef = null;
  function scrollToBottom() {}
  function sendMessage() {}
  function handleKeyPress(e) {}
  let quickQuestions = ["What learning path should I follow?", "How can I improve my programming skills?", "What jobs match my current skills?", "Tips for preparing for technical interviews"];
  return __jacJsx("div", {"class": "max-w-4xl mx-auto px-4 py-6"}, [__jacJsx("div", {"class": "bg-white rounded-lg shadow-lg h-[600px] flex flex-col"}, [__jacJsx("div", {"class": "bg-gradient-to-r from-blue-600 to-purple-600 text-white p-4 rounded-t-lg"}, [__jacJsx("h2", {"class": "text-xl font-semibold flex items-center"}, ["🤖 CareerNavigator-AI Assistant"]), __jacJsx("p", {"class": "text-blue-100 text-sm mt-1"}, ["Get personalized guidance for your career development"])]), __jacJsx("div", {"class": "flex-1 overflow-y-auto p-4 space-y-4"}, [__jacJsx("div", {"class": "flex justify-start"}, [__jacJsx("div", {"class": "max-w-xs lg:max-w-md px-4 py-2 rounded-lg bg-gray-100 text-gray-900"}, [__jacJsx("p", {"class": "text-sm whitespace-pre-wrap"}, []), __jacJsx("p", {"class": "text-xs mt-1 text-gray-500"}, [])])]), __jacJsx("div", {"class": "flex justify-start"}, [__jacJsx("div", {"class": "bg-gray-100 text-gray-900 px-4 py-2 rounded-lg"}, [__jacJsx("div", {"class": "flex space-x-1"}, [__jacJsx("div", {"class": "w-2 h-2 bg-gray-400 rounded-full animate-bounce"}, []), __jacJsx("div", {"class": "w-2 h-2 bg-gray-400 rounded-full animate-bounce"}, []), __jacJsx("div", {"class": "w-2 h-2 bg-gray-400 rounded-full animate-bounce"}, [])])])]), __jacJsx("div", {"ref": messagesEndRef}, [])]), __jacJsx("div", {"class": "px-4 py-2 border-t border-gray-200"}, [__jacJsx("p", {"class": "text-sm text-gray-600 mb-2"}, ["Quick questions to get started:"]), __jacJsx("div", {"class": "flex flex-wrap gap-2"}, [__jacJsx("button", {"class": "text-xs px-3 py-1 bg-blue-100 text-blue-700 rounded-full hover:bg-blue-200 transition-colors"}, [])])]), __jacJsx("div", {"class": "p-4 border-t border-gray-200"}, [__jacJsx("div", {"class": "flex space-x-2"}, [__jacJsx("textarea", {"value": inputMessage, "onChange": e => {
    setInput(e.target.value);
  }, "onKeyPress": handleKeyPress, "placeholder": "Ask me anything about your career or learning journey...", "class": "flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none", "rows": "2", "disabled": false}, []), __jacJsx("button", {"onClick": sendMessage, "disabled": false, "class": "px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"}, ["Send"])])])])]);
}
function ProfilePage() {
  let profile = {full_name: "Rishad Hussein", email: "rishad@example.com", career_goals: "Become a full-stack AI engineer"};
  let loading = false;
  let editing = false;
  let formData = {career_goals: profile.career_goals};
  function fetchProfile() {}
  function handleSave() {}
  if (loading) {
    return __jacJsx("div", {"class": "flex justify-center items-center h-64"}, [__jacJsx("div", {"class": "animate-spin rounded-full h-16 w-16 border-b-2 border-blue-500"}, [])]);
  }
  return __jacJsx("div", {"class": "max-w-4xl mx-auto px-4 py-6"}, [__jacJsx("div", {"class": "bg-white rounded-lg shadow-lg p-6"}, [__jacJsx("h2", {"class": "text-2xl font-bold mb-4"}, []), __jacJsx("p", {"class": "text-gray-600 mb-4"}, []), __jacJsx("div", {"class": "mb-4"}, [__jacJsx("label", {"class": "block text-gray-700 font-medium mb-2"}, ["Career Goals"]), __jacJsx("textarea", {"value": formData.career_goals, "onChange": e => {
    setInput(e.target.value);
  }, "class": "w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none", "rows": "4"}, [])]), __jacJsx("div", {"class": "flex space-x-2"}, [__jacJsx("button", {"onClick": e => {
    setInput(e.target.value);
  }, "class": "px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium"}, ["Edit"]), __jacJsx("button", {"onClick": handleSave, "class": "px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 font-medium"}, ["Save"])])])]);
}
function app() {
  let [isLoggedIn, setIsLoggedIn] = useState(jacIsLoggedIn());
  let [graphRestult, setGraphResult] = useState(null);
  let [result, setResult] = useState(null);
  useEffect(() => {
    async function load_user_data() {
      let graph_init_result = await __jacSpawn("graph_init", "", {});
    }
    load_user_data();
  }, []);
  return __jacJsx(Router, {}, [__jacJsx(Navbar, {"isLoggedIn": isLoggedIn, "setIsLoggedIn": setIsLoggedIn}, []), __jacJsx(Routes, {}, [__jacJsx(Route, {"path": "/", "element": __jacJsx(HomePage, {}, [])}, []), __jacJsx(Route, {"path": "/login", "element": __jacJsx(LoginPage, {"isLoggedIn": isLoggedIn, "setIsLoggedIn": setIsLoggedIn}, [])}, []), __jacJsx(Route, {"path": "/signup", "element": __jacJsx(SignupPage, {"isLoggedIn": isLoggedIn, "setIsLoggedIn": setIsLoggedIn}, [])}, []), __jacJsx(Route, {"path": "/dashboard", "element": __jacJsx(DashboardPage, {}, [])}, []), __jacJsx(Route, {"path": "/assessment", "element": __jacJsx(AssessmentPage, {}, [])}, []), __jacJsx(Route, {"path": "/chat", "element": __jacJsx(ChatPage, {}, [])}, []), __jacJsx(Route, {"path": "/profile", "element": __jacJsx(ProfilePage, {}, [])}, []), __jacJsx(Route, {"path": "*", "element": __jacJsx(NotFoundPage, {}, [])}, [])])]);
}
export { AssessmentPage, ChatPage, DashboardPage, HomePage, LoginPage, Navbar, NotFoundPage, ProfilePage, SignupPage, app };
