
# Pages
cl import from react {useState, useEffect}
cl import from "@jac-client/utils" {
    Router,
    Routes,
    Route,
    Link,
    Navigate,
    useNavigate,
    jacLogin,
    jacSignup,
    jacLogout,
    jacIsLoggedIn
}
# cl import from "./assets/cover.png" { default as coverImage }
cl import ".global.css";


cl {
    # Home Page Componenet
    def HomePage() -> any {
        if jacIsLoggedIn() {
            # Navigate Redirects programmatically
            return <Navigate to="/dashboard" />;
        }
        return <Navigate to="/login" />;
    }

    def LoginPage(props: any) -> any {
        let [username, setUsername] = useState("");
        let [password, setPassword] = useState("");
        let [error, setError] = useState("");

        # Check if already logged in
        if jacIsLoggedIn() {
            return <div class="p-5">
                <h2 class="text-xl font-bold">You're already logged in</h2>
                <button 
                    onClick={lambda -> None { 
                        jacLogout(); 
                        props.setIsLoggedIn(false);
                        }} 
                    class="mt-4 px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 transition"
                >
                    Logout
                </button>
            </div>;
        }

        async def handleLogin(e: any) -> None {
            e.preventDefault();
            setError("");

            if not username or not password {
                setError("Please fill in all fields");
                return;
            }

            success = await jacLogin(username, password);
            if success {
                # Navigate to dashboard
                props.setIsLoggedIn(true);
                window.location.href = "/page/app#/dashboard"; 
            } else {
                setError("Invalid credentials");
            }
    }

    def handleUsernameChange(e: any) -> None {
        setUsername(e.target.value);
    }

    def handlePasswordChange(e: any) -> None {
        setPassword(e.target.value);
    }

    let errorDisplay = None;
    if error {
        errorDisplay = <div class="text-sm font-medium text-red-600 mt-2">
            {error}
        </div>;
    }
    return <div class="flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8 bg-white">
        
        <div class="sm:mx-auto sm:w-full sm:max-w-sm">
            <img src="/static/assets/icon.svg" alt="Your Company" class="mx-auto h-10 w-auto" />
            <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Sign in to your account</h2>
        </div>

        <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form onSubmit={handleLogin} class="space-y-6">
                <div>
                    <label for="username" class="block text-sm/6 font-medium text-gray-900">Username</label>
                    <div class="mt-2">
                        <input 
                            id="username" 
                            type="text" 
                            value={username}
                            onChange={handleUsernameChange}
                            required 
                            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6" 
                        />
                    </div>
                </div>

                <div>
                    <div class="flex items-center justify-between">
                        <label for="password" class="block text-sm/6 font-medium text-gray-900">Password</label>
                        <div class="text-sm">
                            <p href="#" class="font-semibold text-indigo-600 hover:text-indigo-500">Forgot password?</p>
                        </div>
                    </div>
                    <div class="mt-2">
                        <input 
                            id="password" 
                            type="password" 
                            value={password}
                            onChange={handlePasswordChange}
                            required 
                            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6" 
                        />
                    </div>
                </div>
    
                {errorDisplay}
                <div>
                    <button 
                        type="submit" 
                        class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                    >
                        Sign in
                    </button>
                </div>
            </form>

            <p class="mt-10 text-center text-sm/6 text-gray-500">
                Not a member?
                <Link to="/signup" class="font-semibold text-indigo-600 hover:text-indigo-500"> Click here to Register</Link>
            </p>
        </div>
    </div>;
}

    def SignupPage(props: any) -> any {
    let [username, setUsername] = useState("");
    let [password, setPassword] = useState("");
    let [error, setError] = useState("");

    async def handleSignup(e: any) -> None {
        e.preventDefault();
        setError("");

        if not username or not password {
            setError("Please fill in all fields");
            return;
        }

        result = await jacSignup(username, password);
        if result["success"] {
            props.setIsLoggedIn(true);
            window.location.href = "/page/app#/dashboard"; 
        } else {
            setError(result["error"] if result["error"] else "Signup failed");
        }
    }

    def handleUsernameChange(e: any) -> None {
        setUsername(e.target.value);
    }

    def handlePasswordChange(e: any) -> None {
        setPassword(e.target.value);
    }

    let errorDisplay = None;
    if error {
        errorDisplay = <div class="text-sm font-medium text-red-600 mt-2">
            {error}
        </div>;
    }

    return <div class="flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8 bg-white">
        <div class="sm:mx-auto sm:w-full sm:max-w-sm">
            <img src="/static/assets/icon.svg" alt="Your Company" class="mx-auto h-10 w-auto" />
            <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Create your account</h2>
        </div>

        <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form onSubmit={handleSignup} class="space-y-6">
                <div>
                    <label for="username" class="block text-sm/6 font-medium text-gray-900">Username</label>
                    <div class="mt-2">
                        <input 
                            id="username"
                            type="text"
                            value={username}
                            onChange={handleUsernameChange}
                            required
                            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
                        />
                    </div>
                </div>

                <div>
                    <label for="password" class="block text-sm/6 font-medium text-gray-900">Password</label>
                    <div class="mt-2">
                        <input 
                            id="password"
                            type="password"
                            value={password}
                            onChange={handlePasswordChange}
                            required
                            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
                        />
                    </div>
                </div>

                {errorDisplay}

                <div>
                    <button 
                        type="submit"
                        class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                    >
                        Sign Up
                    </button>
                </div>
            </form>

            <p class="mt-10 text-center text-sm/6 text-gray-500">
                Already have an account? 
                <Link to="/login" class="font-semibold text-indigo-600 hover:text-indigo-500">Login</Link>
            </p>
        </div>
    </div>;
}

    # 404 Not found page --------------------------------
    def NotFoundPage() -> any {
        return <div class="flex min-h-screen flex-col items-center justify-center p-12 text-center">
            <h1 class="text-4xl font-bold mb-4">404 - Page Not Found</h1>
            <Link to="/" class="text-indigo-600 font-semibold hover:text-indigo-500">Go Home</Link>
        </div>;
    }

    # Navbar Component
    def Navbar(props: any) -> any {
        let isLoggedIn = jacIsLoggedIn();
        # logged in View
        if isLoggedIn {
            return <nav class="bg-white shadow-md border-b border-gray-100 px-6 py-3 flex justify-between items-center">
                <div class="text-indigo-600 font-bold text-lg tracking-tight">Loreim Ipsum</div>
                <div class="flex gap-4 items-center text-sm font-medium">
                    <Link to="/dashboard" class="text-gray-700 hover:text-indigo-600 transition-colors">
                        Dashboard
                    </Link>
                    <button 
                        onClick={lambda e: any -> None {
                            e.preventDefault(); 
                            jacLogout();
                            props.setIsLoggedIn(false);
                            window.location.href = "/page/app#/login";
                        }}
                        class="bg-indigo-600 text-white px-3 py-1 rounded-md cursor-pointer font-semibold hover:bg-indigo-700 transition-colors shadow-sm"
                        >
                        Logout
                    </button>
                </div>
            </nav>;
        }

        # Logged-Out View
        return <nav class="bg-white shadow-md border-b border-gray-100 px-6 py-3 flex justify-between items-center">
            <div class="text-gray-900 font-bold text-lg tracking-tight">Loreim Ipsum</div>
            <div class="flex gap-4 items-center text-sm font-medium">
                <Link to="/login" class="text-indigo-600 hover:text-indigo-500 transition-colors">
                    Login
                </Link>
                <Link to="/signup" class="bg-indigo-600 text-white px-3 py-1 rounded-md cursor-pointer font-semibold hover:bg-indigo-700 transition-colors shadow-sm">
                    Sign Up
                </Link>
            </div>
        </nav>;
    }

    # Dashboard ---------------------------------------------
    def DashboardPage() -> any {
        return <div class="flex flex-col items-center gap-6 p-7 md:flex-row rounded-2xl">
  <div>
    <img class="size-48 shadow-xl rounded-md" alt="" src="/static/assets/cover.png" />
  </div>
  <div class="flex items-center">
    <span class="text-2xl font-medium">Class Warfare</span>
    <span class="font-medium text-sky-500">The Anti-Patterns</span>
    <span class="flex gap-2 font-medium text-gray-600 dark:text-gray-400">
      <span>No. 4</span>
      <span>·</span>
      <span>2025</span>
    </span>
  </div>
</div>;
    }


    # Application Entry Point
    # ----------------------------------------------------
    def app() -> any {
        let [isLoggedIn, setIsLoggedIn] = useState(jacIsLoggedIn());


        return <Router>
            <Navbar isLoggedIn={isLoggedIn} setIsLoggedIn={setIsLoggedIn} />
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/login" element={<LoginPage isLoggedIn={isLoggedIn} setIsLoggedIn={setIsLoggedIn} />} />
                <Route path="/signup" element={<SignupPage isLoggedIn={isLoggedIn} setIsLoggedIn={setIsLoggedIn} />} />
                <Route path="/dashboard" element={<DashboardPage />} />

                # for undefined routes
                <Route path="*" element={<NotFoundPage />} />
            </Routes>
        </Router>;
    }
}
