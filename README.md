# dotfiles

このリポジトリには、各種設定ファイルが含まれています。

## .gitconfig

Gitの設定ファイルです。便利なエイリアスとデフォルトブランチ設定が含まれています。

### 設定の適用方法

1. `.gitconfig`をホームディレクトリにシンボリックリンクまたはコピー
   ```bash
   ln -s /path/to/dotfiles/.gitconfig ~/.gitconfig
   # または
   cp /path/to/dotfiles/.gitconfig ~/.gitconfig
   ```

2. 既存の設定と統合する場合（推奨）
   ```bash
   # 既存の設定をバックアップ
   cp ~/.gitconfig ~/.gitconfig.backup
   
   # 新しい設定を追加（既存の設定は保持される）
   cat ~/.gitconfig.backup >> ~/.gitconfig
   ```

### 機能

- **エイリアス**: よく使うgitコマンドの短縮形
  - `git s` = `git status`
  - `git b` = `git branch`
  - `git ba` = `git branch -a`
  - `git r` = `git remote`
  - `git rv` = `git remote -v`
  - `git gr` = グラフィカルなログ表示
- **デフォルトブランチ**: `main`をデフォルトブランチとして設定

## .tmux.conf

tmuxの設定ファイルです。環境に応じて自動的に適切なクリップボードコマンドを選択します。

### 必要なインストール

#### Windows (WSL2)

- **tmux**: tmux本体
  ```bash
  # Ubuntu/Debian系
  sudo apt-get update
  sudo apt-get install tmux
  
  # または
  sudo apt install tmux
  ```

- **clip.exe**: Windows標準コマンド（追加インストール不要）

#### Linux (Wayland)

- **tmux**: tmux本体
  ```bash
  # Ubuntu/Debian系
  sudo apt-get update
  sudo apt-get install tmux
  
  # Fedora/RHEL系
  sudo dnf install tmux
  
  # Arch Linux系
  sudo pacman -S tmux
  ```

- **wl-clipboard**: Wayland用クリップボードツール
  ```bash
  # Ubuntu/Debian系
  sudo apt-get install wl-clipboard
  
  # Fedora/RHEL系
  sudo dnf install wl-clipboard
  
  # Arch Linux系
  sudo pacman -S wl-clipboard
  ```

#### Linux (X11)

- **tmux**: tmux本体
  ```bash
  # Ubuntu/Debian系
  sudo apt-get update
  sudo apt-get install tmux
  
  # Fedora/RHEL系
  sudo dnf install tmux
  
  # Arch Linux系
  sudo pacman -S tmux
  ```

- **xclip**: X11用クリップボードツール
  ```bash
  # Ubuntu/Debian系
  sudo apt-get install xclip
  
  # Fedora/RHEL系
  sudo dnf install xclip
  
  # Arch Linux系
  sudo pacman -S xclip
  ```

#### macOS

- **tmux**: tmux本体
  ```bash
  # Homebrewを使用
  brew install tmux
  ```

- **pbcopy**: macOS標準コマンド（追加インストール不要）

- **reattach-to-user-namespace** (オプション): tmuxからクリップボードにアクセスする際に必要になる場合があります
  ```bash
  brew install reattach-to-user-namespace
  ```

### 設定の適用方法

1. `.tmux.conf`をホームディレクトリにシンボリックリンクまたはコピー
   ```bash
   ln -s /path/to/dotfiles/.tmux.conf ~/.tmux.conf
   # または
   cp /path/to/dotfiles/.tmux.conf ~/.tmux.conf
   ```

2. tmuxの設定を再読み込み
   ```bash
   tmux source-file ~/.tmux.conf
   ```

### 機能

- **viモード**: コピーモードでviキーバインドを使用
- **環境別クリップボード対応**: WSL2、macOS、Wayland、X11に自動対応
- **マウスサポート**: マウス操作を有効化
- **ペインボーダー**: 緑/黒のボーダー、アクティブ時は緑/黄
- **ロギング**: `H`キーでログ記録開始、`h`キーで停止

### ロギング機能について

ログは `~/.tmux/log/` ディレクトリに保存されます。初回使用前にディレクトリを作成してください：

```bash
mkdir -p ~/.tmux/log
```

