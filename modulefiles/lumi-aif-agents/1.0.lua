-- LUMI AI Factory agent environment module
--
-- This module enables use of the LUMI AI Factory's containerized environment
-- for running AI coding agents on LUMI in a more secure manner.
--

help([[
The LUMI AI Factory agent environment is a containerized environment
for running AI coding agents on LUMI in a more secure manner.

This module provides the following commands:
* opencode

More information:
* https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure
* https://github.com/lumi-ai-factory/laifs-agent-env
* https://opencode.ai/docs
]])

--
-- Set module-level Singularity bind paths
--

setenv("SINGULARITY_BIND", "/appl")

--
-- Add executables to `PATH`
--

prepend_path("PATH", "/appl/local/laifs/agents/bin")

--
-- Print load message
--

if mode() == "load" then
    LmodMessage(
        "\n" ..
        "=========================================================\n" ..
        "CAUTION: Loaded LUMI AI Factory agent environment module.\n" ..
        "=========================================================\n" ..
        "\n" ..
        "* Data privacy: The default OpenCode model is hosted by the\n" ..
        "  company maintaining OpenCode. If you use this model, any data\n" ..
        "  you enter will be sent to the company.\n" ..
        "* Data security: Your current working directory and any\n" ..
        "  subdirectories are accessible inside the environment.\n" ..
        "* Tool use: The agent must prompt you for permission in order to\n" ..
        "  use tools other than the LUMI AIF MCP server.\n" ..
        "* Experimental status: The agent environment is experimental and\n" ..
        "  may evolve rapidly. Check the `lumi-ai-factory/laifs-agent-env`\n" ..
        "  GitHub repository for any changes to agent capabilities and\n" ..
        "  permissions before use.\n" ..
        "\n" ..
        "Run `module help " .. myModuleName() .. "` for more information.\n"
    )
end
