" GUI専用の見た目調整

" 好みの等幅フォントへ（例：MeiryoKe_Console や Cascadia Code）
" :set guifont=* で選択ダイアログから確認可能
set guifont=Cascadia\ Code\ PL:h12

" メニュー/ツールバー（必要に応じて）
set guioptions-=T     " ツールバー非表示
set guioptions-=m     " メニューバー非表示（必要なら +=m に戻す）
set linespace=1       " 行間

" スクロールや描画の見た目
set t_Co=256          " 256色想定（TrueColor設定と併用可）

" gVimでもMolokai
colorscheme molokai

" クリップボード（Windowsの共通クリップボードを使用）
set clipboard=unnamed

