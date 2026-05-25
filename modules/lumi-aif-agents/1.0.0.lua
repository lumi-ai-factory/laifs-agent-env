-- LUMI AI Factory Agent Environment module

help([[
This is an experimental module for running a containerized OpenCode coding
agent on LUMI. The default endpoint is OpenCode Zen, which is hosted by the
OpenCode team. OpenCode is not in any way affiliated with LUMI or LUMI AI
Factory.

The current working directory is mounted by default, including its
subdirectories. However, e.g., `/scratch` and `/project` are not explicitly
mounted, so if your current working directory is not under one of them, you
need to mount them yourself:

```
export SINGULARITY_BIND=$SINGULARITY_BIND,/path/to/project/dir
opencode /path/to/project/dir
```
]])

local bindPaths = {
    -- Storage areas like `/scratch` are deliberately left unmounted
    -- to provide more control over file access.
    -- The current working directory is mounted by default,
    -- which should be enough for a coding agent.
    --
    -- Software installed by LUST and local organizations
    "/appl",
    -- Slurm configuration
    "/etc/slurm",
    -- Frequently used Slurm commands
    "/usr/bin/sacct", "/usr/bin/sbatch", "/usr/bin/scancel",
    "/usr/bin/sinfo", "/usr/bin/squeue", "/usr/bin/srun",
    -- Libraries required for using Slurm
    "/usr/lib64/libmunge.so.2", "/usr/lib64/slurm",
    -- Variable data dirs required for using Slurm
    "/var/run/munge", "/var/spool/slurmd",
}
setenv("SINGULARITY_BIND", table.concat(bindPaths, ","))

-- Add `opencode` command to `PATH`
prepend_path("PATH", "/appl/local/laifs/agents/bin")
