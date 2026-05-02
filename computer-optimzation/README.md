# Gaming + AI Laptop Tune-up (Windows 11)

> A worked example from a [Cowork](https://www.anthropic.com/news/claude-for-chrome) session with Claude.
> The goal: take a Windows 11 laptop with a discrete NVIDIA GPU and tune it for both gaming **and** local AI / ML workloads — without breaking the virtualization features that Cowork itself relies on.

This walkthrough is intentionally generic. Specific hardware names, machine names, and personal identifiers from the original session have been stripped. The principles apply to any modern Intel/NVIDIA Windows 11 laptop (Legion, ROG, MSI Raider, Razer Blade, XPS, etc.).

---

## TL;DR

| Area | Change | Why |
|---|---|---|
| Power plan | Switch to Ultimate Performance | Removes thermal/clock throttling on AC power |
| Game DVR | Disable | Background recorder costs measurable FPS |
| Game Mode | Enable | Tells Windows to deprioritize background work during games |
| Multimedia scheduler | Bump GPU/CPU priority for the "Games" profile | Reduces latency, stabilizes 1% lows |
| Pagefile | Fixed 8 GB / 16 GB | Avoids on-the-fly resize stalls; helps large model loads |
| Pre-installed audio enhancers | Uninstall | Notorious source of stutter and audio glitches |
| Third-party AV | Uninstall | Defender + common sense is sufficient for most users |
| OEM gaming app | Discrete GPU mode + Performance profile | Skips iGPU hand-off latency |
| GPU driver | Manual install from vendor site | Vendor apps frequently fail silently |
| Memory Integrity (HVCI) | **Leave ON** | On 12th-gen Intel and newer, FPS cost is tiny vs. the security benefit |
| Hyper-V / VBS | **Keep enabled** | Required for Cowork, WSL2, Docker Desktop, Android emulators |

---

## What Cowork helped with

The whole pass took roughly an hour and ran through Cowork's computer-use tools — Claude could see the Settings app over screenshots, walk me through each toggle, and explain the trade-offs as we went. The interesting parts were not the tweaks themselves (those are well-documented online) but the **decision points**:

1. **"Should I disable Memory Integrity for more FPS?"** — Claude pulled up the Core Isolation page, explained the historical 5–15% gaming hit on older CPUs, then noted that on a 12th/13th-gen Intel chip the hardware-accelerated MBEC and HLAT paths bring that cost down to roughly 0–3%. We kept it on.
2. **"Can I disable Hyper-V for gaming?"** — No. Cowork itself runs on Hyper-V, as do WSL2 and Docker Desktop. The script and this guide both preserve VBS for that reason.
3. **"The vendor's GPU updater errors out — now what?"** — Skip the vendor app, download the driver from `nvidia.com/drivers`, run it, choose **Custom (Advanced) → Perform a clean installation**.
4. **"My OEM app shows two GPU modes. Which one?"** — For an external monitor or any AI workload that hits the GPU, force **Discrete** mode. Hybrid mode adds a hand-off hop that can cost frames and adds power draw.

---

## Step-by-step

### 1. Confirm baseline hardware
Open Settings → System → About. Verify:
- RAM is reported at the rated speed (e.g. DDR5-4800), in **dual-channel**. A single-stick laptop will silently halve memory bandwidth — a major hit on iGPU rendering and on AI workloads that thrash the CPU/GPU memory bus.
- The discrete GPU is detected.

If RAM is single-channel, the cheapest performance upgrade you'll ever make is buying a matched second SODIMM.

### 2. Power plan
Run as administrator:

```powershell
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg /list   # find the "Ultimate Performance" GUID
powercfg /setactive <that-guid>
```

Or use Settings → System → Power & battery → Power mode → Best performance. The Ultimate Performance scheme is more aggressive than the visible "Best performance" mode.

### 3. Game DVR + Game Mode
Settings → Gaming → Captures → turn off **Record what happened**.
Settings → Gaming → Game Mode → On.

These sound contradictory but they're not: Game Mode is a scheduler hint, Game DVR is the always-on background recorder.

### 4. Multimedia Class Scheduler tweaks
Registry: `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile`

| Value | Setting |
|---|---|
| `SystemResponsiveness` (DWORD) | `0` |
| `NetworkThrottlingIndex` (DWORD) | `0xffffffff` |

And under `...\Tasks\Games`:

| Value | Setting |
|---|---|
| `GPU Priority` (DWORD) | `8` |
| `Priority` (DWORD) | `6` |
| `Scheduling Category` (string) | `High` |
| `SFIO Priority` (string) | `High` |

The PowerShell script in this repo applies all of these.

### 5. Fixed pagefile
Settings → System → About → Advanced system settings → Performance Settings → Advanced → Virtual Memory → Change…

Uncheck "Automatically manage." Set Initial = 8192 MB, Maximum = 16384 MB on C:.

A fixed pagefile eliminates resize stalls and gives the OS predictable swap headroom — useful when a model briefly blows past available RAM.

### 6. Uninstall the usual suspects
- Audio "enhancement" suites (Nahimic, MaxxAudio, Sonic Studio, etc.) — known to introduce audio stutters and occasional bluescreens. Uninstall via Settings → Apps and reboot.
- Pre-installed third-party antivirus trials. Defender + SmartScreen is fine for most users; the third-party AVs tend to inject themselves into every game's process and add overhead.

### 7. OEM gaming app
Open your laptop's vendor app (Legion Space, Armoury Crate, MSI Center, etc.):
- GPU mode: **Discrete** (not Hybrid)
- Power profile: **Performance** (not Balanced or Quiet)

You may need to reboot for the GPU mode change to take effect.

### 8. GPU driver
If the vendor's updater errors out (very common — error codes like `-505413605` for NVIDIA App), grab the installer manually:

- NVIDIA: <https://www.nvidia.com/drivers>
- AMD: <https://www.amd.com/support>

Run it, choose **Custom (Advanced)**, tick **Perform a clean installation**.

### 9. Memory Integrity / HVCI
Settings → Privacy & security → Windows Security → Device security → Core isolation → Memory Integrity.

**Recommendation: leave it ON.** The performance cost on modern Intel chips (12th gen and newer) is small (~0–3% in most games), and turning it off opens the door to kernel-level malware. The original optimization session almost flipped this off, then chose to keep it on after weighing the actual numbers.

### 10. **Do not** disable Hyper-V / VBS
If you uninstall Hyper-V or set VBS to disabled, you lose:

- Cowork (it runs in a Hyper-V VM)
- WSL2
- Docker Desktop
- Android Studio's emulator
- Windows Sandbox

The PowerShell script verifies VBS is still active at the end of its run.

---

## What's in this repo

| File | What it does |
|---|---|
| `README.md` | This guide |
| `tuneup.ps1` | Idempotent PowerShell script that applies steps 2, 3, 4, and 5, then verifies VBS in step 10. Steps that require a UI or human judgment (driver install, app uninstalls, OEM app settings) are left manual on purpose. |

---

## Running the script

1. Right-click PowerShell → **Run as Administrator**.
2. Allow scripts for this session: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
3. `cd` to the folder containing `tuneup.ps1`.
4. `.\tuneup.ps1`
5. Reboot.

The script will not touch HVCI, will not disable Hyper-V, and will not uninstall anything. It only flips registry keys and the power plan, plus pins the pagefile. Everything it does can be reversed.

---

## Credits

Generated from a Cowork session with Claude. All hardware-specific identifiers and personal information have been removed. Use, fork, and adapt freely.

## License

Released under the [MIT License](./LICENSE). Use, fork, and adapt freely — no warranty.
