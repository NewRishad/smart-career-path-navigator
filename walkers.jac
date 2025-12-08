import models;
import llm_agents;

walker ResumeParser {
    can User;

    fn entry() {
        print("🚀 Parsing resume for user:", root.name);

        skills = LLM.call("extract_skills", root.resume_text);

        for s in skills {
            match_skill = find Skill where .name == s;
            if not match_skill {
                match_skill = spawn Skill(name=s);
            }
            create edge has_skill(strength=0.5) between root and match_skill;
            print("➕ Added skill:", s);
        }
    }
}

walker GenerateLearningPath {
    can User;

    fn entry() {
        print("📘 Running learning path generator...");

        report = LLM.call("gap_analysis", root);
        plan = LLM.call("build_learning_path", report);

        print("🔮 Recommended Learning Path:");
        for step in plan {
            print(" •", step);
        }

        root << plan;
    }
}
