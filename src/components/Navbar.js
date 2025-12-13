import {__jacJsx, __jacSpawn} from "@jac-client/utils";
function Navbar() {
  let isLoggedIn = jacIsLoggedIn();
  if (isLoggedIn) {
    return __jacJsx("nav", {"class": "bg-white shadow-md border-b border-gray-100 px-6 py-3 flex justify-between items-center"}, [__jacJsx("div", {"class": "text-indigo-600 font-bold text-lg tracking-tight"}, ["Loreim Ipsum"]), __jacJsx("div", {"class": "flex gap-4 items-center text-sm font-medium"}, [__jacJsx(Link, {"to": "/dashboard", "class": "text-gray-700 hover:text-indigo-600 transition-colors"}, ["Dashboard"]), __jacJsx("button", {"onClick": e => {
      e.preventDefault();
      jacLogout();
      window.location.href = "/page/app#/login";
    }, "class": "bg-indigo-600 text-white px-3 py-1 rounded-md cursor-pointer font-semibold hover:bg-indigo-700 transition-colors shadow-sm"}, ["Logout"])])]);
  }
  return __jacJsx("nav", {"class": "bg-white shadow-md border-b border-gray-100 px-6 py-3 flex justify-between items-center"}, [__jacJsx("div", {"class": "text-gray-900 font-bold text-lg tracking-tight"}, ["Loreim Ipsum"]), __jacJsx("div", {"class": "flex gap-4 items-center text-sm font-medium"}, [__jacJsx(Link, {"to": "/login", "class": "text-indigo-600 hover:text-indigo-500 transition-colors"}, ["Login"]), __jacJsx(Link, {"to": "/signup", "class": "bg-indigo-600 text-white px-3 py-1 rounded-md cursor-pointer font-semibold hover:bg-indigo-700 transition-colors shadow-sm"}, ["Sign Up"])])]);
}
export { Navbar };
