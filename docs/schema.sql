-- ============================================================
-- She Starts Over — Tools Site Database Schema
-- v1.0 — 2026-08-12
-- Paste this entire file into Supabase SQL Editor and click Run.
-- ============================================================

-- ------------------------------------------------------------
-- 1. MEMBERS
-- ------------------------------------------------------------

create table members (
  id                    uuid primary key default gen_random_uuid(),
  name                  text not null,
  email                 text unique not null,
  linkedin_url          text,
  photo_url             text,
  business_name         text,
  business_description  text,
  what_they_do          text,
  who_they_help         text,
  location              text,
  timezone              text,
  joined_date           date,
  cohort                text check (cohort in ('founding', 'regular')),
  status                text check (status in ('active', 'alumni', 'churned', 'pending')) default 'pending',
  founding_rate_expires date,           -- null for regular members
  current_challenge     text,
  what_they_offer       text,
  what_they_seek        text,
  application_answers   jsonb,          -- raw Tally answers, stored as-is
  created_at            timestamptz default now(),
  updated_at            timestamptz default now()
);

-- ------------------------------------------------------------
-- 2. MEMBER NOTES  (append-only — never update or delete rows)
-- ------------------------------------------------------------

create table member_notes (
  id          uuid primary key default gen_random_uuid(),
  member_id   uuid not null references members(id) on delete cascade,
  note_text   text not null,
  note_type   text check (note_type in (
                'general', '1on1', 'observation', 'introduction', 'testimonial', 'risk'
              )) default 'general',
  created_at  timestamptz default now()
);

-- ------------------------------------------------------------
-- 3. ONBOARDING STEPS
-- ------------------------------------------------------------

create table onboarding_steps (
  id           uuid primary key default gen_random_uuid(),
  member_id    uuid not null references members(id) on delete cascade,
  step_name    text not null,
  step_order   int  not null,
  completed    boolean default false,
  completed_at timestamptz,
  created_at   timestamptz default now()
);

-- ------------------------------------------------------------
-- 4. OFFBOARDING STEPS
-- ------------------------------------------------------------

create table offboarding_steps (
  id           uuid primary key default gen_random_uuid(),
  member_id    uuid not null references members(id) on delete cascade,
  step_name    text not null,
  step_order   int  not null,
  completed    boolean default false,
  completed_at timestamptz,
  created_at   timestamptz default now()
);

-- ------------------------------------------------------------
-- 5. EVENTS
-- ------------------------------------------------------------

create table events (
  id            uuid primary key default gen_random_uuid(),
  name          text not null,
  event_type    text check (event_type in ('she_connects', 'brunch', 'weekly_session', 'other')),
  event_date    date,
  capacity      int,
  ticket_price  numeric(10,2),
  notes         text,
  created_at    timestamptz default now()
);

-- ------------------------------------------------------------
-- 6. EVENT ATTENDANCE
-- ------------------------------------------------------------

create table event_attendance (
  id          uuid primary key default gen_random_uuid(),
  member_id   uuid not null references members(id) on delete cascade,
  event_id    uuid not null references events(id) on delete cascade,
  attended    boolean default false,
  notes       text,
  created_at  timestamptz default now(),
  unique (member_id, event_id)
);

-- ------------------------------------------------------------
-- 7. MEMBER TAGS
-- ------------------------------------------------------------

create table member_tags (
  id          uuid primary key default gen_random_uuid(),
  member_id   uuid not null references members(id) on delete cascade,
  tag         text not null,
  created_at  timestamptz default now(),
  unique (member_id, tag)
);

-- ============================================================
-- INDEXES
-- ============================================================

create index idx_members_status      on members (status);
create index idx_members_cohort      on members (cohort);
create index idx_members_joined_date on members (joined_date);

create index idx_member_notes_member_id  on member_notes (member_id);
create index idx_member_notes_created_at on member_notes (created_at desc);
create index idx_member_notes_type       on member_notes (note_type);

create index idx_onboarding_member_id  on onboarding_steps (member_id);
create index idx_offboarding_member_id on offboarding_steps (member_id);

create index idx_event_attendance_member  on event_attendance (member_id);
create index idx_event_attendance_event   on event_attendance (event_id);
create index idx_event_attendance_attended on event_attendance (attended);

create index idx_member_tags_member_id on member_tags (member_id);
create index idx_events_date           on events (event_date desc);

-- ============================================================
-- AUTO-UPDATE updated_at ON MEMBERS
-- ============================================================

create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger members_updated_at
  before update on members
  for each row execute function update_updated_at();

-- ============================================================
-- ROW LEVEL SECURITY
-- By default Supabase enables RLS. For this private admin tool
-- we disable it — the anon key is never exposed publicly
-- (the site sits behind a password gate and later Cloudflare Access).
-- Re-enable and add policies when multi-user access is needed.
-- ============================================================

alter table members          disable row level security;
alter table member_notes     disable row level security;
alter table onboarding_steps disable row level security;
alter table offboarding_steps disable row level security;
alter table events           disable row level security;
alter table event_attendance disable row level security;
alter table member_tags      disable row level security;

-- ============================================================
-- SEED DATA — default onboarding + offboarding step templates
-- Used by new-member.html when auto-generating steps for a new member.
-- These are reference labels only — the app inserts them per-member,
-- not from this table directly. Stored here as documentation.
-- ============================================================

-- Onboarding steps (in order):
-- 1. Joined Circle
-- 2. Payment method added
-- 3. Circle profile completed
-- 4. Introduced herself in member lounge
-- 5. Attended Welcome Ceremony / 1:1 with Urte
-- 6. Attended first community event
-- 7. Connected with at least one other member

-- Offboarding steps (in order):
-- 1. Cancellation received
-- 2. Confirmation email sent
-- 3. End date calculated
-- 4. Exit 1:1 invited
-- 5. Exit 1:1 completed
-- 6. Feedback recorded in notes
-- 7. Circle access removed
-- 8. Alumni offer made
-- 9. Database status updated to churned/alumni

-- ============================================================
-- VERIFICATION QUERY — run after the above to confirm all tables exist
-- ============================================================

select table_name
from information_schema.tables
where table_schema = 'public'
  and table_name in (
    'members', 'member_notes', 'onboarding_steps',
    'offboarding_steps', 'events', 'event_attendance', 'member_tags'
  )
order by table_name;
