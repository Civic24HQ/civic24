# Claude Code Project Guide

This repository uses `@AGENTS.md` as the single source of truth for all architectural rules, commands, and engineering protocols.

Before executing any tasks, read these files. The label on each one sets its authority, not its position in the list:
- @AGENTS.md: standing repo rules. Always applies.
- @docs/V2_REFACTOR_PROMPT.md: REFERENCE ONLY. Use it for extra detail, examples or checks the master plan does not cover. Never follow it where it contradicts the master plan or AGENTS.md.
- @docs/CIVIC24_REFACTOR_PROMPT.md: the MASTER refactor plan. Follow its phases, rules, verification steps and definition of done. On any technical point it overrides V2_REFACTOR_PROMPT.md.

Known conflicts, already decided (the master plan wins):
- ProGuard: do not add Gson or Freezed model keep rules. Freezed models are Dart, so R8 does not touch them. Only add keep rules when a real release crash or a plugin's docs require them, and log why.
- AI model: do not hardcode Gemini 2.0 Flash. Use the current Gemini Flash model from the live model list (Phase 9 only).
- Java: do not force Java 17. Use whatever the Android Gradle Plugin requires (17 minimum, 21 if needed), zulu distribution, one version across all workflows.

If you find any other conflict between these files, stop and ask instead of choosing.
