
copy-to-repo: 
	#Create the config directory if it doesn't exist
	mkdir -p ./config
	# delete everything in ./config
	rm -rf ./config/*
	# Copy everything at ~/.config/nvim to ./config except for the plugin directory as this is generated
	cp -r ~/.config/nvim/* ./config
	rm -rf ./config/plugin

copy-to-system: 
	#Remove everything in ~/.config/nvim
	rm -rf ~/.config/nvim/*
	#Copy everything from ./config to ~/.config/nvim
	cp -r ./config/* ~/.config/nvim
	
