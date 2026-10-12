# Lessons learned

## Security and incident-response skills demonstrated

**Recoverability before remediation.** Encryption is a protection when a TPM trust state changes, but it is also an availability dependency. Before resetting a cryptographic trust anchor, verify backups and recovery material independently.

**Treat symptoms as evidence, not proof of a cause.** A TPM missing from Windows, a BitLocker recovery prompt, and a Windows Hello PIN prompt can be consequences of one trust-chain issue. They do not establish sabotage, a Windows update defect, or a failed motherboard on their own.

**Document test outcomes.** A power reset and current-BIOS check did not fix detection. HP diagnostics passed but did not conclusively test fTPM. The firmware TPM reset restored service, and the success criteria were checked with both tooling and a real restart.

**Maintain security posture after recovery.** Success is not merely returning to the desktop; BitLocker must be on, the TPM ready, and recovery credentials secure.

**Distinguish parallel incidents.** The battery/hibernate issue deserves its own test. Charge behavior coincided with the TPM incident, but no causal link was demonstrated. The first lid-close hibernation test displayed 100% charge before and the following morning; the earlier abrupt reading remains unexplained.

## Separate docked-display case: lessons

**Check both display output and input routing.** A display being disconnected from Windows' extended-desktop layout does not necessarily disable its physical touchscreen sensor. Circles on an external monitor may reflect unintended touch input rather than GPU rendering corruption.

**Prefer reversible, one-variable isolation.** Disabling the HID-compliant touch screen removed the circles; the user also reported no subsequent flicker. This narrowed the diagnosis without purchasing a new dock or replacing displays. A contribution from USB-C cable movement was not independently excluded.

**Respect distinct lid-power settings.** The user wanted hibernation on battery but continued operation when plugged in and the lid was fully closed. Those power policies can coexist. Ensure ventilation for any closed-lid docked arrangement.

**Avoid overclaiming.** Two symptoms disappearing together is evidence, not proof of an internal hardware defect or an exact mechanism. Capture subsequent recurrence data before declaring permanent resolution.

## Portfolio/recruiter summary

> Investigated and resolved a Windows 11 TPM initialization failure affecting BitLocker startup and Windows Hello authentication. Used PowerShell, Windows event logs, firmware diagnostics, and controlled recovery procedures; verified data backups and recovery access before TPM reinitialization. Confirmed full BitLocker protection and successful startup afterward. Separately analyzed Modern Standby and battery power reports, documenting unresolved findings and an initial hibernation test showing no displayed overnight charge loss. In a second endpoint case, isolated cursor circles and multi-monitor flickering to suspected unintended touchscreen input through a reversible Device Manager test, restoring the reported three-monitor closed-lid workflow.

## Possible extensions

- [x] Document closed-lid docking and suspected unintended touchscreen-input problem as separate case study.
- [ ] Check whether the docked workstation remains stable over multiple work sessions.

- [x] Log initial October 11–12 hibernation result (100% to 100% displayed).
- [ ] Compare 3–5 normal sleep vs. hibernate sessions, recording power state and discharge.
- [ ] If symptoms recur, preserve timestamped System event IDs and firmware revision for vendor escalation.
- [ ] Add manually redacted, approved screenshots **only after** inspecting them for personal and recovery information.
- [ ] Consider a follow-up issue documenting automated, read-only diagnostics improvements.
