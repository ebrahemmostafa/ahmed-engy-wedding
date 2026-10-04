-- Ahmed & Engy wedding — guest messages
-- Run once in Supabase: Dashboard → SQL Editor → New query → paste → Run.
-- Everything is namespaced "ahmed_engy_wedding_*" so it doesn't touch
-- anything else in the project.

-- 1. Table ------------------------------------------------------------------
create table if not exists public.ahmed_engy_wedding_responses (
  id         bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  site       text not null check (site in ('en', 'ar')),
  message    text not null check (char_length(btrim(message)) between 1 and 600)
);

-- 2. Access -----------------------------------------------------------------
-- Guests (anon key) may only ADD a message. There is no SELECT policy, so the
-- public key can never read, change or delete messages.
alter table public.ahmed_engy_wedding_responses enable row level security;

revoke all on public.ahmed_engy_wedding_responses from anon, authenticated;
grant insert (site, message) on public.ahmed_engy_wedding_responses to anon;

drop policy if exists "guests can send a message" on public.ahmed_engy_wedding_responses;
create policy "guests can send a message"
  on public.ahmed_engy_wedding_responses
  for insert to anon
  with check (true);

-- 3. Reading (responses page) ------------------------------------------------
-- The responses page calls this function with the passcode. The passcode is
-- checked here on the server, so it never appears in any web page's code.
create or replace function public.ahmed_engy_wedding_responses_list(passcode text)
returns setof public.ahmed_engy_wedding_responses
language plpgsql
security definer
set search_path = public
as $$
begin
  if passcode is distinct from '211126' then
    perform pg_sleep(1);  -- slow down guessing
    raise exception 'invalid passcode' using errcode = '28P01';
  end if;

  return query
    select * from public.ahmed_engy_wedding_responses
    order by created_at desc;
end;
$$;

revoke all on function public.ahmed_engy_wedding_responses_list(text) from public;
grant execute on function public.ahmed_engy_wedding_responses_list(text) to anon;
