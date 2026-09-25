-- Nordic Cup 2027 check-in desk: database setup.
-- Paste this whole file into Supabase -> SQL Editor -> New query, and click Run.

create table if not exists public.settings (
  id int primary key default 1,
  name text not null default 'Nordic Cup 2027',
  org text default 'YOUacademy',
  team_fee numeric not null default 3850,
  player_fee numeric not null default 80
);

create table if not exists public.teams (
  id text primary key,
  name text not null,
  age text default '',
  leader text default '',
  phone text default '',
  players jsonb not null default '[]'::jsonb,   -- [{id, name, year, late}]  late = added at the desk
  payments jsonb not null default '[]'::jsonb,  -- [{amount, method, note, at}]
  created_at bigint
);

-- Only logged-in volunteers can read or change anything.
alter table public.settings enable row level security;
alter table public.teams enable row level security;

drop policy if exists "volunteers read settings" on public.settings;
drop policy if exists "volunteers write settings" on public.settings;
drop policy if exists "volunteers read teams" on public.teams;
drop policy if exists "volunteers write teams" on public.teams;
create policy "volunteers read settings"  on public.settings for select to authenticated using (true);
create policy "volunteers write settings" on public.settings for all    to authenticated using (true) with check (true);
create policy "volunteers read teams"     on public.teams    for select to authenticated using (true);
create policy "volunteers write teams"    on public.teams    for all    to authenticated using (true) with check (true);

-- Live updates between volunteers' screens.
alter publication supabase_realtime add table public.settings, public.teams;

-- Starting data: fees and three example teams (delete them in the app when you're ready).
insert into public.settings (id, name, org, team_fee, player_fee)
values (1, 'Nordic Cup 2027', 'YOUacademy', 3850, 80)
on conflict (id) do nothing;

insert into public.teams (id, name, age, leader, phone, players, payments, created_at) values
  ('yfc2014', 'Youth FC 2014', 'P2014', '', '', '[{"id": "2014-1", "name": "Elias Berg", "year": "2014", "late": false}, {"id": "2014-2", "name": "Noah Lind", "year": "2014", "late": false}, {"id": "2014-3", "name": "Liam Ek", "year": "2014", "late": false}, {"id": "2014-4", "name": "Hugo Sund", "year": "2014", "late": false}, {"id": "2014-5", "name": "Adam Nord", "year": "2014", "late": false}, {"id": "2014-6", "name": "Leo Falk", "year": "2014", "late": false}, {"id": "2014-7", "name": "Oscar Dahl", "year": "2014", "late": false}, {"id": "2014-8", "name": "Lucas Ström", "year": "2014", "late": false}, {"id": "2014-9", "name": "Axel Wik", "year": "2014", "late": false}, {"id": "2014-10", "name": "Theo Borg", "year": "2014", "late": false}, {"id": "2014-11", "name": "Ali Hassan", "year": "2014", "late": false}, {"id": "2014-12", "name": "Sam Kvist", "year": "2014", "late": false}]'::jsonb, '[{"amount": 3850, "method": "Bank transfer", "note": "Team fee", "at": ""}, {"amount": 960, "method": "Swish", "note": "Player fees, 12 players", "at": ""}]'::jsonb, 1),
  ('yfc2015', 'Youth FC 2015', 'P2015', '', '', '[{"id": "2015-1", "name": "Isak Holm", "year": "2015", "late": false}, {"id": "2015-2", "name": "William Ek", "year": "2015", "late": false}, {"id": "2015-3", "name": "Omar Said", "year": "2015", "late": false}, {"id": "2015-4", "name": "Melvin Ås", "year": "2015", "late": false}, {"id": "2015-5", "name": "Vincent Lund", "year": "2015", "late": false}, {"id": "2015-6", "name": "Charlie Berg", "year": "2015", "late": false}, {"id": "2015-7", "name": "Alfred Sjö", "year": "2015", "late": false}, {"id": "2015-8", "name": "Nils Rask", "year": "2015", "late": false}, {"id": "2015-9", "name": "Filip Moen", "year": "2015", "late": false}, {"id": "2015-10", "name": "Loke Dahl", "year": "2015", "late": false}, {"id": "2015-11", "name": "Elton Blom", "year": "2015", "late": false}, {"id": "2015-12", "name": "Arvid Hed", "year": "2015", "late": false}]'::jsonb, '[{"amount": 3850, "method": "Bank transfer", "note": "Team fee", "at": ""}, {"amount": 480, "method": "Swish", "note": "Player fees, 6 players", "at": ""}]'::jsonb, 2),
  ('yfc2016', 'Youth FC 2016', 'P2016', '', '', '[{"id": "2016-1", "name": "Jack Lind", "year": "2016", "late": false}, {"id": "2016-2", "name": "Viggo Nord", "year": "2016", "late": false}, {"id": "2016-3", "name": "Milo Falk", "year": "2016", "late": false}, {"id": "2016-4", "name": "Otto Borg", "year": "2016", "late": false}, {"id": "2016-5", "name": "Sixten Ek", "year": "2016", "late": false}, {"id": "2016-6", "name": "Frans Wik", "year": "2016", "late": false}, {"id": "2016-7", "name": "Ludvig Sund", "year": "2016", "late": false}, {"id": "2016-8", "name": "Adrian Kvist", "year": "2016", "late": false}, {"id": "2016-9", "name": "Malte Rosén", "year": "2016", "late": false}, {"id": "2016-10", "name": "Harry Björk", "year": "2016", "late": false}, {"id": "2016-11", "name": "Yusuf Ali", "year": "2016", "late": false}, {"id": "2016-12", "name": "Kevin Strand", "year": "2016", "late": false}]'::jsonb, '[{"amount": 3850, "method": "Bank transfer", "note": "Team fee", "at": ""}]'::jsonb, 3)
on conflict (id) do nothing;
