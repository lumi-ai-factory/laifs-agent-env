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
        "1. The default endpoint is provided by OpenCode. If you use it,\n" ..
        "   any data you enter will be sent to an external party.\n" ..
        "2. Your current working directory and any subdirectories are\n" ..
        "   accessible to the agent. However, it must prompt for your\n" ..
        "   permission to use any tools.\n" ..
        "3. The agent environment is experimental and may evolve rapidly.\n" ..
        "   Check often for any changes to agent capabilities and\n" ..
        "   permissions.\n" ..
        "\n" ..
        "For more information, visit:\n" ..
        "https://docs.lumi-supercomputer.eu/laif/software/agent-infrastructure/\n"
    )
end
