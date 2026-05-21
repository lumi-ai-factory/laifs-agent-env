# AGENTS.md — LUMI Supercomputer

This file gives a coding agent the essential context needed to operate on LUMI. For deeper
information on any topic, use the MCP documentation tool described at the bottom.

---

## System Overview

LUMI is a European pre-exascale HPE Cray EX supercomputer. Key hardware partitions:

| Partition | Hardware | Purpose |
|-----------|----------|---------|
| **LUMI-G** | 2978 nodes: 1× AMD EPYC "Trento" (64 cores) + 4× AMD MI250X GPUs (= 8 GCDs from
software's perspective) | Primary GPU compute |
| **LUMI-C** | 2048 nodes: 2× AMD EPYC 7763 "Milan" (128 cores), 256–1024 GiB RAM | CPU-only
compute |
| **LUMI-D** | 16 large-memory nodes, up to 4 TiB RAM; 8 nodes have 8× NVIDIA A40 GPUs | Data
analytics & visualization |

The dominant partition is **LUMI-G**. AMD MI250X uses the CDNA2 architecture — use **ROCm/HIP**,
not CUDA.

**Do not run heavy computations on login nodes.** Use the batch system or an interactive job.

---

## Job Scheduler: Slurm

| Command | Purpose |
|---------|---------|
| `sbatch job.sh` | Submit a batch job |
| `srun <cmd>` | Run a parallel step (use instead of `mpirun`) |
| `squeue` / `scancel <id>` | View / cancel jobs |
| `lumi-allocations` | Show projects and remaining billing units |

Every job must specify `--account=project_<id>` or it will be rejected.

### Partitions

| Partition | Max walltime | Hardware | Notes |
|-----------|-------------|----------|-------|
| `standard-g` | 2 days | LUMI-G | Full nodes, up to 1024 |
| `standard` | 2 days | LUMI-C | Full nodes, up to 512 |
| `small-g` | 3 days | LUMI-G | Sub-node, up to 4 nodes |
| `small` | 3 days | LUMI-C | Sub-node, up to 4 nodes |
| `dev-g` | 30 min–2 h | LUMI-G | GPU debugging |
| `debug` | 30 min | LUMI-C | CPU debugging |
| `largemem` | 1 day | LUMI-D | High-memory jobs |

Full-node partitions (`standard`, `standard-g`) bill for the entire node regardless of actual
usage.

### Minimal batch script

```bash
#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --partition=small-g
#SBATCH --nodes=1
#SBATCH --gpus-per-node=8
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=7
#SBATCH --time=01:00:00
#SBATCH --account=project_<id>

module load LUMI
srun ./my_application
```

---

## Storage

No storage on LUMI is backed up.

| Path | Purpose | Default quota |
|------|---------|---------------|
| `$HOME` | Personal config files | 20 GB |
| `/project/project_<id>` | Shared project files, compiled software | 50 GB |
| `/scratch/project_<id>` | **Main job I/O** — temporary data | 50 TB |
| `/flash/project_<id>` | High-performance I/O (3× billing rate) | 2 TB |

Check usage: `lumi-workspaces`

---

## Software & Modules

```bash
module load LUMI            # Load the software stack
module load partition/G     # Target GPU partition (or /C, /D)
module avail                # List available modules
module spider <name>        # Search for a module
```

### EasyBuild

To install additional software with EasyBuild:
```bash
export EBU_USER_PREFIX=/project/project_<id>/EasyBuild  # add to .bashrc
module load EasyBuild-user
eb <PackageName>.eb -r
```

### PyTorch

PyTorch is provided via Singularity containers from the LUMI AI Factory:

```bash
module purge
module use /appl/local/laifs/modules
module load lumi-aif-singularity-bindings

export SIF=/appl/local/laifs/containers/<container-dir>/<container>.sif

# Run a script inside the container
srun --account=project_<id> --partition=small-g --nodes=1 --gpus-per-task=1 \
    singularity run $SIF python my_script.py
    ```

    Container images are in `/appl/local/laifs/containers/`. The `lumi-multitorch-full-*` images
    are the recommended starting point for most PyTorch workloads. The
    `lumi-aif-singularity-bindings` module sets up the necessary filesystem and Slingshot network
    bindings automatically.

---

## Key Rules

- Use `srun` to launch parallel steps, not `mpirun` or `mpiexec`.
- Each MI250X appears as **2 GPUs** — a full LUMI-G node has 8 GCDs.
- Avoid creating large numbers of small files on shared filesystems; use HDF5 or similar.

---

## Getting More Information via MCP

This agent has access to an MCP tool (`retrieve_docs`) that queries the official LUMI user guide.
Use it for anything not covered above — GPU programming, containers, Python environments, MPI
configuration, billing, object storage (LUMI-O), specific software, etc.

Call it with a short descriptive query, e.g. `"ROCm HIP GPU programming LUMI-G"` or `"Singularity
container MPI job"`.
