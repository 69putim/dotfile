# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# 略語を展開
zinit load momo-lab/zsh-abbrev-alias
# 実行可能なコマンドに色付け
zinit load zsh-users/zsh-syntax-highlighting

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

### プロンプト設定
if [ $EMACS ]; then
    export TERM=xterm-256color
    PROMPT="%F{green}%~%f %{$fg[red]%}>%{$reset_color%} "
else
    PROMPT="%F{green}%~%f %{$fg[white]%}>%{$reset_color%} "
fi

PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT="%1(v|%F{yellow}%1v%f|)%F{red}%T%f"

### history 設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

### 補完
autoload -U compinit; compinit -C

### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2
### 補完候補に色を付ける。
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
### 補完候補がなければより曖昧に候補を探す。
### m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
### r:|[._-]=*: 「.」「_」「-」の前にワイルドカード「*」があるものとして補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both

# oh-my-zshのセットアップ
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git # <- なんかおまじないらしい
zinit cdclear -q

# Gitの変更状態がわかる ls。ls の代わりにコマンド `k` を実行するだけ。
zinit light supercrabtree/k
# シンタックスハイライト
zinit light zdharma/fast-syntax-highlighting
# Ctrl+r でコマンド履歴を検索
zinit light zdharma/history-search-multi-word

## 補完候補をキャッシュする。
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
## 詳細な情報を使わない
zstyle ':completion:*' verbose no

setopt no_nomatch # git show HEAD^とかrake foo[bar]とか使いたい
setopt no_beep  # 補完候補がないときなどにビープ音を鳴らさない
setopt hist_ignore_dups   # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_all_dups  # 重複したヒストリは追加しない(古いコマンドを削除)
setopt share_history  # シェルのプロセスごとに履歴を共有
setopt append_history  # 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
setopt numeric_glob_sort  # 辞書順ではなく数字順に並べる
setopt list_packed #補完候補を詰めて表示

setopt auto_cd  # ディレクトリ名だけで移動

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
