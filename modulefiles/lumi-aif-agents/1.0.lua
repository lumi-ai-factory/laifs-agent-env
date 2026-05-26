-- LUMI AI Factory agent environment module
--
-- This module enables use of the LUMI AI Factory's containerized environment
-- for running AI coding agents on LUMI in a more secure manner.
--

require "lfs"

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
-- Set Singularity bind paths
--

local bindTable = {
    -- Software installed by LUST and local organizations
    "/appl",
    -- OpenCode data directories
    "~/.cache/opencode",
    "~/.config/opencode",
    "~/.local/share/opencode",
    "~/.local/state/opencode",
    -- Additional agent skill directories
    "~/.agents",
    "~/.claude",
}

local bindString = ""

for i, v in ipairs(bindTable) do
    local fp = string.gsub(v, "~", os.getenv("HOME"))
    local attr = lfs.attributes(fp)

    if attr and attr.mode == "directory" then
        if #bindString > 0 then
            bindString = bindString .. ","
        end
        bindString = bindString .. fp
    end
end

setenv("SINGULARITY_BIND", bindString)

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
        "  subdirectories are accessible inside the environment. However,\n" ..
        "  the agent must prompt you for permission to read or write.\n" ..
        "* Experimental status: The agent environment is experimental and\n" ..
        "  may evolve rapidly. Check the `lumi-ai-factory/laifs-agent-env`\n" ..
        "  GitHub repository for any changes to agent capabilities and\n" ..
        "  permissions before use.\n" ..
        "\n" ..
        "Run `module help " .. myModuleName() .. "` for more information.\n"
    )
end
