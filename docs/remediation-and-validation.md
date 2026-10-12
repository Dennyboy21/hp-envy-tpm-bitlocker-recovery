# Remediation and validation

> **Case-specific record — not generic instructions to clear a TPM.** Clearing a TPM can invalidate cryptographic material and can affect BitLocker, Windows Hello, locally stored certificates, passkeys, and other TPM-dependent services. Managed work devices require organizational approval.

## Preconditions completed

- [x] Important personal files copied to an external drive.
- [x] Backup spot-checked by opening files from external drive.
- [x] 48-digit BitLocker recovery password worked and was accessible independent of laptop.
- [x] Alternate Microsoft account authentication available.
- [x] External backup drive safely disconnected before firmware changes.
- [x] Power adapter connected.
- [x] No TPM reset attempted before these precautions.

## Controlled recovery sequence (historical record)

1. Recorded that Windows could not detect the TPM.
2. Checked current BIOS and ran HP hardware tests.
3. Verified the backup and independent recovery credentials.
4. Temporarily suspended BitLocker protection for the firmware operation; **encryption itself was not turned off**.
5. Chose the firmware's **Reset whole TPM** action at the familiar boot warning.
6. Returned to Windows and verified `Get-Tpm` values.
7. Verified `manage-bde -status C:` showed full encryption and **Protection On**.
8. Performed a normal restart and confirmed no recovery prompt, no TPM warning, and normal PIN sign-in.

## Verification evidence (sanitized)

### Before

```text
Get-Tpm
TpmPresent   : False
TpmReady     : False
TpmEnabled   : False
TpmActivated : False
```

### After

```text
Get-Tpm
TpmPresent   : True
TpmReady     : True
TpmEnabled   : True
TpmActivated : True
TpmOwned     : True
```

```text
manage-bde -status C:
Percentage Encrypted : 100.0%
Protection Status    : Protection On
Lock Status          : Unlocked
Key Protectors      : TPM, Numerical Password
```

### Functional tests

| Test | Result |
|:--|:--|
| BIOS TPM error on restart | Not observed |
| BitLocker recovery key prompt | Not observed |
| Windows Hello PIN sign-in | Successful |
| Windows recognizes TPM | Successful |
| BitLocker encryption/protection | Confirmed |

## Final assessment

**Operationally resolved** at the end of October 11, 2026 troubleshooting. The recovered TPM and successful normal restart show the configuration is functional. A single successful cycle does not demonstrate future reliability or reveal the original cause. If the symptoms recur, stop repeated TPM resets, preserve logs and contact HP support to investigate firmware/board-level stability.

## Recovery reminders

- Never commit a BitLocker recovery password or its exact key identifier to source control.
- Record any newly generated recovery credentials in a secure, supported account location.
- Avoid clearing TPM keys without considering dependent hardware-bound identities/certificates.
- Before BIOS or Secure Boot changes, follow current vendor and organizational guidance about BitLocker recovery preparedness.
