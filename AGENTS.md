# AGENTS.md

Runtime context for a coding agent running on the **LUMI supercomputer** (EuroHPC, hosted at CSC, Finland).

## System

- **Architecture**: HPE Cray EX. AMD EPYC CPUs (`LUMI-C`), AMD MI250X GPUs (`LUMI-G`), large-memory nodes (`LUMI-D`), object storage (`LUMI-O`).
- **OS**: SUSE Linux (HPE Cray OS). You are on a **login node** by default — do not run heavy workloads here. Submit to compute nodes via Slurm.
- **GPU runtime**: ROCm (not CUDA). PyTorch/TensorFlow builds must be ROCm-compatible.
- **Network**: HPE Slingshot 11. Use the host MPI stack (`cray-mpich`) for performance.

## Filesystems

| Path | Purpose | Quota | Notes |
|---|---|---|---|
| `/users/<user>` | Home, configs | 20 GB / 100k files | No backups. |
| `/project/<project>` | Shared project files | 50 GB / 100k files | Lustre (LUMI-P). |
| `/scratch/<project>` | Job I/O, checkpoints | 50 TB / 2M files | Default work area. May be auto-cleaned. |
| `/flash/<project>` | High-performance scratch | 2 TB / 1M files | NVMe (LUMI-F). 3× billing. |
| `/tmp` (login) | Local SSD | — | Per-node, ephemeral. Good for compilation. |
| `/tmp` (compute) | In-memory | — | Counts against job memory. |

**No backups anywhere.** Lustre dislikes many small files — avoid raw `pip`/`conda` installs on `/project` or `/scratch`; use containers instead. Check usage with `lumi-workspaces`.

## Software

- **Modules**: Lmod. Use `module spider <name>` to search, `module load <name>` to load. The default stack is `CrayEnv`; richer stacks load via e.g. `module load LUMI/24.03`.
- **User installs**: prefer **EasyBuild** in the LUMI stack (`module load EasyBuild-user`, then `eb <recipe>.eb -r`). Install to `/project/<project>`, not `/users`.
- **Containers**: **Singularity / SingularityCE**. The LUMI AI Factory provides ready-made ROCm + PyTorch + MPICH images (`lumi-multitorch-*`). Bind `/scratch/<project>` and `/project/<project>` explicitly — they are symlinks and `-B /scratch` alone won't work.

## Running jobs

Use **Slurm**. Always pass `--account=<project>` and `--partition=<name>`.

Common partitions: `standard` / `standard-g` (full nodes, 2-day max), `small` / `small-g` (sub-node, 3-day max), `debug` / `dev-g` (30 min, for testing), `largemem` (LUMI-D).

Quick interactive test: `srun --account=<project> --partition=dev-g --time=00:10:00 --gpus=1 --pty bash`.

## Getting more information

A documentation MCP server is available: **`LUMI AIF Server:retrieve_docs`** (params: `query`, optional `k`). Use it before guessing at module names, EasyBuild recipes, partition limits, Slurm flags, or container workflows — your training data is likely outdated. Searches the LUMI User Guide and LUMI AI Guide.

## Conventions

- Don't run builds, training, or data processing on login nodes — submit a job or use `srun` interactively.
- Don't `pip install` into home/project without a container; it will create thousands of small files and degrade the filesystem.
- Always specify `--account` — jobs without it will be rejected.
- Prefer `/scratch` for job working directories; copy results out before the retention policy collects them.
