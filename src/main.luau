local args = require("@std/args")
local prompt = require("@std/io/prompt")
local process = require("@std/process")

local query = require("./query")
local setup = require("./setup")
local zmv = require("./zmv")
local zcp = require("./zcp")

local parsed = args.parse("zwhat", "copy/move with zoxide"):commands(
    args.command("setup", "set up zcp and zmv aliases"),
    args.command("cp", "copy a file/directory from source to zoxide query destination"):args(
        args.positional("source", "the path to move"),
        args.positional("target", "the zoxide query target to move to"),
        args.flag("--list", "list options before copying"):aliases("-l"),
        args.flag("--confirm", "show confirmation prompt before copying"):aliases("-c")
    ),
    args.command("mv", "move a file/directory from source to zoxide query destination"):args(
        args.positional("source", "the path to copy"),
        args.positional("target", "the zoxide query target to copy to"),
        args.flag("--list", "select from zoxide query options before moving"):aliases("-l"),
        args.flag("--confirm", "show confirmation prompt before copying"):aliases("-c")
    )
)

if parsed.command == "setup" then
    setup()
    process.exit(0)
end

local destination: string
local confirm = false

local source = parsed:expect("source") :: string
local target = parsed:expect("target") :: string

local list = query.list(target)
if #list == 0 then
    error(`No entries found for target '{target}'`)
end
if parsed.flags["--list"] then
    destination = list[prompt.pick("Pick a destination from the following", list)]
else
    destination = list[1]
end
if parsed.flags["--confirm"] then
    confirm = true
end

if parsed.command == "mv" then
    zmv(source, destination, confirm)
elseif parsed.command == "cp" then
    zcp(source, destination, confirm)
end
