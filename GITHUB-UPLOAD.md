# Publishing this folder to GitHub

## Simplest method (no Git command line required)

1. Download and extract the project ZIP to a working folder on your PC.
2. Sign in at https://github.com/new and create a repository named `hp-envy-tpm-bitlocker-recovery`. Do not initialize it with README, license or `.gitignore` because this project already contains them.
3. Open the new repository and choose **uploading an existing file**.
4. Drag the **contents of the extracted folder**, keeping the directory structure. Some browser drag-and-drop flows do not preserve empty directories; none are required here.
5. Review the changed files and click **Commit changes**.
6. Confirm README renders correctly and that no raw reports or personal files were included.

## Using Git instead

From PowerShell in the extracted project directory:

```powershell
git init
git add .
git status
git diff --cached --stat
git commit -m "Document TPM and BitLocker recovery case study"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/hp-envy-tpm-bitlocker-recovery.git
git push -u origin main
```

Create the empty GitHub repo first. Replace `YOUR_USERNAME` with your username. Authentication follows your Git installation's normal sign-in flow; don't paste access tokens into this repository.

Read `PUBLICATION-CHECKLIST.md` before making the repository public.
