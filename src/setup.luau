local fs = require("@std/fs")
local env = require("@std/env")
local prompt = require("@std/io/prompt")
local process = require("@std/process")

local function setup()
    local default_path = fs.path.join(fs.path.home(), ".local", "bin")

    local PATH = env.getvar("PATH") or error("Can't get shell path ($PATH)??")

    if env.executable_path:match("zwhat$") then
        error("zwhat is already setup, run this with 'seal' after cloning")
    end

    local result = process.run {
        program = env.executable_path,
        args = {"compile"}
    }
    if not result.ok then
        error(`unable to run 'seal compile' due to err: {result.err}`)
    end

    print("Compiled zwhat to ./zwhat")

    local destination_path = fs.path.join(
        (
            if fs.is(default_path) == "Directory" and string.find(PATH, default_path, 1, true) then
                default_path
            else
                prompt.validate("Directory to move ./zwhat? (~/.local/bin not found)", function(p)
                    return if fs.is(p) == "Directory" then true else `{p} isn't a directory`
                end)
        ),
        "zwhat"
    )

    if fs.is(destination_path) == "File" then
        print(`Replacing zwhat at '{destination_path}'`)
    end

    fs.move(fs.dir.cwd():join("zwhat"), destination_path)

    print(`Moved ./zwhat to '{destination_path}'`)
end

return setup