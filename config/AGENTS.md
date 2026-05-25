# LUMI Supercomputer Runtime Context

You are running on LUMI, an HPE Cray EX supercomputer consisting of several hardware partitions
targeting different use cases. The primary compute power in LUMI is found in the LUMI-G hardware
partition, which features GPU-accelerated nodes using AMD Instinct MI250X GPUs.

Expect that all tasks given to you and all questions asked of you exclusively concern LUMI.
Your primary source of information should be the LUMI AI Factory MCP server, which you are
configured to have access to.

## Containerized environment

You are running inside a Singularity container. While it is possible for the user to mount
additional host directories, expect to only have access to the directories that Singularity mounts
by default, like the current working directory and the user home directory. That being said, the
following are also mounted from the host system and therefore accessible to you:

- The `/appl` directory containing software that is installed by the LUMI User Support Team and
  local organizations in the LUMI consortium
- Files required for using the Slurm workload manager from inside the container

## Running processes

The nodes on LUMI are classified into login nodes and compute nodes. Expect to be on a login node
by default. Login nodes are shared by all LUMI users and are only intended for simple management
tasks, e.g.

- compiling software (but consider allocating a compute node for large build
  jobs)
- submitting and managing Slurm jobs
- moving data
- light pre- and postprocessing (a few cores / a few GB of memory)

All compute-heavy tasks must be submitted through the Slurm workload manager so that they are run
on compute nodes.

## Data storage

When working on LUMI, the working directory is typically under either the user home directory or a
project-specific directory, which is in turn located under one of the top-level directories of
`/project`, `/scratch` and `/flash`.

All of these directories, including the user home directory, are on Lustre file systems. User data
workflows should be adjusted to the performance characteristics of the Lustre file system. In
particular, having a large number of small files may put stress on the Lustre metadata servers and
may limit file system performance due to limited striping.

Users can check the memory and file usage quotas of their projects with the `lumi-workspaces` command.

## LUMI AI Factory MCP server

The LUMI AI Factory provides a public Model Context Protocol (MCP) server, which allows agents to
search a regularly-updated knowledge base of LUMI documentation. You have access to this MCP server,
use it to answer questions about LUMI with more accuracy and write code that takes into account
LUMI's particular system architecture and software environment.

