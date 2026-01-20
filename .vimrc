
" ================================
" 基本設定（Windows/Japanese 無難）
" ================================
set nocompatible

" 文字コード
set encoding=utf-8
set fileencodings=utf-8,cp932,iso-2022-jp,euc-jp
set fileformats=unix,dos

" 表示
set number            " 行番号
set showcmd           " 入力中のコマンド表示
set laststatus=2      " 常にステータスライン
set wildmenu          " コマンドライン補完強化

" TrueColor（対応端末/GUIのみ）
if has('termguicolors')
  set termguicolors
endif

" ================================
" インデント/タブ
" ================================
set expandtab         " Tabの代わりにスペース
set shiftwidth=4      " 自動インデント幅
set softtabstop=4     " Insert時のTab相当幅
set tabstop=4         " 実Tab見え方
set smartindent
set autoindent

" ================================
" 貼り付け時の自動インデントを抑止
" ================================
set pastetoggle=<F2>      " F2で paste ON/OFF（貼付前に押す）
autocmd InsertLeave * set nopaste
nnoremap <F2> :set paste!<CR>:set paste?<CR>
inoremap <silent> <F2> <C-o>:set paste!<CR>

" ================================
" 検索
" ================================
set ignorecase            " 小文字検索時は大/小無視
set smartcase             " ただし検索語に大文字含むなら区別
set incsearch             " インクリメンタルサーチ
set hlsearch              " 検索ハイライト

" ================================
" バックアップ/スワップ/クリップボード
" ================================
set nobackup
set nowritebackup
set noswapfile

" 共有クリップボードは使わない（yankはWindowsのクリップボードへ送らない）
set clipboard=
set clipboard-=unnamed
set clipboard-=unnamedplus

