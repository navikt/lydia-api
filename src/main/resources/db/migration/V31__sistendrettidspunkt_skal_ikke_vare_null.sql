update virksomhet set sistendrettidspunkt = opprettettidspunkt where sistendrettidspunkt is null;
alter table virksomhet alter column sistendrettidspunkt set not null;
alter table virksomhet alter column sistendrettidspunkt set default now();