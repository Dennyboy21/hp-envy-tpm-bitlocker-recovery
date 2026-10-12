# Updating an existing GitHub repository

This package is a **full replacement snapshot** of the original repository, not a separate project. It retains the TPM/BitLocker and battery case study and adds the second case study on closed-lid external displays and touchscreen input.

## If you have not published the first ZIP

Create the `hp-envy-tpm-bitlocker-recovery` repository and upload the **contents of this project's extracted folder**. Do not upload the ZIP itself as the case study source.

## If the earlier version is already on GitHub

The following files were added:

- `docs/docking-touchscreen-case-study.md`
- `data/docking-validation.csv`
- `.github/ISSUE_TEMPLATE/docking-follow-up.md`
- `UPDATE-EXISTING-REPO.md`

These existing files were updated:

- `README.md`
- `docs/lessons-learned.md`
- `docs/incident-timeline.md`
- `.github/ISSUE_TEMPLATE/overnight-test.md`
- `PUBLICATION-CHECKLIST.md`

**Git method (recommended):** clone the existing repo, copy the extracted folder's contents over the checkout (preserve `.git`), and in PowerShell run:

```powershell
git status
git diff -- README.md docs/ .github/ PUBLICATION-CHECKLIST.md
git add README.md docs/ data/docking-validation.csv .github/ISSUE_TEMPLATE/ PUBLICATION-CHECKLIST.md UPDATE-EXISTING-REPO.md
git diff --cached --stat
git commit -m "Document docked multi-monitor and touchscreen troubleshooting"
git push
```

Only run `git push` after reviewing the staged changes and confirming no personal data or raw diagnostic reports appear in `git status`. If `git status` shows untracked private documents, **do not** add them; use the explicit `git add` files above rather than `git add .`.

**Browser-only method:** Use GitHub's file editor to update existing Markdown files and **Add file → Upload files** for the new documents in their respective folders. Check directory paths carefully; GitHub's web interface may be easier when updating one file at a time.

Do not delete old history or create a second repository unless you want two separate portfolios. Do not upload source screenshots, `battery-report.html`, `sleepstudy.html`, BitLocker keys or any employer-controlled information.
