"============================================================================
"  File:  systemrdl.vim
"
"  Description:
"
"  Vim syntax file for SystemRDL.
"
"  Author:   Manning Aalsma <maalsma@altera.com>
"  Date:     Thursday May 14, 2015 01:16:03 PM
"  Version:  1.0
"
"  Revision History:
"
"  1.0 -- Initial version.
"============================================================================

if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif

" Set the local value of the 'iskeyword' option.
" NOTE: '?' was added so that verilogNumber would be processed correctly when
"       '?' is the last character of the number.
if version >= 600
   setlocal iskeyword=@,48-57,63,_,192-255
else
   set iskeyword=@,48-57,63,_,192-255
endif

syn sync lines=1000

syn keyword rdlStatement addrmap
syn keyword rdlStatement regfile
syn keyword rdlStatement reg
syn keyword rdlStatement field
syn keyword rdlStatement default
syn keyword rdlStatement enum

syn match   rdlProperty  "\(->\s*\)\@<!\<[a-zA-Z0-9_]\+\>\ze\s*="
syn keyword   rdlProperty  littleendian
syn keyword   rdlProperty  bigendian

syn match rdlOperator /[=*+-]/

syn keyword rdlTodo contained TODO FIXME

syn region  rdlComment start="/\*" end="\*/" contains=rdlTodo,@Spell
syn match   rdlComment "//.*" contains=rdlTodo,@Spell

syn region  rdlEmbeddedPerl start="<%" end="%>"
syn match   rdlVerilogPreProc "`include"
syn match   rdlVerilogPreProc "`[a-zA-Z0-9_]\+\>"

syn match   rdlOperator "[{}=->\[\]:;]"
syn region  rdlString   start=+"+ skip=+\\"+ end=+"+ contains=rdlEscape,rdlEmbeddedPerl,@Spell
syn match   rdlEscape   +\\[nt"\\]+ contains=rdlEscape,@Spell
syn match   rdlEscape   "\\\o\o\=\o\=" contains=rdlEscape,@Spell

syn case ignore
syn match	rdlNumbers	display transparent "\<\d\|\.\d" contains=rdlNumber,rdlFloat,rdlOctalError,rdlOctal
syn match	rdlNumber		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match	rdlNumber		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
syn case match

syn match   rdlConstant "\<[A-Z][A-Z0-9_]\+\>"

syn match rdlCurly /[\{\}]/

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_rdl_syn_inits")
   if version < 508
      let did_rdl_syn_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif

   " The default highlighting.
   HiLink rdlStatement      Statement
   HiLink rdlProperty       Identifier
   HiLink rdlString         String
   HiLink rdlComment        Comment
   HiLink rdlTodo           Todo
   HiLink rdlEmbeddedPerl   PreProc
   HiLink rdlVerilogPreProc PreProc
   HiLink rdlOperator       Special
   HiLink rdlEscape         Special
   HiLink rdlCurly          Delimiter
   HiLink rdlConstant       Constant
   HiLink rdlNumber         Number
   HiLink rdlOperator       Operator

   delcommand HiLink
endif

let b:current_syntax = "systemrdl"

" vim: ts=4

