function fish_prompt
	# flags
	set -g fish_prompt_pwd_dir_length 3
	set -g __fish_git_prompt_showdirtystate yes
	set -g __fish_git_prompt_showcolorhints yes
	set -g __fish_git_prompt_showuntrackedfiles yes

	# hostname
	set_color $fish_color_host
	echo -n (hostnamectl hostname)

	# pwd
	if test $(pwd) != $HOME
		set_color brblack
		echo -n ':'
		set_color $fish_color_cwd
		echo -n (basename $PWD)
		#echo -n (prompt_pwd)
	end

	# git
	set_color normal
	printf '%s ' (fish_git_prompt)

	# suffix
	set_color red
	echo -n '| '
	set_color normal
end
