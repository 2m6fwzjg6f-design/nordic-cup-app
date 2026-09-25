# Nordic Cup 2027 – Check-in desk

**Live app:** https://2m6fwzjg6f-design.github.io/nordic-cup-app/

Payment desk for **Nordic Cup 2027, powered by YOUacademy**.
It shows which teams have paid the team fee (3 850 kr) and the player fees (80 kr per player), and how much is left to collect.

- Works in any browser on a phone, tablet or computer.
- Several volunteers can use it at the same time. Changes show up on every screen straight away.
- Only volunteers you invite can log in, so players' names and payments are not public.

The whole app is plain HTML, CSS and JavaScript with no build step:

| File | What it is |
|---|---|
| `index.html` | The app |
| `config.js` | Your Supabase address and public key |
| `badge.png` | Nordic Cup logo (header and app icon) |
| `supabase/schema.sql` | Creates the database tables, access rules and example teams |

If you open `index.html` before filling in `config.js`, it runs in **demo mode** with example teams and doesn't save anything.

---

## Put it online (about 30 minutes, free)

### 1. Create the database (Supabase)

1. Create a free account at <https://supabase.com> and click **New project**. Pick a region in Europe (e.g. Stockholm or Frankfurt).
2. Open **SQL Editor → New query**, paste the whole contents of `supabase/schema.sql`, and click **Run**.
3. Go to **Authentication → Sign In / Providers** and turn **off** "Allow new users to sign up". Now only people you invite can log in.
4. Go to **Project Settings → API** and copy the **Project URL** and the **anon public** key.
5. Paste both into `config.js`.

### 2. Put the code on GitHub

1. Create a free account at <https://github.com> and click **New repository**. Name it `nordic-cup-app`.
2. Click **uploading an existing file** and drag in all the files and the `supabase` folder. Click **Commit changes**.
3. In the repository go to **Settings → Pages**. Under "Branch" choose `main` and `/ (root)`, and click **Save**.
4. After a minute the app is live at
   `https://<your-github-name>.github.io/nordic-cup-app/`

### 3. Connect the two

1. In Supabase go to **Authentication → URL Configuration**.
2. Set **Site URL** to your GitHub Pages address from step 2.4, and add the same address under **Redirect URLs**.

### 4. Invite volunteers

In Supabase go to **Authentication → Users → Invite user** and enter each volunteer's email.
They open the app link, type their email, and tap the login link they receive. No password needed.

On a phone: open the link in Safari or Chrome and choose **Add to Home Screen** to get an app icon.

---

## Helping develop it

- Invite friends to the GitHub repository under **Settings → Collaborators**. They can edit files directly on GitHub or clone the repo.
- Every change pushed to `main` goes live on GitHub Pages within a minute or two.
- To test locally, open `index.html` in a browser (demo mode) or run `python3 -m http.server` in the folder and open <http://localhost:8000>.

### How the fees are calculated

- Total for a team = team fee + player fee × number of players on its list.
- Payments count toward the team fee first, then player fees.
- A player added at the desk is marked `late: true` ("Added at desk") and is charged the player fee like everyone else.
- Fees and the tournament name can be changed in the app under **Edit fees**.

### Data

Two tables in Supabase:

- `settings` – one row (`id = 1`): tournament name, organiser, team fee, player fee.
- `teams` – one row per team. `players` and `payments` are JSON lists.

Ideas for next steps: team self-registration form, export to Excel, Swish QR codes per team, receipts by email.
