node User {
    has name: str;
    has email: str;
    has resume_text: str;
    has interests: list[str];
    has skills: list[str] = [];
    has learning_path: list[str] = [];
}

node Skill {
    has name: str;
    has trend_score: float = 0.0;
}

node Role {
    has title: str;
    has description: str;
}

node Course {
    has title: str;
    has provider: str;
    has duration_hours: int;
}

node JobPosting {
    has title: str;
    has company: str;
    has location: str;
    has skills: list[str];
}

edge has_skill { strength: float; }
edge needs_skill { level_required: float; }
edge teaches_skill { proficiency_gain: float; }
edge relates_to { }
