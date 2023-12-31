set nu
set tabstop=2
set softtabstop=2
set shiftwidth=2
set linebreak
set expandtab
set ai
set tabpagemax=100
set wildmenu
set wildmode=longest,list,full
set foldmethod=syntax
set foldlevel=2
set shortmess=aTF
set cmdheight=2
syntax on
syntax sync minlines=10000

" Retain selection when indenting
vnoremap > >gv
vnoremap < <gv

" Commands for editing findings HTML / markdown
command -bar Spell setlocal spell spelllang=en
command -bar Scr :cd ~/working/screenshots
command -bar Tidy :%s/&nbsp;/ /ge <bar> :%s/&[rl]squo;/'/ge
command -bar RemoveIndents :%s/^ \+\([a-zA-Z]\)/\1/e
command Shrinktable :%s/ \+/ /g <bar> %s/-\+/-/g
command Stripspan :s/<span[^>]\+>\([^<]\+\)<\/span>/\1/e <bar> :s/\[\([^\]]\+\)\]{[^}]\+}/\1/e <bar> '<,'>s/<span[^>]\+>\([^<]\+\)<\/span>/\1/ge 
command Nospan :s/<span[^>]\+>[^<]\+<\/span>//e <bar> :s/\[\([^\]]\+\)\]{[^}]\+}//e
command -bar Asciionly :%s/\%u2018/'/ge <bar> :%s/\%u2019/'/ge <bar> :%s/\%u201c/"/ge <bar> :%s/\%u201d/"/ge <bar> :%s/\%u2013/-/ge <bar> :%s/[^\x00-\x7F]/ /ge
command -bar Fdg :Scr <bar> :Spell <bar> :Tidy <bar> :Asciionly 
" <bar> :RemoveIndents
" <bar> :%left
command Hosts :r !grep -v "^\#\|^$" ~/working/hosts.txt

" python
autocmd FileType python set foldmethod=indent

" kotlin
autocmd FileType kotlin set syntax=java
autocmd BufRead,BufNewFile *.kt :set filetype=kotlin

" Kickoff
autocmd BufRead,BufNewFile */kickoff.txt :set filetype=markdown

" Settings for markdown
autocmd FileType markdown set tabstop=4|set shiftwidth=4|set softtabstop=4
autocmd FileType markdown :Spell
autocmd FileType markdown nnoremap <silent> <C-x> :s/\( *\)- \[ \]/\1- [_x]/e <bar> :s/\( *\)- \[x\]/\1- [ ]/e <bar> :s/\( *\)- \[_x\]/\1- [x]/e<CR>

" Findings edit
autocmd BufRead,BufNewFile,BufWinEnter *findings/*.{html,md} :Fdg

" Todo edit
autocmd BufRead,BufNewFile */todo.txt :set filetype=todo 
autocmd FileType todo nnoremap <silent> <C-x> Ix <Esc>ddmaGp`azz:w<CR>
" autocmd FileType todo nnoremap <silent> <C-d> :w<CR>:!grep "^x " >> <CR>:edit<CR>

nnoremap <silent> <F5> :edit<CR>
nnoremap <silent> <F2> :echo @%<CR>
nnoremap <silent> <C-n> :tabnext<CR>
nnoremap <silent> <C-p> :tabprev<CR>

" Replace a link on the current line with the one in the X11 clipboard (requires vim-gtk)
command Lnk :normal ^/href="/e+1\d$"*pa"><Esc>"*pa</a></li>
nnoremap <silent> <F3> :Lnk<CR>
nnoremap <silent> <F4> :0<CR>d/--!><CR>dd
autocmd BufRead,BufNewFile /tmp/further_reading/* :Fdg 
autocmd BufRead,BufNewFile /tmp/further_reading/* :%s/ \(https\?:.\+\)</ <a href=\"\1\">\1<\/a></


" Didn't quite manage to get this working right - file explorer drawer on the left
"let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_preview = 1
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" Navigation between panes
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Close tabs to the right function
function! TabCloseRight(bang)
    let cur=tabpagenr()
    while cur < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (cur + 1)
    endwhile
endfunction

" Close tabs to the left function
function! TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction

command! -bang Tabcloseright call TabCloseRight('<bang>')
command! -bang Tabcloseleft call TabCloseLeft('<bang>')

" " Install vim-plug if not already there
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif
" 
" " Plugins
" call plug#begin('~/.vim/plugged')
" " Plug 'dkarter/bullets.vim' 
" call plug#end()
