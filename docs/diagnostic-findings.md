# Diagnostic findings

## Layer 1 — Firmware and TPM

**Observed at failure:** HP firmware warned of an issue with TPM data. `tpm.msc` showed **Compatible TPM cannot be found**; `Get-Tpm` reported `TpmPresent=False`, `TpmReady=False`, `TpmEnabled=False`, `TpmActivated=False`. This is a failure to enumerate an operational TPM in Windows, not proof that a physical TPM chip is absent.

**Platform:** HP ENVY x360 15-ey0xxx; AMD Ryzen 7 5825U; firmware TPM implementation. Insyde BIOS F.22 (reported by HP as current during this investigation).

**Tests:** BIOS Security and Configuration menus did not expose an actionable TPM setting. Full power reset made no difference. HP hardware diagnostics passed, but that does not constitute a dedicated TPM integrity test.

**After firmware reset:** `Get-Tpm` showed Present, Ready, Enabled, Activated, and Owned as `True`; AMD identified as TPM manufacturer; Windows auto-provisioning enabled.

## Layer 2 — BitLocker

**Before:** Windows required the 48-digit BitLocker recovery password during boot. `manage-bde -status C:` confirmed the OS volume remained encrypted and could be unlocked using recovery information. BitLocker key protectors included TPM and a numerical recovery password; listing a TPM protector alone does **not** prove Windows can currently reach the TPM.

**Safety:** User-backed-up files and verified independent access to recovery credentials before potentially destructive TPM operations. Protection was temporarily suspended for the controlled change and confirmed **Protection On** afterward.

**After:** Volume remained 100% encrypted; OS started without a recovery request.

## Layer 3 — Windows Hello

One startup required account authentication and Windows Hello PIN setup. After restoration, an existing PIN worked following a normal restart. This is consistent with TPM-backed authentication material becoming inaccessible, but not enough to identify why it happened.

## Layer 4 — Secure Boot event log

| Event | Observed message class | Causation conclusion |
|:--|:--|:--|
| 1796 | Secure Boot SBAT update failure (`0x800700c1`) | Not proven to cause TPM failure |
| 1032 | SBAT update withheld due to compatibility with current BitLocker configuration | Protective deferral, not proof of damage |
| 1808 | Secure Boot certificate/boot-manager update status | Not itself evidence of TPM malfunction |

These events were seen around the incident window, including earlier entries. Secure Boot configuration, TPM initialization, and BitLocker protectors interact during measured boot, but **temporal proximity is not a demonstrated causal chain**.

## Diagnostic reasoning

| Hypothesis | Observations | Confidence |
|:--|:--|:--|
| Temporary TPM firmware/data initialization problem | Boot warning; Windows unable to detect TPM; firmware reset restored detection | **Supported as the proximate failure**, original cause unknown |
| BIOS version issue requiring an update | BIOS F.22, HP reports current | Not supported by available tests |
| Failed laptop battery caused TPM error | Battery anomaly occurred in same period | **Unproven** relationship |
| Permanent motherboard failure | HP tests passed; TPM recovered and rebooted | Not indicated by current post-fix results; recurrence would reopen investigation |
| Malicious tampering | No specific evidence | Do not infer a compromise |

## Why the order mattered

1. **Observe before change:** capture Windows TPM and encryption status.
2. **Differentiate symptoms from cause:** recovery key prompts are protective, not necessarily drive damage.
3. **Test reversible paths first:** power reset, BIOS check, diagnostics.
4. **Protect recoverability:** offline backup and independent recovery key.
5. **Take a controlled action:** firmware reset only after safeguards.
6. **Validate security state and user experience:** TPM state, encryption, startup and PIN behavior.
