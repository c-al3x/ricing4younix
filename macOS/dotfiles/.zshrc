# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.dotfiles/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Sets
# Spell-check
set spelllang=en
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add
# set spell # Keep spell-check always on

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias reset="exec zsh"
alias yt="youtube-viewer"
alias menubar="~/.config/yabai/yabairc"
alias wp="~/Documents/random/wallpapers && ls"
# alias signal="~/Documents/random/terminal_data/signal-cli-0.6.8/bin/signal-cli"
# alias checksignal="signal -u +15103319075 receive"
alias sm="brew services start mopidy"
alias rsm="brew services restart mopidy"
alias stm="brew services stop mopidy"
# alias sptfy="spicetify backup apply ~/spicetify_data/Themes/Vaporwave/"
alias dl="diskutil list"
alias du="diskutil unmountDisk"
alias news="newsboat"
alias cristian="neofetch"
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
alias Theotokos="show https://fravelinogonzalez.files.wordpress.com/2014/01/theotokos.jpg"
alias Christ="show https://i.etsystatic.com/9177099/r/il/9eb200/1277603772/il_fullxfull.1277603772_72id.jpg"
alias vmenu="vim ~/.config/yabai/yabairc"
alias vz="vim ~/.zshrc"

# Functions
# Set wallpaper
function setwp() {
    WP=$(realpath $1)
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$WP'"
 killall Dock;
    #osascript -e 'tell application "Finder" to set desktop picture to POSIX file "$WP"'
    if [ "$2" != "nowal" ];then
	wal -i $1
    fi
}

# Start yabai
function startyab() {
    brew services restart yabai && killall Dock
}

# Stream 
# function animu() {
#    anime dl $1 --provider animeflix --play vlc -e $2:$3
# }

# Google + w3m
function google() {
    googler $@ --url-handler=w3m
}

# DuckDuckGo + w3m
function ddg() {
    ddgr $@ --url-handler=w3m
}
# Show StackOverflow result in w3m 
function so() {
    googler $@ -j -w stackoverflow.com --url-handler=w3m
}

function soall() {
    googler $@ -w stackoverflow.com --url-handler=w3m
}

# Kill all Finder processes
function killfinder() {
    osascript -e 'tell app "Finder" to quit'
}

# Create new Latex file with automatic Skim preview
function newtex() { 
    cp ~/Documents/random/texts_docs_more/default.tex .	&& mv ./default.tex ./$1.tex
    vim -c ":LLPStartPreview" ./$1.tex 
}

# Open Latex file with Skim preview
function vimp() {
    vim -c ":LLPStartPreview" $1
}

# Load and save Minecraft worlds to and from ext. hard drive
function worlds() {
    comp=/Users/$(id -un)/Library/Application\ Support/minecraft/saves 
    drive=/Volumes/WD\ My\ Passport/Miscellaneous/games/minecraft/saves
    if [ $1 = load ];then
	rsync -a "$drive/" "$comp"
    elif [ $1 = save ];then 
        rsync -a "$comp/" "$drive"
    fi
}

# Create or destroy desktop environment
function desk() {
    open -a Finder
    defaults write com.apple.finder CreateDesktop $1
    killall Finder
}

# Create local searx instance
function searx() {
    python3 ~/Documents/random/terminal_data/searx/searx/webapp.py
}	

# Helper function for m - verifies password with known hash
function verify_pass() {
    echo "True"
}

# Start Mopidy server and ncmpcpp
function m() {
    stopped=$(echo $(brew services | grep mopidy | grep -o 'stopped'))
    if [ -n "$stopped" ];then
        conf=~/.config/mopidy/mopidy.conf
	read -s 'lfmpass?Please enter your Last.fm password: '
	echo
	while [ "$(echo $(echo "$(echo -n $lfmpass | sha256sum)" | sed -n 's/[[:space:]]-//gp'))" != "0d8923c210e2eb94e711e65df9068890aa15b55a2433aa671f5d366b9234836f" ]
	do 
	    read -s 'lfmpass?Incorrect! Please re-enter your Last.fm password: '
	    echo
        done	    
	sed -i "" "s~scrpassword =~password = $lfmpass~g" $conf 
	read -s 'pass?Please enter your Spotify password: '
	echo
	while [ "$(echo $(echo "$(echo -n $pass | sha256sum)" | sed -n 's/[[:space:]]-//gp'))" != "27c777e4f9ba78a2cf27137ca205a9f297262bef06623f4ab06b4b59d115f413" ]
	do 
	    read -s 'pass?Incorrect! Please re-enter your Spotify password: '
	    echo
        done	
	echo "password =" $pass >> $conf
        brew services start mopidy
	sleep 3
	sed -i '' "s~password = $lfmpass~scrpassword =~g" $conf
        sed -i '' -e '$ d' $conf 
    fi
    ncmpcpp
}

# Fix pywal error with cursor color
function cursor() {
    curl -o /usr/local/lib/python3.8/site-packages/pywal/sequences.py \
    https://raw.githubusercontent.com/dylanaraps/pywal/master/pywal/sequences.py 
}

# Display and loop Internet media given URL
function show() {
    let width=$(tput cols)-2
    let height=$(tput lines)-2
    name=$(basename -- "$1")
    ext="${name##*.}"
    curl -s -o tst.$ext $1 
    set -o nocasematch
    if [[ "$2" != "mpv" && "$ext" =~ (jp[e]*g|png) ]];then
	if [[ "$2" = "adjust" ]];then
	    imgcat --height $height --width $width tst.$ext
        else
	    imgcat tst.$ext
        fi
    else 
        mpv --loop tst.$ext 
    fi
    rm tst.$ext
}

# ls | grep more easily
function lg() { ls -a -l | grep $1 }

# Show one of the Orthodox saints for today's feasts
function begum() {
    home="https://orthodoxwiki.org"
    image="$(wget -q -O page $home && 
	    sed -e 's/</\'$'\n</g' page | 
	    grep 'class="image"' | head -n 2 | 
	    tail -1 | sed -n 's/.*href="\(.*\)" class.*/\1/p')" 
    link="$(wget -q -O page2 $home$image && 
	    sed -e 's/</\'$'\n</g' page2 | 
	    grep "img alt" | head -n 1 | 
	    sed -n 's/.*src="\(.*\)" w.*/\1/p')" 
    echo ""; show $home$link adjust; echo ""
    rm page page2
}

function ordodox() {
    reading=""
    wget -q -O page "https://www.oca.org/readings/daily/"$(date +%Y/%m/%d)"/1" 
    verses=$(sed -E -n 's|</*dd>||gp' page | sed 's/[[:space:]]*//')
    verseCount=$(wc -l <<< $verses)
    for ((currVerse = 1; currVerse < $verseCount + 1; currVerse++))
    do
	reading+="$(awk "NR==$currVerse" <<< $verses) "
    done
    echo ""; echo ""; echo $reading; echo ""; echo ""
    rm page    
}

function f() {
    dir=$1; search=$2
    if [ "$2" = "" ];then
	search="$1"; dir="."
    fi
    sudo find $dir -iname "*$search*" 2>&1 | grep -v "Operation not permitted"
}
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Enable syntax highlighting 
source /Users/c-alex/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
