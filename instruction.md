# AplyFlow MVP Implementation Guide (Instruction)

This file is the step-by-step plan for building the AplyFlow MVP in this repo.
Follow it in order. The goal is to make each step clear enough to implement
without extra guidance.

---

## 0) MVP Goal (why we build)
- Give a student control and transparency over internship/junior applications.
- Track applications, statuses, follow-ups, and analytics.
- Status is derived from actions, not manually edited.

Non-goals:
- No company/recruiter features.
- No complex team workflows.
- No heavy backend; start local-first.

---

## 1) Project structure (current folders)
Keep the existing architecture and place new code here:
- `lib/core/` - shared enums, constants, utils
- `lib/domain/` - entities + usecases (business rules)
- `lib/data/` - models + repositories + mappers (persistence)
- `lib/presentation/` - UI + feature screens

Feature folders already exist:
- `presentation/app`, `auth`, `applications`, `actions`, `dashboard`, `followups`, `widgets`

---

## 2) MVP Scope (what to build)
Entities:
1) Application
2) Action

Statuses (MVP):
- Planned
- Applied
- Interview
- Offer
- Rejected

Action types (MVP):
- Applied
- Interview scheduled
- Interview done
- Follow-up
- Test task received
- Test task submitted
- Offer received
- Rejected
- Note

Screens:
- Splash + Auth (email sign-in)
- Applications list + status filters
- Application details + action timeline + add action/note/follow-up
- Dashboard (counts + pie chart + overdue follow-ups)
- Follow-ups list + mark done

---

## 3) Core enums (define first)
Implement these in `lib/core/enums/`:
- `application_status.dart`
- `action_type.dart`
- `source_type.dart`
- `employment_type.dart`
- `follow_up_channel.dart`
- `interview_format.dart`
- `interview_round.dart`
- `priority_level.dart`

Keep the MVP enums small, then extend later.
Example minimal values (you can expand later):
- ApplicationStatus: planned, applied, interview, offer, rejected
- ActionType: applied, interviewScheduled, interviewDone, followUp, testTaskReceived, testTaskSubmitted, offerReceived, rejected, note
- SourceType: linkedin, companySite, referral, telegram, other
- EmploymentType: internship, junior, partTime, fullTime
- FollowUpChannel: email, linkedin, telegram, other
- InterviewFormat: online, onsite, phone
- InterviewRound: hr, tech, final
- PriorityLevel: low, medium, high

---

## 4) Domain entities (business rules)
Create entities in `lib/domain/entities/`:

### 4.1 Application (entity)
Fields:
- id (String)
- company (String)
- position (String)
- sourceType (SourceType)
- employmentType (EmploymentType)
- createdAt (DateTime)
- updatedAt (DateTime)
- appliedAt (DateTime?)  // first Applied action date

Do NOT store a manual status. Status is derived.
Provide a helper (function or getter) to compute status from actions.

### 4.2 Action (entity)
Fields:
- id (String)
- applicationId (String)
- type (ActionType)
- title (String?) // optional short label
- note (String?)
- createdAt (DateTime)
- scheduledAt (DateTime?) // for interview scheduling or follow-up target date
- completedAt (DateTime?) // when action is done
- followUpDueAt (DateTime?) // only for followUp type
- followUpDone (bool) // for followUp type

Rules:
- Actions are ordered by createdAt (or completedAt if you prefer).
- Latest meaningful action defines current status.

---

## 5) Status derivation (smart logic)
Define a mapping from ActionType -> ApplicationStatus.
Example:
- applied -> applied
- interviewScheduled/interviewDone/testTaskReceived/testTaskSubmitted -> interview
- offerReceived -> offer
- rejected -> rejected
- note/followUp -> no status change (keep previous status)

Algorithm:
1) If no actions -> status = planned
2) Sort actions by createdAt asc
3) Walk from last to first:
   - If action type maps to a status, return that status
4) If no action mapped -> planned

No-response detection:
- If status == applied
- daysSinceLastApplied >= kNoResponseDays
- and no later interview/offer/rejected action
-> mark application as "no response"

Follow-up overdue:
- Action.type == followUp
- followUpDone == false
- followUpDueAt < now
-> overdue

Keep constants in `lib/core/constants/`:
- `kNoResponseDays` (MVP default: 7)

---

## 6) Data layer (persistence)
Start with in-memory storage to ship UI fast, then add local persistence.

Phase A (in-memory):
- Create repositories in `lib/data/repositories/`
- Keep a single `AppState` list of applications + actions
- Use `ChangeNotifier` + `InheritedNotifier` to expose state to UI

Phase B (local persistence):
- Choose one local storage approach (SQLite / Hive / Isar).
- Create models in `lib/data/models/`
- Create mappers in `lib/data/mappers/` to convert model <-> entity
- Update repositories to read/write to storage

Note: keep the repository API the same so UI does not change.

---

## 7) App state (no extra packages)
Create:
- `lib/presentation/app/app_state.dart`
- `lib/presentation/app/app_scope.dart`

Responsibilities:
- hold List<Application> and List<Action>
- CRUD methods:
  - addApplication
  - updateApplication
  - deleteApplication
  - addAction
  - updateAction
  - deleteAction
- computed getters:
  - applicationsWithStatus
  - overdueFollowUps
  - dashboardStats

Expose AppState through an InheritedNotifier so all screens can access it.

---

## 8) Screens (what to build and how)

### 8.1 Splash + Auth
- Splash: short delay, then route to Auth or Home based on stored email
- Auth: email-only sign-in (store email locally)
- Google sign-in is optional; skip for MVP

### 8.2 Applications list (main)
File idea: `presentation/applications/applications_page.dart`
UI:
- list of cards
- top filter chips by status
- each card: company, position, status, last action date
Behavior:
- tap card -> details
- FAB -> add application

### 8.3 Application details
File idea: `presentation/applications/application_details_page.dart`
UI:
- header: company + position + status badge
- timeline of actions (latest first)
- buttons: Add action / Add note / Follow-up
Behavior:
- adding action updates status automatically

### 8.4 Dashboard
File idea: `presentation/dashboard/dashboard_page.dart`
UI:
- counters: Applied, Interviews, Offers, Rejected
- pie chart for status distribution
- list of overdue follow-ups
Note:
- Pie chart can be a simple custom painter (no package needed)

### 8.5 Follow-ups
File idea: `presentation/followups/followups_page.dart`
UI:
- list of follow-up actions with due date
- mark done toggle
Behavior:
- when done, update followUpDone and refresh lists

---

## 9) CRUD flows (step-by-step)
1) Add Application
   - open form (company, position, source, employment type)
   - create application with status planned
   - optional: create initial "applied" action with appliedAt

2) Add Action
   - open bottom sheet or page
   - select ActionType
   - enter note / dates
   - save -> updates application status automatically

3) Add Follow-up
   - create Action with type followUp
   - set followUpDueAt + followUpDone=false
   - list appears on Follow-ups screen

---

## 10) Dashboard analytics (MVP math)
Metrics:
- totalApplications
- statusCounts: planned/applied/interview/offer/rejected
- funnel conversion:
  - applied -> interview ratio = interviews / applied
  - interview -> offer ratio = offers / interviews
  - offer -> accepted (MVP: skip accepted)

All computed from current data in AppState.

---

## 11) Implementation order (roadmap)
1) Fill enums in `lib/core/enums/`
2) Create entities in `lib/domain/entities/`
3) Build AppState + AppScope in `presentation/app/`
4) Create Applications list + details UI (read-only list)
5) Add CRUD for applications and actions
6) Add Dashboard + Follow-ups screens
7) Add smart logic (status derivation, no response, overdue follow-ups)
8) Add persistence (Phase B)
9) Polish UI + empty states + basic validation

---

## 12) Definition of Done (MVP)
- User can add applications and actions
- Status always reflects actions (no manual status change)
- Follow-up list shows overdue items
- Dashboard updates live from data
- Data survives app restart (Phase B)

---

## 13) Testing checklist (manual)
- Add application -> appears in list
- Add applied action -> status becomes Applied
- Add interview action -> status becomes Interview
- Add rejected action -> status becomes Rejected
- Create follow-up due yesterday -> appears in overdue list
- Toggle follow-up done -> removed from overdue

---

## 14) Notes / future scope (not MVP)
- Notifications for follow-up reminders
- Cloud sync / multi-device
- Google auth
- More analytics and export
