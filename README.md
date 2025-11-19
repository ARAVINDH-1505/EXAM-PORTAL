# Cursor Secure Exam Suite

Full-stack web application that delivers a secure assessment experience with server-enforced auditing, randomized questions, roster-based authentication, and client-side watchdogs for tab switching, shortcuts, and copy attempts.

## Project structure

```
D:\DC\Exam_UI\Exam_UI_Cursor
├── client/   # React + Vite UI with security hardening
├── server/   # Express API + MySQL integration
└── data/     # (optional) space for exports/backups
```

## Backend (server)

1. Create the database and tables:

   ```bash
   cd server
   mysql -u root -p < src/db/schema.sql
   ```

2. Configure environment variables:

   ```bash
   cp .env.example .env
   # update DB_PASSWORD, EXAM_PASSWORD, etc.
   ```

3. Start the API:

   ```bash
   npm install
   npm run start
   ```

   The API listens on `http://localhost:4000` by default and exposes:

   - `POST /api/session/login`
   - `GET /api/session/:id/questions`
   - `POST /api/session/:id/submit`
   - `POST /api/session/:id/violation`
   - `GET /api/session/:id/status`

## Frontend (client)

1. Configure the API base URL if needed:

   ```bash
   cd client
   cp .env.example .env
   ```

2. Install and start Vite:

   ```bash
   npm install
   npm run dev
   ```

The UI enforces fullscreen mode, blocks copy/paste, traps keyboard shortcuts, and invokes the violation endpoint whenever the page loses focus or a restricted action occurs.

## Key features

- **Roster enforced login** – College IDs must exist in the `students` table and can only be used once; the server locks the ID even if a violation occurs.
- **Timed secure sessions** – Each attempt receives an expiry timestamp (`SESSION_DURATION_MINUTES` env) that is shown in the UI and auto-terminates when elapsed.
- **Randomized question order** – Questions come from MySQL, are shuffled uniquely per session, and the mapping is stored via `session_questions`.
- **Strict anti-cheat signals** – Any tab switch, fullscreen exit, shortcut, context menu, or other restricted action immediately hits `/violation` and closes the session.
- **Server-side scoring and audit trail** – Answers are evaluated against the master key, persisted in `responses`, while `sessions` + `violations` provide historical tracking suitable for Excel exports.

Refer to inline comments and service modules for additional implementation details. Update styles in `client/src/App.css` to adjust the pastel appearance. Trigger `npm run build` in each workspace when preparing for deployment.

