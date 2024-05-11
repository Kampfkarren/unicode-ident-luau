local fs = require("@lune/fs")

local unicodeIdent = require("../src")

local function testChars(filename: string, check: (codepoint: number) -> boolean)
	local contents = fs.readFile(`{filename}.txt`)

	local successes = 0

	pcall(function()
		fs.removeFile(`{filename}.failed.txt`)
	end)

	local failed = {}

	for index = 1, #contents do
		local expected = contents:sub(index, index)
		if expected == "X" then
			continue
		end

		local passes = expected == "T"

		if check(index - 1) ~= passes then
			table.insert(
				failed,
				string.format("%x", index - 1) .. " - " .. if passes then "should have passed" else "should have failed"
			)
		else
			successes += 1
		end
	end

	if #failed > 0 then
		fs.writeFile(`{filename}.failed.txt`, table.concat(failed, "\n"))
	end

	print(`{filename}: {(successes / #contents) * 100}% ({#failed} failures)`)
end

testChars("xid_start", unicodeIdent.isXidStart)
testChars("xid_continue", unicodeIdent.isXidContinue)
