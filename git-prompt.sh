if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi

# print custom prompt
function custom_ps1_v0() {
	if [[ ! -d ".git" ]]; then return; fi
	hash=$(git rev-parse --short HEAD)
	printf " $hash"
}

 Default='\033[0;36m'
   Ahead='\033[38;5;048m'
  Behind='\033[0;93m'
Diverged='\033[38;5;208m'
   Reset='\033[0m'

# print custom prompt
function custom_ps1_v1() {
	if [[ ! -d ".git" ]]; then return; fi
	hash=$(git rev-parse --short HEAD)
	branch=$(git symbolic-ref --short HEAD 2>/dev/null)
	if [[ -z "$branch" ]]; then
		printf " ${Default}(($hash...))${Reset}"
		return
	fi
	lcount=$(git rev-list --left-only  --count @{u}...@ 2>/dev/null)
	rcount=$(git rev-list --right-only --count @{u}...@ 2>/dev/null)
	if [[ "$lcount" == 0 && "$rcount" == 0 ]]; then
		branchStatus="≡"
	elif [[ "$lcount" == 0 && "$rcount" > 0 ]]; then
		branchStatus="${Ahead}+"
	elif [[ "$lcount" > 0 && "$rcount" == 0 ]]; then
		branchStatus="${Behind}—"
	elif [[ "$lcount" > 0 && "$rcount" > 0 ]]; then
		branchStatus="${Diverged}±"
	fi
	if [[ -z "$branchStatus" ]]; then
		printf " ${Default}($branch $hash)${Reset}"
	else
		printf " ${Default}($branch $branchStatus${Default} $hash)${Reset}"
	fi
}

# print custom prompt
function custom_ps1_v2() {
	if [[ ! -d ".git" ]]; then return; fi
	hash=$(git rev-parse --short HEAD)
	branchStatus=$(git rev-list --left-right --count @{u}...@ 2>/dev/null \
		| sed 's/\t/,+/' | sed 's/^/-/')
	printf " $branchStatus $hash"
}

PS1='\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]' # set window title
PS1="$PS1"'\n'                 # new line
#PS1="$PS1"'\e[38;5;94m'       # change to ~Brown
#PS1="$PS1"'\[\033[0m\]'       # change to ~Grey
PS1="$PS1"'\e[38;5;220m'       # change to ~GoldYellow
PS1="$PS1"'\t '                # time
PS1="$PS1"'\[\033[33m\]'       # change to brownish yellow
PS1="$PS1"'\w'                 # current working directory
if test -z "$WINELOADERNOEXEC"
then
	GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
	COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
	COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
	COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
	if test -f "$COMPLETION_PATH/git-prompt.sh"
	then
		. "$COMPLETION_PATH/git-completion.bash"
		. "$COMPLETION_PATH/git-prompt.sh"
		PS1="$PS1"'\[\033[36m\]'    # change color to cyan
		PS1="$PS1"'`__git_ps1`'     # bash function
		PS1="$PS1"'`custom_ps1_v2`' # bash function
	fi
fi
#PS1="$PS1"'\[\033[32m\]'      # change to green
PS1="$PS1"'\e[38;5;28m'        # change to ~DarkGreen
PS1="$PS1"' \u@\h '            # user@host<space>
#PS1="$PS1"'\[\033[35m\]'      # change to purple (more like pink)
PS1="$PS1"'\e[94m'             # change to ~Purple
PS1="$PS1"'$MSYSTEM'           # show MSYSTEM
PS1="$PS1"'\[\033[0m\]'        # change color
PS1="$PS1"'\n'                 # new line
PS1="$PS1"'$ '                 # prompt: always $
MSYS2_PS1="$PS1"               # for detection by MSYS2 SDK's bash.basrc
