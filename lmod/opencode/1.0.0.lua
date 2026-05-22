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
