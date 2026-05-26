-- LUMI AI Factory Agent Environment module

local bindPaths = {
    -- Storage areas like `/scratch` are deliberately left unmounted
    -- to provide more control over file access.
    -- The current working directory is mounted by default,
    -- which should be enough for a coding agent.
    --
    -- Additional bind mounts:
    --
    -- Software installed by LUST and local organizations
    "/appl",
    -- OpenCode data directories
    string.format("%s/.cache/opencode", os.getenv("HOME")),
    string.format("%s/.config/opencode", os.getenv("HOME")),
    string.format("%s/.local/share/opencode", os.getenv("HOME")),
    string.format("%s/.local/state/opencode", os.getenv("HOME")),
    -- Additional agent skill directories
    string.format("%s/.agents", os.getenv("HOME")),
    string.format("%s/.claude", os.getenv("HOME")),
}
setenv("SINGULARITY_BIND", table.concat(bindPaths, ","))

-- Add `opencode` command to `PATH`
prepend_path("PATH", "/appl/local/laifs/agents/bin")

if mode() == "load" then
    LmodMessage(
        "\n" ..
        "CAUTION: Loaded LUMI AI Factory agent environment module.\n" ..
        "\n" ..
        "Please ensure you understand the following points before using\n" ..
        "the agent environment:\n" ..
        "\n" ..
        "* Data privacy: The default OpenCode model is hosted by the\n" ..
        "  company maintaining OpenCode. If you use this model, any data\n" ..
        "  you enter will be sent to the company.\n" ..
        "* Data security: Your current working directory and any\n" ..
        "  subdirectories are accessible inside the environment. However,\n" ..
        "  the agent must prompt you for permission to read or write.\n" ..
        "* Experimental status: The agent environment is experimental and\n" ..
        "  may evolve rapidly. Check the repository linked below for any\n" ..
        "  changes to agent capabilities and permissions before use.\n" ..
        "\n" ..
        "More information:\n" ..
        "* https://github.com/lumi-ai-factory/laifs-agent-env\n" ..
        "* https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure/\n"
    )
end
