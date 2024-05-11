local tables = require("./tables")

local unicodeIdent = {}

function unicodeIdent.isXidStart(codepoint: number): boolean
	if codepoint <= 127 then
		return buffer.readu8(tables.ASCII_START, codepoint) == 1
	end

	local index = codepoint / 8 / tables.CHUNK
	local chunk = if index >= buffer.len(tables.TRIE_START) then 0 else buffer.readu8(tables.TRIE_START, index)
	local offset = chunk * tables.CHUNK / 2 + codepoint / 8 % tables.CHUNK

	return bit32.band(bit32.rshift(buffer.readu8(tables.LEAF, offset), bit32.band(codepoint % 8, 7)), 1) ~= 0
end

function unicodeIdent.isXidContinue(codepoint: number): boolean
	if codepoint <= 127 then
		return buffer.readu8(tables.ASCII_CONTINUE, codepoint) == 1
	end

	local index = codepoint / 8 / tables.CHUNK
	local chunk = if index >= buffer.len(tables.TRIE_CONTINUE) then 0 else buffer.readu8(tables.TRIE_CONTINUE, index)
	local offset = chunk * tables.CHUNK / 2 + codepoint / 8 % tables.CHUNK

	return bit32.band(bit32.rshift(buffer.readu8(tables.LEAF, offset), bit32.band(codepoint % 8, 7)), 1) ~= 0
end

return unicodeIdent
