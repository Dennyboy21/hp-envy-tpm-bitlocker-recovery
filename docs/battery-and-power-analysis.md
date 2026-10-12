# Battery and power-state investigation

This was a **separate** investigation triggered by overnight battery depletion and an abnormal startup during the TPM incident. Co-occurrence is not proof of causation.

## Battery condition

| Metric | Report value |
|:--|--:|
| Design capacity | 51,000 mWh |
| Full-charge capacity | 47,260 mWh |
| Estimated retained capacity | 92.7% |
| Estimated capacity reduction | 7.3% |
| Battery cycle count | Not reported |

**Interpretation:** Moderate capacity wear is not, by itself, enough to account for abrupt power loss. A battery-health percentage does not rule out inaccurate fuel gauging or transient power faults.

## Relevant October 10–11 power-state evidence

| Local time | Reported state or milestone | Indicated charge |
|:--|:--|:--|
| Oct 10, 12:33 PM | Connected/Modern Standby | ~100% |
| Oct 10, 4:47 PM | Active on battery | ~100% |
| Oct 10, 8:57 PM | Enters Connected/Modern Standby | ~25% |
| Oct 10, 9:03 PM | Suspended | ~24% |
| Oct 11, 12:57 PM | Hibernation after sleep timeout | ~15% |
| Oct 11, ~1:44 PM | Wake/abnormal power event | Abrupt reading discrepancy |
| Oct 11, 1:51 PM | Active, on AC | ~9% |

**Important:** The 4:47–8:57 PM discharge happened while recorded as **Active**. The report does not show when the physical lid was closed, so that loss should not be labeled unexplained sleep drain. The overnight standby period was much lower draw. The abnormal charge reading near wake deserves investigation if it repeats.

SleepStudy showed high low-power residency overnight (roughly 99.8%) and low average power use (roughly 0.27 W). These observations suggest standby power management was mostly working; they do **not** explain the abrupt startup reading or prove a battery hardware defect.

## Mitigation selected

Changed the **On battery → When I close the lid** setting from **Sleep** to **Hibernate**. The **Plugged in** behavior can remain a personal preference.

Expected benefit: avoid prolonged Modern Standby when the laptop is closed and unattended. Hibernation writes session state to storage and powers down much more completely than sleep.

## Overnight follow-up (initial test complete)

- Night: October 11–12, 2026.
- Battery at test start: **100%** (user confirmed).
- Lid-close policy on battery: **Hibernate**.
- Morning battery percentage: **100%** (reported October 12).
- Wake/startup warnings: **Not reported for this test**.
- Login or BitLocker recovery prompt: **Not specifically reported**.
- Actual hibernate start/wake times: **Not recorded; hibernation was configured but not independently confirmed via new event logs**.

**Outcome:** The Windows-reported charge remained at 100% overnight (zero displayed percentage-point loss). This supports the lid-close hibernation change as effective for battery retention in this initial test, but does not prove the abrupt prior battery indication or TPM incident shared the same cause. Additional nights can establish consistency. The matching entry is recorded in [`../data/overnight-hibernate-test.csv`](../data/overnight-hibernate-test.csv).

## If the anomaly repeats

1. Record indicated battery percent before closing and immediately after reopening.
2. Check the active lid-close plan (`powercfg.cpl`) and supported states (`powercfg /a`).
3. Generate fresh local battery/SleepStudy reports; keep raw reports private.
4. Correlate events with reported sleep/hibernate time rather than assuming all discharge happened in sleep.
5. Consider vendor battery/power diagnostics if sudden shutdowns repeat at nontrivial indicated charge.
