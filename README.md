# dotfiles

このリポジトリには、各種設定ファイルが含まれています。

## セットアップ方法

### Linux環境

1. 依存パッケージのインストール
   ```bash
   ./install.sh
   ```
   
   このスクリプトは以下を自動的に行います：
   - ディストリビューションの検出（Ubuntu/Debian、Fedora/RHEL、Arch Linux）
   - ディスプレイサーバーの検出（Wayland/X11）
   - tmuxとクリップボードツールのインストール

2. 設定ファイルの適用
   ```bash
   # .gitconfigをコピー
   cp /path/to/dotfiles/.gitconfig ~/.gitconfig
   
   # .tmux.confをシンボリックリンクまたはコピー
   ln -s /path/to/dotfiles/.tmux.conf ~/.tmux.conf
   # または
   cp /path/to/dotfiles/.tmux.conf ~/.tmux.conf
   ```

3. Gitユーザー情報の設定
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```
   
   **注意**: これらの個人情報はリポジトリに含めないでください。各環境で個別に設定してください。

### その他の環境

#### Windows (WSL2)

- **tmux**: 
  ```bash
  sudo apt-get update
  sudo apt-get install tmux
  ```
- **clip.exe**: Windows標準コマンド（追加インストール不要）

#### macOS

- **tmux**: 
  ```bash
  brew install tmux
  ```
- **pbcopy**: macOS標準コマンド（追加インストール不要）
- **reattach-to-user-namespace** (オプション): tmuxからクリップボードにアクセスする際に必要になる場合があります
  ```bash
  brew install reattach-to-user-namespace
  ```

## .gitconfig

Gitの設定ファイルです。便利なエイリアスとデフォルトブランチ設定が含まれています。

### 注意事項

- **シンボリックリンクは使用しないでください**: `git config --global`で設定を追加した際に、リポジトリのファイルが変更されてしまう可能性があります。
- **既存の設定と統合する場合**: 既存の`.gitconfig`がある場合は、バックアップを取ってから統合してください。

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

### 設定の適用後

tmuxの設定を再読み込みする場合：
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

