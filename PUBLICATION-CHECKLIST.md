# Before publishing this repository publicly

This case uses a personal computer. The source troubleshooting files were **not** included, because Windows HTML reports and screenshots can contain computer names, device serial numbers, user paths, installed app names and other potentially sensitive details.

- [ ] Confirm the archive contains only the intended Markdown, CSV template, PowerShell script, license, and `.gitignore`.
- [ ] **Never upload** your 48-digit BitLocker recovery password, a screenshot of it, TPM ownership secrets, credentials, SSH private keys, or Windows Hello recovery details.
- [ ] Keep exact recovery-key identifiers, serial numbers, account IDs, hostname and personal folder paths private.
- [ ] Review any screenshots for username, email address, serial, opened folders, browser tabs, unrelated content and key IDs before adding.
- [ ] Do not add unredacted dock setup photos, employer workstation/network details, monitor EDIDs, internal asset tags, or DisplayLink device logs.
- [ ] Do not commit `battery-report.html`, `sleepstudy.html`, event `.evtx` logs or unredacted `Get-WinEvent` message bodies.
- [ ] Do not include any employer-provided files, system configurations, site security details or operational information.
- [ ] Verify that a newly created repository is personal, authorized and scoped to this case study.
- [ ] Review `git status` and `git diff --cached --stat` before committing.

**The packaged archive intentionally does not contain raw reports or screenshots.** Files created by the diagnostic script go to `local-diagnostics/`, which is ignored by Git.
