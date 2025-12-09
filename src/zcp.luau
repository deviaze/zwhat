local colors = require("@std/colors")
local fs = require("@std/fs")
local prompt = require("@std/io/prompt")
local process = require("@std/process")

local function cp(source: string, destination: string, confirm: boolean)
    local destination_path = fs.path.join(destination, fs.path.child(source) :: string)
    if confirm then
        if not prompt.confirm(`Copy {colors.bold.blue(source)} -> {colors.bold.green(destination_path)}?`) then
            process.exit(0)
        end
    end
    fs.copy(source, destination_path)
    print(`Copied {colors.blue(source)} -> {colors.green(destination_path)}`)
end

return cp