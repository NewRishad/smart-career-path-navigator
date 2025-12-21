# ************************************************************************   BACKEND CODE    ************************************************************************
# -----------------------------
#           NODES              |
# -----------------------------
node User {
    has username: str;
    has career_goals: str;
    has points: int;
}

node Skill {
    has name: str;
    has category: str = "";
}

node Role {
    has name: str;
}

node Course {
    has title: str;
    has difficulty: str;
}

node JobPosting {
    has title: str;
    has company: str;
}

# -----------------------------
#           EDGES              |
# -----------------------------
edge has_skill {
    has level: int;
}

edge targets_role {}

edge requires_skill {
    has weight: int;
}

edge teaches_skill {}

edge demands_skill {}

 # Walker to fetch user data
walker fetch_user_data {
    can start with `root entry {
        print("Current node: ", here);
        visit [-->];
    }

    can on_user with User entry {
        report here;
    }
}


# -----------------------------
#        MAIN LOGIC            |  
# -----------------------------

walker graph_init {

    can start with `root entry {
        # Guard: only init once
        u1 = User(
            username="test_user",
            career_goals="Become a Backend Software Engineer",
            points=0
        );
        root ++> u1;

        # -----------------------------
        # Roles
        # -----------------------------
        r1 = Role(name="Backend Developer");
        r2 = Role(name="Data Engineer");
        r3 = Role(name="ML Engineer");

        here ++> r1;
        here ++> r2;
        here ++> r3;

        # -----------------------------
        # Skills
        # -----------------------------
        s1 = Skill(name="Python", category="Programming");
        s2 = Skill(name="SQL", category="Databases");
        s3 = Skill(name="APIs", category="Backend");
        s4 = Skill(name="Docker", category="DevOps");
        s5 = Skill(name="Git", category="Tools");
        s6 = Skill(name="Linux", category="OS");
        s7 = Skill(name="Data Modeling", category="Data");
        s8 = Skill(name="Machine Learning", category="AI");
        s9 = Skill(name="Cloud Basics", category="Cloud");
        s10 = Skill(name="Problem Solving", category="General");

        here ++> s1;
        here ++> s2;
        here ++> s3;
        here ++> s4;
        here ++> s5;
        here ++> s6;
        here ++> s7;
        here ++> s8;
        here ++> s9;
        here ++> s10;

        # -----------------------------
        # Courses
        # -----------------------------
        c1 = Course(title="Python for Backend Devs", difficulty="beginner");
        c2 = Course(title="REST APIs with FastAPI", difficulty="intermediate");
        c3 = Course(title="SQL & Data Modeling", difficulty="beginner");
        c4 = Course(title="Docker Fundamentals", difficulty="beginner");
        c5 = Course(title="Intro to Machine Learning", difficulty="intermediate");

        here ++> c1;
        here ++> c2;
        here ++> c3;
        here ++> c4;
        here ++> c5;

        # -----------------------------
        # Jobs
        # -----------------------------
        j1 = JobPosting(title="Junior Backend Developer", company="TechNova");
        j2 = JobPosting(title="Backend Engineer", company="Cloudify");
        j3 = JobPosting(title="Data Engineer I", company="DataWorks");
        j4 = JobPosting(title="ML Engineer", company="AICorp");
        j5 = JobPosting(title="Software Engineer", company="StartupX");

        here ++> j1;
        here ++> j2;
        here ++> j3;
        here ++> j4;
        here ++> j5;

        # -----------------------------
        # User skills
        # -----------------------------
        u1 +>: has_skill(level=3) :+> s1;
        u1 +>: has_skill(level=2) :+> s2;
        u1 +>: has_skill(level=2) :+> s5;
        u1 +>: has_skill(level=1) :+> s10;

        u1 +>: targets_role :+> r1;

        # -----------------------------
        # Role requirements
        # -----------------------------
        r1 +>: requires_skill(weight=3) :+> s1;
        r1 +>: requires_skill(weight=2) :+> s3;
        r1 +>: requires_skill(weight=2) :+> s2;
        r1 +>: requires_skill(weight=1) :+> s4;

        r2 +>: requires_skill(weight=3) :+> s2;
        r2 +>: requires_skill(weight=2) :+> s7;

        r3 +>: requires_skill(weight=3) :+> s8;
        r3 +>: requires_skill(weight=2) :+> s1;

        # -----------------------------
        # Courses → Skills
        # -----------------------------
        c1 +>: teaches_skill :+> s1;
        c2 +>: teaches_skill :+> s3;
        c3 +>: teaches_skill :+> s2;
        c4 +>: teaches_skill :+> s4;
        c5 +>: teaches_skill :+> s8;

        # -----------------------------
        # Jobs → Skills
        # -----------------------------
        j1 +>: demands_skill :+> s1;
        j1 +>: demands_skill :+> s3;

        j2 +>: demands_skill :+> s1;
        j2 +>: demands_skill :+> s4;

        j3 +>: demands_skill :+> s2;
        j3 +>: demands_skill :+> s7;

        j4 +>: demands_skill :+> s8;

        j5 +>: demands_skill :+> s1;
        j5 +>: demands_skill :+> s10;

        report "Graph initialization complete.";
    }
}




# ************************************************************************   FRONTEND CODE    ************************************************************************

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
            <Link to="/dashboard" class="text-indigo-600 font-semibold hover:text-indigo-500">Go Home</Link>
        </div>;
    }

    # Navbar
    def Navbar(props: any) -> any {
        let isLoggedIn = props.isLoggedIn;
        let navigate = useNavigate();

        if not isLoggedIn {

        }

        let [path, setPath] = useState(window.location.hash);

        def isActive(path: str) -> str {
            if window.location.href.includes(path) {
              return "text-indigo-600 border-b-2 border-indigo-600";
            } else {
              return "text-gray-600 hover:text-indigo-600 transition-colors";
            }
        }

        def handleLogout() -> None {
            props.setIsLoggedIn(false);
            jacLogout();
            navigate("/login");
        }
        
        return <nav class="bg-white shadow-lg">
            <div class="max-w-7xl mx-auto px-4">
               <div class="flex justify-between items-center h-16">
                    <div class="flex items-center space-x-8">
                        <Link to="/dashboard" class="text-2xl font-bold text-blue-600">
                            KaziPath
                        </Link>
                        <div class="hidden md:flex space-x-6">
                            <Link to="/dashboard" class={"px-2 py-1 " + isActive("/dashboard")} onClick={lambda -> None { setPath("/dashboard"); }}>
                                Dashboard
                            </Link>
                            <Link to="/assessment" class={"px-2 py-1 " + isActive("/assessment")} onClick={lambda -> None { setPath("/assessment"); }}>
                                Assessment
                            </Link>
                            <Link to="/courses" class={"px-2 py-1 " + isActive("/courses")} onClick={lambda -> None { setPath("/courses"); }}>
                                Courses
                            </Link>
                            <Link to="/jobs" class={"px-2 py-1 " + isActive("/jobs")} onClick={lambda -> None { setPath("/jobs"); }}>
                                Jobs
                            </Link>
                            <Link to="/chat" class={"px-2 py-1 " + isActive("/chat")} onClick={lambda -> None { setPath("/chat"); }}>
                                AI Assistant
                            </Link>
                        </div>
                     </div>

                     <div class="flex items-center space-x-4">
                        <div class="flex items-center space-x-2">
                            <span class="text-yellow-500">⭐</span>
                            <span class="text-sm font-medium">0 points</span>
                        </div>
                        <Link to="/profile" class="text-gray-600 hover:text-blue-600">
                        👤 Rishad
                        </Link>
                        <button
                        class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600"
                        onclick={handleLogout}
                        >
                        Logout
                        </button>
                    </div> 
            </div>
            </div>
        </nav>;
    }

       

    # Dashboard ---------------------------------------------
    def DashboardPage() -> any {
        return 
            <div class="max-w-7xl mx-auto px-4 py-6">
            <div class="bg-gradient-to-r from-blue-600 to-purple-600 rounded-lg p-6 text-white mb-6">
              <h1 class="text-3xl font-bold mb-2">
                # TODO: add stats into div
                Welcome back!
              </h1>
              <p class="text-blue-100">
                Ready to continue your learning journey? Let's achieve your career goals together!
              </p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-6">

              <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                  <div class="p-2 bg-green-100 rounded-lg">
                    <span class="text-2xl">📚</span>
                  </div>
                  <div class="ml-4">
                    <p class="text-sm text-gray-600">Completed Courses</p>
                    # TODO: add stats into div
                    # call the walker to get data from the backend
                    # 
                    <p class="text-2xl font-bold text-green-600">3</p>
                  </div>
                </div>
              </div>

              <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                  <div class="p-2 bg-yellow-100 rounded-lg">
                    <span class="text-2xl">⭐</span>
                  </div>
                  <div class="ml-4">
                    <p class="text-sm text-gray-600">Total Points</p>
                    # TODO: add stats into div
                    <p class="text-2xl font-bold text-yellow-600">100</p>
                  </div>
                </div>
              </div>

              <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                  <div class="p-2 bg-orange-100 rounded-lg">
                    <span class="text-2xl">🔥</span>
                  </div>
                  <div class="ml-4">
                    <p class="text-sm text-gray-600">Current Streak</p>
                    # TODO: add stats into div
                    <p class="text-2xl font-bold text-orange-600">7</p>
                  </div>
                </div>
              </div>

              <div class="bg-white p-6 rounded-lg shadow">
                <div class="flex items-center">
                  <div class="p-2 bg-purple-100 rounded-lg">
                    <span class="text-2xl">🏆</span>
                  </div>
                  <div class="ml-4">
                    <p class="text-sm text-gray-600">Leaderboard Rank</p>
                    # TODO: add stats into div
                    <p class="text-2xl font-bold text-purple-600">1123</p>
                  </div>
                </div>
              </div>

            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

              <div class="bg-white rounded-lg shadow p-6">
                <h3 class="text-lg font-semibold mb-4">Quick Actions</h3>
                <div class="space-y-3">

                  <Link to="/assessment" class="block p-4 bg-blue-50 rounded-lg hover:bg-blue-100 transition-colors">
                    <div class="flex items-center">
                      <span class="text-2xl mr-3">📝</span>
                      <div>
                        <h4 class="font-medium">Take Assessment</h4>
                        <p class="text-sm text-gray-600">Discover your learning style</p>
                      </div>
                    </div>
                  </Link>

                  <Link to="/courses" class="block p-4 bg-green-50 rounded-lg hover:bg-green-100 transition-colors">
                    <div class="flex items-center">
                      <span class="text-2xl mr-3">🎓</span>
                      <div>
                        <h4 class="font-medium">Browse Courses</h4>
                        <p class="text-sm text-gray-600">Find your next course</p>
                      </div>
                    </div>
                  </Link>

                  <Link to="/jobs" class="block p-4 bg-purple-50 rounded-lg hover:bg-purple-100 transition-colors">
                    <div class="flex items-center">
                      <span class="text-2xl mr-3">💼</span>
                      <div>
                        <h4 class="font-medium">Job Matching</h4>
                        <p class="text-sm text-gray-600">Find perfect opportunities</p>
                      </div>
                    </div>
                  </Link>

                  <Link to="/chat" class="block p-4 bg-yellow-50 rounded-lg hover:bg-yellow-100 transition-colors">
                    <div class="flex items-center">
                      <span class="text-2xl mr-3">🤖</span>
                      <div>
                        <h4 class="font-medium">AI Assistant</h4>
                        <p class="text-sm text-gray-600">Get personalized guidance</p>
                      </div>
                    </div>
                  </Link>

                </div>
              </div>

              <div class="bg-white rounded-lg shadow p-6">
                <h3 class="text-lg font-semibold mb-4">Continue Learning</h3>
                # TODO: add stats into div
                  <p class="text-gray-500 text-center py-8">
                    No courses started yet. <Link to="/courses" class="text-blue-600">Explore courses</Link>
                  </p>
              </div>

              <div class="space-y-6">
                <div class="bg-white rounded-lg shadow p-6">
                  <h3 class="text-lg font-semibold mb-4">Job Matches</h3>
                  # TODO: add stats into div - p element is just placeholder right now
                    <p class="text-gray-500 text-center text-sm">
                      Complete your profile to see job matches
                    </p>
                </div>
              </div>

            </div>
      </div>;  
    }

def AssessmentPage() -> any {

    # TODO: fetch questions array
    #   question.id (string/number), question.text (string), question.options (array of strings)
    def fetchQuestions() -> None {
        # implement later
    }

    # TODO: track answers array
    #   each answer: { question_id, selected_option (index) }
    let answers = [];

    # TODO: track currentQuestion (int)
    let currentQuestion = 0;

    # TODO: track results object
    #   results.learning_style (string)
    #   results.recommended_approach (string)
    #   results.skill_level (string)
    #   results.recommendations.courses (array of course objects)
    #     course.title (string), course.description (string), course.difficulty (string)
    #     course.duration (string), course.skills (array of strings)
    let results = 1;

    # TODO: track loading (bool)
    let loading = false;

    # TODO: track submitting (bool)
    let submitting = false;

    # empty function placeholders
    def handleAnswer(optionIndex: int) -> None {
        # implement later
    }

    def nextQuestion() -> None {
        # implement later
    }

    def previousQuestion() -> None {
        # implement later
    }

    def submitAssessment() -> None {
        # implement later
    }

    if loading {
        return (
            <div class="flex justify-center items-center h-64">
                <div class="animate-spin rounded-full h-16 w-16 border-b-2 border-blue-500"></div>
            </div>
        );
    }

    if results {
        return (
            <div class="max-w-4xl mx-auto px-4 py-8">
                <div class="bg-white rounded-lg shadow-lg p-8">
                    <div class="text-center mb-8">
                        # TODO: display completion message
                        <h2 class="text-3xl font-bold text-gray-900 mb-4">
                            🎉 Assessment Complete!
                        </h2>
                        <p class="text-lg text-gray-600">
                            Here are your personalized results and recommendations
                        </p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">

                        <div class="bg-gradient-to-r from-blue-50 to-blue-100 p-6 rounded-lg">
                            <h3 class="text-xl font-semibold mb-2">Your Learning Style</h3>
                            # TODO: results.learning_style (string) here
                            <p class="text-2xl font-bold text-blue-600 mb-2"></p>
                            # TODO: results.recommended_approach (string) here
                            <p class="text-sm text-gray-600"></p>
                        </div>

                        <div class="bg-gradient-to-r from-green-50 to-green-100 p-6 rounded-lg">
                            <h3 class="text-xl font-semibold mb-2">Skill Level</h3>
                            # TODO: results.skill_level (string) here
                            <p class="text-2xl font-bold text-green-600 mb-2"></p>
                            <p class="text-sm text-gray-600">
                                Courses will be tailored to your current level
                            </p>
                        </div>

                    </div>

                    # TODO: map over results.recommendations.courses array
                    <div class="mb-8">
                        <h3 class="text-2xl font-semibold mb-4">Recommended Learning Path</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            # TODO: for each course:
                            #   course.title, course.description, course.difficulty, course.duration, course.skills (array)
                            <div class="border rounded-lg p-4 hover:shadow-md transition-shadow">
                                <h4 class="font-semibold text-lg mb-2"></h4>
                                <p class="text-gray-600 text-sm mb-3"></p>
                                <div class="flex justify-between items-center text-sm">
                                    <span class="px-2 py-1 bg-blue-100 text-blue-800 rounded"></span>
                                    <span class="text-gray-500"></span>
                                </div>
                                <div class="mt-2">
                                    <p class="text-xs text-gray-500">Skills you'll learn:</p>
                                    <div class="flex flex-wrap gap-1 mt-1">
                                        # TODO: map over course.skills array and render each skill
                                        <span class="text-xs px-2 py-1 bg-gray-100 rounded"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center space-x-4">
                        <button
                            onClick={lambda -> None { navigate('/courses'); }}
                            class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-medium"
                        >
                            Start Learning
                        </button>
                        <button
                            onClick={lambda -> None {navigate('/dashboard'); }}
                            class="bg-gray-200 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-300 font-medium"
                        >
                        Return to Dashboard
                        </button>
                    </div>

                </div>
            </div>
        );
    }
}

def ChatPage() -> any {
    # TODO: initialize messages array with sample bot message
    let messages = [
        {
            id: 1,
            type: 'bot', # "bot" or "user"
            content: "Hello! I'm your CareerNavigator-AI assistant. I'm here to help you with your learning journey, career guidance, and job search. What can I help you with today?",
            timestamp: "Wed Dec 17 2025 23:33:15 GMT+0300 (East Africa Time)" # TODO: timestamp format
        }
    ];

    # TODO: track input message (string)
    let inputMessage = "";

    # TODO: track typing indicator (bool)
    let isTyping = true; # set to true so page shows typing indicator for demo

    # placeholder for scrolling reference
    let messagesEndRef = null;

    # empty scroll function
    def scrollToBottom() -> None {
        # implement later
    }

    # empty sendMessage function
    def sendMessage() -> None {
        # TODO: append user message to messages array
        # TODO: call API to get bot response and append to messages
        # implement later
    }

    # empty handleKeyPress function
    def handleKeyPress(e: obj) -> None {
        # TODO: trigger sendMessage() if Enter pressed without Shift
        # implement later
    }

    # TODO: quick questions array (string array)
    let quickQuestions = [
        "What learning path should I follow?",
        "How can I improve my programming skills?",
        "What jobs match my current skills?",
        "Tips for preparing for technical interviews"
    ];

    return (
        <div class="max-w-4xl mx-auto px-4 py-6">
            <div class="bg-white rounded-lg shadow-lg h-[600px] flex flex-col">

                <div class="bg-gradient-to-r from-blue-600 to-purple-600 text-white p-4 rounded-t-lg">
                    <h2 class="text-xl font-semibold flex items-center">
                        🤖 CareerNavigator-AI Assistant
                    </h2>
                    <p class="text-blue-100 text-sm mt-1">
                        Get personalized guidance for your career development
                    </p>
                </div>

                <div class="flex-1 overflow-y-auto p-4 space-y-4">
                    # TODO: map over messages array
                    #   message.id, message.type ("bot"|"user"), message.content (string), message.timestamp (Date)
                    <div class="flex justify-start">
                        <div class="max-w-xs lg:max-w-md px-4 py-2 rounded-lg bg-gray-100 text-gray-900">
                            <p class="text-sm whitespace-pre-wrap">
                                # TODO: message.content
                            </p>
                            <p class="text-xs mt-1 text-gray-500">
                                # TODO: message.timestamp
                            </p>
                        </div>
                    </div>

                    # TODO: display typing indicator if isTyping == true
                    <div class="flex justify-start">
                        <div class="bg-gray-100 text-gray-900 px-4 py-2 rounded-lg">
                            <div class="flex space-x-1">
                                <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                                <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                                <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
                            </div>
                        </div>
                    </div>

                    # reference div for scrolling
                    <div ref={messagesEndRef} />
                </div>

                # TODO: quick questions section (show if messages.length >= 1)
                <div class="px-4 py-2 border-t border-gray-200">
                    <p class="text-sm text-gray-600 mb-2">Quick questions to get started:</p>
                    <div class="flex flex-wrap gap-2">
                        # TODO: map over quickQuestions array and render buttons
                        <button class="text-xs px-3 py-1 bg-blue-100 text-blue-700 rounded-full hover:bg-blue-200 transition-colors">
                            # TODO: question text
                        </button>
                    </div>
                </div>

                # input box
                <div class="p-4 border-t border-gray-200">
                    <div class="flex space-x-2">
                        <textarea
                            value={inputMessage} # TODO: bind to inputMessage
                            onChange={lambda e: any -> None { setInput(e.target.value); }} # TODO: update inputMessage
                            onKeyPress={handleKeyPress}
                            placeholder="Ask me anything about your career or learning journey..."
                            class="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none"
                            rows="2"
                            disabled={false} # TODO: disable if isTyping
                        />
                        <button
                            onClick={sendMessage}
                            disabled={false} # TODO: disable if input empty or isTyping
                            class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            Send
                        </button>
                    </div>
                </div>

            </div>
        </div>
    );
}

def ProfilePage() -> any {

    # TODO: profile object
    #   profile.full_name (string)
    #   profile.email (string)
    #   profile.career_goals (string)
    let profile = {
        full_name: "Rishad Hussein", # TODO: dynamic from API
        email: "rishad@example.com",  # TODO: dynamic from API
        career_goals: "Become a full-stack AI engineer" # TODO: dynamic from API
    };

    # TODO: loading state
    let loading = false; # set to false to render page

    # TODO: editing state (bool)
    let editing = false;

    # TODO: formData object
    #   formData.career_goals (string)
    let formData = {
        career_goals: profile.career_goals
    };

    # empty fetchProfile function
    def fetchProfile() -> None {
        # TODO: fetch profile from API and update profile & formData
    }

    # empty handleSave function
    def handleSave() -> None {
        # TODO: send updated formData to API and update profile
    }

    if loading {
        return (
            <div class="flex justify-center items-center h-64">
                <div class="animate-spin rounded-full h-16 w-16 border-b-2 border-blue-500"></div>
            </div>
        );
    }

    return (
        <div class="max-w-4xl mx-auto px-4 py-6">
            <div class="bg-white rounded-lg shadow-lg p-6">
                <h2 class="text-2xl font-bold mb-4">
                    # TODO: profile.full_name
                </h2>
                <p class="text-gray-600 mb-4">
                    # TODO: profile.email
                </p>

                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Career Goals</label>
                    <textarea
                        value={formData.career_goals} # TODO: bind to formData.career_goals
                        onChange={lambda e: any -> None { setInput(e.target.value); }} 
                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none"
                        rows="4"
                    />
                </div>

                <div class="flex space-x-2">
                    # TODO: toggle editing mode
                    <button
                        onClick={lambda e: any -> None { setInput(e.target.value); }} # TODO: set editing=true
                        class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium"
                    >
                        Edit
                    </button>
                    <button
                        onClick={handleSave}
                        class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 font-medium"
                    >
                        Save
                    </button>
                </div>
            </div>
        </div>
    );
}



    # ----------------------------------------------------
    def app() -> any {
        let [isLoggedIn, setIsLoggedIn] = useState(jacIsLoggedIn());

        useEffect(lambda -> None {
            async def load_user_data() -> None {
                init_result = await root spawn graph_init();
                result = await root spawn fetch_user_data();
                console.log(result);
            }
            load_user_data();
        }, []);

        return <Router>
            <Navbar isLoggedIn={isLoggedIn} setIsLoggedIn={setIsLoggedIn} />
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/login" element={<LoginPage isLoggedIn={isLoggedIn} setIsLoggedIn={setIsLoggedIn} />} />
                <Route path="/signup" element={<SignupPage isLoggedIn={isLoggedIn} setIsLoggedIn={setIsLoggedIn} />} />
                <Route path="/dashboard" element={<DashboardPage />} />
                <Route path="/assessment" element={<AssessmentPage />} />
                <Route path="/chat" element={<ChatPage />} />
                <Route path="/profile" element={<ProfilePage />} />

                # for undefined routes
                <Route path="*" element={<NotFoundPage />} />
            </Routes>
        </Router>;
    }
}
