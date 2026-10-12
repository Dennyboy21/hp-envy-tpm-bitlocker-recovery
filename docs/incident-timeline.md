# Incident timeline

*Dates/times are local to the laptop. Times are from the diagnostic reports where available; other milestones were observed during the troubleshooting session and are not assigned invented timestamps.*

| Date/time | Event | Evidence / implication |
|:--|:--|:--|
| Oct 10, 12:33–4:47 PM | Modern Standby reported with battery charge essentially unchanged | Battery and SleepStudy reports |
| Oct 10, ~4:47–8:57 PM | System active on battery; charge decreased from ~100% to ~25% | Do **not** assume the lid was closed throughout this period |
| Oct 10, 9:02–9:03 PM | Entered a suspended/Modern Standby state at ~24% | Not a fully powered-off shutdown |
| Oct 11, ~12:57–1:44 PM | SleepStudy recorded hibernation | ~15% indicated at hibernate entry |
| Oct 11, wake/startup | Unexpected power/battery reading event; Windows later booted | Root cause of abrupt battery reading not established |
| Oct 11, boot | Firmware displayed a TPM-data warning, with choices to reset TPM or continue | User initially chose to continue without reset |
| Oct 11, boot | BitLocker recovery key requested | Recovery key worked; OS files accessible |
| Oct 11, Windows | `tpm.msc` reported no compatible TPM; `Get-Tpm` indicated not present/ready | Windows had no usable TPM at this stage |
| Oct 11, Windows | Windows Hello required alternative login and PIN reconfiguration on one boot | TPM-dependent credentials impacted |
| Oct 11, firmware | BIOS F.22 verified; no TPM toggle visible in tested tabs | Absence of toggle does not mean no TPM hardware exists |
| Oct 11, diagnostics | Full power reset did not restore TPM detection | Repeated `Get-Tpm` still false |
| Oct 11, HP tools | BIOS check indicated up-to-date; hardware tests all passed | Does not specifically prove fTPM hardware healthy |
| Oct 11, event log | Secure Boot/SBAT-related events 1796, 1032 and 1808 observed | Temporal correlation; causal link **not** established |
| Oct 11, precautions | External personal-file backup verified; recovery key independently accessible | Controlled-change prerequisites completed |
| Oct 11, recovery | BitLocker was temporarily suspended; firmware TPM reset selected | Device-bound secrets may be invalidated by this operation |
| Oct 11, validation | `Get-Tpm` returned Present/Ready/Enabled/Activated/Owned `True` | fTPM successfully reinitialized |
| Oct 11, validation | BitLocker confirmed 100% encrypted and Protection On | Drive protection restored |
| Oct 11, validation | Normal restart without TPM warning or BitLocker recovery; Windows Hello PIN worked | Incident resolved at validation point |
| Oct 11, power plan | Lid close on battery changed from Sleep to Hibernate; charge at 100% | Initial follow-up: 100% displayed on Oct 12 (see battery report write-up) |

## Incident classification

**Service disruption / endpoint trust subsystem failure; not a confirmed intrusion or compromise.** The machine's trust state changed or was no longer readable; BitLocker correctly requested alternate recovery authorization. The repair outcome supports a TPM initialization/data problem but does not identify the original trigger.

> **Separate issue:** A docked multi-monitor/touchscreen problem was investigated on October 12. It is documented in [`docking-touchscreen-case-study.md`](docking-touchscreen-case-study.md) and is **not classified as part of this TPM incident**.
