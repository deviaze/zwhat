local colors = require("@std/colors")
local fs = require("@std/fs")
local prompt = require("@std/io/prompt")
local process = require("@std/process")

local function mv(source: string, destination: string, confirm: boolean)
    local destination_path = fs.path.join(destination, fs.path.child(source) :: string)
    if confirm then
        if not prompt.confirm(`Move {colors.bold.blue(source)} -> {colors.bold.red(destination_path)}?`) then
            process.exit(0)
        end
    end
    fs.move(source, destination_path)
    print(`Moved {colors.blue(source)} -> {colors.red(destination_path)}`)
end

return mv