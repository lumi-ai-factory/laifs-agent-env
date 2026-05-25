# LUMI AI Factory Agent Environment

This repository contains files for running the [OpenCode coding agent](https://opencode.ai/) on
LUMI in a way that aims to minimize security risks and maintain awareness of the computing
environment. For general instructions about running AI agents on LUMI, please see the
[LUMI AI agent guide](https://docs.lumi-supercomputer.eu/development/ai-tools/ai-agent-guide/).

## Contents

- An Apptainer definition file for building a container. Running the agent inside a container
  allows the user to very effectively limit its access to files, as
  [only a few directories are mounted by default](https://apptainer.org/docs/user/main/bind_paths_and_mounts.html).
- An `AGENTS.md` file, which contains basic instructions for the agent about working on LUMI.
- An `opencode.json` config file for making the `AGENTS.md` file and the
  [LUMI AIF MCP server](https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure/#mcp-server)
  discoverable to the agent.

## Usage

```bash
# Load environment module
module load Local-LAIF opencode

# Start agent
opencode
```
