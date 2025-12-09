local process = require("@std/process")
local str = require("@std/str")

local function list(p: string): { string }
    local result = process.run {
        program = "zoxide",
        args = { "query", p },
    }

    if not result.ok then
        error(`zoxide query failed with err: {result.err}`)
    end

    local options = str.splitlines(result:unwrap())
    return options
end

return {
    list = list
}