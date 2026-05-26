# LUMI AI Factory Agent Environment

This repository contains files for running AI coding agents on LUMI inside a containerized environment.
For guidance on using the environment, please see the
[agent environment documentation](https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure/)
in the LUMI user guide. For general instructions about running AI agents on LUMI, see the
[LUMI AI agent guide](https://docs.lumi-supercomputer.eu/development/ai-tools/ai-agent-guide/).

## Contents

- An Apptainer definition file for installing [OpenCode](https://opencode.ai/docs) inside a container.
- A module file and wrapper script for defining which directories to mount inside the container.
- An `AGENTS.md` file containing basic instructions for the agent about working on LUMI.
- An `opencode.json` config file for making the `AGENTS.md` file and the
  [LUMI AIF MCP server](https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure/#mcp-server)
  discoverable to the agent.

## Usage

```bash
# Load environment module
module load Local-LAIF lumi-aif-agents

# Start agent
opencode
```
