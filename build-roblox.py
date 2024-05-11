# Unnecessary when string requires are a thing
import shutil

shutil.rmtree("out-roblox", ignore_errors = True)
shutil.copytree("./src", "./out-roblox", dirs_exist_ok = True)

with open("./out-roblox/init.luau", "r+") as file:
	data = file.read()
	file.seek(0)
	file.write(data.replace('require("./tables")', 'require(script.tables)'))
