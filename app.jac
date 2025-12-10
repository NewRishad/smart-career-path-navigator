
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

cl {
    # Home Page Componenet
    def HomePage() -> any {
        if jacIsLoggedIn() {
            # Navigate Redirects programmatically
            return <Navigate to="/dashboard" />;
        }
        return <Navigate to="/login" />;
    }

    # Login page Componenet ---------------------------------------
    def LoginPage() -> any {
        let [username, setUsername] = useState("");
        let [password, setPassword] = useState("");
        let [error, setError] = useState("");

        # Check if already logged in
        if jacIsLoggedIn() {
            return <div style={{"padding": "20px"}}>
                <h2>You're already logged in</h2>
                <button onClick={lambda -> None { jacLogout(); }}>
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
                window.location.href = "/page/app#/dashboard"; # What is the # about after app
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
            errorDisplay = <div style={{
                "color": "#dc2626",
                "fontSize": "14px",
                "marginBottom": "10px"
            }}>
                {error}
            </div>;
        }

        return <div style={{
            "minHeight": "100vh",
            "display": "flex",
            "alignItems": "center",
            "justifyContent": "center",
            "background": "#f5f5f5"
        }}>
            <div style={{
                "background": "#ffffff",
                "padding": "30px",
                "borderRadius": "8px",
                "width": "280px",
                "boxShadow": "0 2px 4px rgba(0,0,0,0.1)"
            }}>
                <h2 style={{"marginBottom": "20px"}}>Login</h2>
                <form onSubmit={handleLogin}>
                    <input
                        type="text"
                        value={username}
                        onChange={handleUsernameChange}
                        placeholder="Username"
                        style={{
                            "width": "100%",
                            "padding": "8px",
                            "marginBottom": "10px",
                            "border": "1px solid #ddd",
                            "borderRadius": "4px",
                            "boxSizing": "border-box"
                        }}
                    />
                    <input
                        type="password"
                        value={password}
                        onChange={handlePasswordChange}
                        placeholder="Password"
                        style={{
                            "width": "100%",
                            "padding": "8px",
                            "marginBottom": "10px",
                            "border": "1px solid #ddd",
                            "borderRadius": "4px",
                            "boxSizing": "border-box"
                        }}
                    />
                    {errorDisplay}
                    <button
                        type="submit"
                        style={{
                            "width": "100%",
                            "padding": "8px",
                            "background": "#3b82f6",
                            "color": "#ffffff",
                            "border": "none",
                            "borderRadius": "4px",
                            "cursor": "pointer",
                            "fontWeight": "600"
                        }}
                    >
                        Login
                    </button>
                </form>
                <p style={{
                    "textAlign": "center",
                    "marginTop": "12px",
                    "fontSize": "14px"
                }}>
                    Need an account? <Link to="/signup">Sign up</Link>
                </p>
            </div>
        </div>;
    }

    # SignUp page Component ------------------------------------
    def SignupPage() -> any {
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
                # window.location.href = "/page/app#/login"
                window.location.href = "/page/app#/dashboard"; # I guess this has a better user experience
                    
            } else {
                # interesting way of recieving the error message
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
            errorDisplay = <div style={{
                "color": "#dc2626",
                "fontSize": "14px",
                "marginBottom": "10px"
            }}>
                {error}
            </div>;
        }

        return <div style={{
            "minHeight": "100vh",
            "display": "flex",
            "alignItems": "center",
            "justifyContent": "center",
            "background": "#f5f5f5"
        }}>
            <div style={{
                "background": "#ffffff",
                "padding": "30px",
                "borderRadius": "8px",
                "width": "280px",
                "boxShadow": "0 2px 4px rgba(0,0,0,0.1)"
            }}>
                <h2 style={{"marginBottom": "20px"}}>Sign Up</h2>
                <form onSubmit={handleSignup}>
                    <input
                        type="text"
                        value={username}
                        onChange={handleUsernameChange}
                        placeholder="Username"
                        style={{
                            "width": "100%",
                            "padding": "8px",
                            "marginBottom": "10px",
                            "border": "1px solid #ddd",
                            "borderRadius": "4px",
                            "boxSizing": "border-box"
                        }}
                    />
                    <input
                        type="password"
                        value={password}
                        onChange={handlePasswordChange}
                        placeholder="Password"
                        style={{
                            "width": "100%",
                            "padding": "8px",
                            "marginBottom": "10px",
                            "border": "1px solid #ddd",
                            "borderRadius": "4px",
                            "boxSizing": "border-box"
                        }}
                    />
                    {errorDisplay}
                    <button
                        type="submit"
                        style={{
                            "width": "100%",
                            "padding": "8px",
                            "background": "#3b82f6",
                            "color": "#ffffff",
                            "border": "none",
                            "borderRadius": "4px",
                            "cursor": "pointer",
                            "fontWeight": "600"
                        }}
                    >
                        Sign Up
                    </button>
                </form>
                <p style={{
                    "textAlign": "center",
                    "marginTop": "12px",
                    "fontSize": "14px"
                }}>
                    Have an account? <Link to="/login">Login</Link>
                </p>
            </div>
        </div>;
    }
    # 404 Not found page --------------------------------
    def NotFoundPage() -> any {
        return <div style={{
            "textAlign": "center",
            "padding": "50px"
        }}>
            <h1>404 - Page Not Found</h1>
            <Link to="/">Go Home</Link>
        </div>;
    }
    # Navbar Component
    def Navbar() -> any {
        let isLoggedIn = jacIsLoggedIn();

        if isLoggedIn {
            return <nav style={{
                "padding": "12px 24px",
                "background": "#3b82f6",
                "color": "#ffffff",
                "display": "flex",
                "justifyContent": "space-between"
            }}>
                <div style={{"fontWeight": "600"}}>Smart Career Path Navigator</div>
                <div style={{"display": "flex", "gap": "16px"}}>
                    <Link to="/dashboard" style={{
                    "color": "#ffffff",
                    "textDecoration": "none"
                    }}>
                        Dashboard
                    </Link>
                    <button 
                        onClick={lambda e: any -> None {
                            e.preventDefault(); # removes all default actions
                            jacLogout();
                            window.location.href = "/page/app#/login"; # tf is this #
                        }}
                        style={{
                            "background": "none",
                            "color": "#ffffff",
                            "border": "1px solid #ffffff",
                            "padding": "2px 10px",
                            "borderRadius": "4px",
                            "cursor": "pointer"
                        }}
                        >
                            Logout
                        </button>
                </div>
            </nav>;
        }

        return <nav style={{
            "padding": "12px 24px",
            "background": "#3b82f6",
            "color": "#ffffff",
            "display": "flex",
            "justifyContent": "space-between"
        }}>
            <div style={{"fontWeight": "600"}}>Todo App</div>
            <div style={{"display": "flex", "gap": "16px"}}>
            # Link is prefered as it does not reload the page
            # Alt = <a href="/login"> Go to Login</a> # this causes the page to reload
                <Link to="/login" style={{
                    "color": "#ffffff",
                    "textDecoration": "none"
                }}>
                    Login
                </Link>
                <Link to="/signup" style={{
                    "color": "#ffffff",
                    "textDecoration": "none"
                }}>
                    Sign Up
                </Link>
            </div>
        </nav>;
    }

    # Dashboard ---------------------------------------------
    def DashboardPage() -> any {
        return <div>
            <h1>⚠️ Dashboard page in progress</h1>
        </div>;
    }


    # Application Entry Point
    # ----------------------------------------------------
    def app() -> any {
        return <Router>
            <Navbar />
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/login" element={<LoginPage />} />
                <Route path="/signup" element={<SignupPage />} />
                <Route path="/dashboard" element={<DashboardPage />} />

                # for undefined routes
                <Route path="*" element={<NotFoundPage />} />
            </Routes>
        </Router>;
    }
}
