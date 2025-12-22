# Smart Career Path Navigator 🧭 [Prototype]
An architectural proof-of-concept for an AI-driven career platform. This project demonstrates the seamless integration of a Graph-based Backend (Jac) with a React Frontend, showcasing how complex user data (skills, roles, learning paths) can be modeled and visualized.

**Current Status:** This repository represents the structural foundation of the application. It contains the full UI logic and Backend Schema definitions. Data is currently mocked/simulated for demonstration purposes.

# 🏗️ Tech Stack
- Language: Jac (Jaseci) & Python 3.9+
- Frontend: Jac-client, TailwindCSS
- Backend: Jac Graph Model (Nodes/Walkers)
- Visualization: Graph-based data flow

# ⚡ Key Features (Implemented)
## 🎨 Frontend Architecture
- Modern Dashboard: Responsive UI layout built with TailwindCSS.
- Authentication Flow: UI implementation for Login/Signup screens.
- Interactive Modules: Shells for Assessment, Course listing, and Job matching.
- Chat Interface: A fully styled chat UI ready for LLM integration.

## 🧠 Backend Graph Schema
- Graph Data Model: Defined Nodes for User, Skill, Role, Course, and JobPosting. 
- Relational Edges: Logic for has_skill, targets_role, and requires_skill.
- Walkers: Basic walkers implemented for initializing graph data and traversing user nodes.

# 🚀 Getting Started
Follow these steps to spin up the prototype.

## 1. Dependencies
Ensure you have the following installed:
- Node.js (v18+)
- Python (v3.9+)
- Jac CLI

## 2. Installation
Since the frontend and backend are tightly integrated, install dependencies for both:

### 1. Install Python Backend Requirements
```bash
pip install -r requirements.txt
```

### 2. Install Frontend Node Packages
```bash
npm install
```

### 3. Running the Prototype
Launch the Jac server. This serves both the backend logic and the frontend assets:

```bash
jac serve app.jac
```

Once running, navigate to the localhost URL provided in the terminal to interact with the UI.

# 🗺️ Roadmap & Future Implementation
The following features are planned to move this from Prototype to Production:
- [ ] Live Data Injection: Replace graph_init dummy data with real DB persistence.
- [ ] AI Integration: Connect the Chat UI to an LLM for dynamic career advice.
- [ ] Dynamic Scoring: Implement logic to calculate real-time user points and streaks based on walker traversal.
- [ ] Recommendation Engine: finalize the walker logic to match User Skills -> Job Requirements.