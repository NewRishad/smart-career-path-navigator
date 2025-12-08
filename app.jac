import models;
import walkers;
import llm_agents;

root = spawn User(
    name="Alice",
    email="alice@example.com",
    interests=["AI", "Data Science"],
    resume_text=file("sample_resume.txt")
);

# Step 1: Parse resume
spawn ResumeParser on root;

# Step 2: Generate learning path
spawn GenerateLearningPath on root;

print("🎉 Execution complete!");
