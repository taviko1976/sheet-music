


\header {
 title = "Untitled"
 composer = "Composer"
 tagline = ##f
}
\paper {
  %横向きに設定
  #(set-paper-size "b5landscape")
  %フォント
  #(define fonts
      (set-global-fonts
      #:music "emmentaler"            ; デフォルト
      #:brace "emmentaler"            ; デフォルト
      #:roman "Linux Libertine O"
      #:sans "Nimbus Sans, Nimbus Sans L"
      #:typewriter "DejaVu Sans Mono"
      ))
}

%c2\bendAfter #-4丸みを帯びたグリスアウト(下方向)
%c2\bendAfter #+6.5丸みを帯びたグリスアウト(上方向)
%\override Glissando.style = #'zigzagジグザクのグリッサンド
%-------------------------------------
%　自作関数
%-------------------------------------
%グリスイン(上にg.マーク)
%引数は表示しない音符とグリスインする音符の二つ
glissInUp = 
#(define-music-function
  (nNote aNote)
  (ly:music? ly:music?)
#{
  \hideNotes
  \grace { #nNote \glissando }
  \unHideNotes
  #aNote
 ^\markup { \sans \teeny \halign #0.4 g. }
#})
%グリスイン(下にg.マーク)
glissInDown = 
#(define-music-function
  (nNote aNote)
  (ly:music? ly:music?)
#{
  \hideNotes
  \grace { #nNote \glissando }
  \unHideNotes
  #aNote
 _\markup { \sans \teeny \halign #0.4 g. }
#})
%グリスアウト(下にg.マーク)
glissOutDown = 
#(define-music-function
  (nNote)
  (ly:music?)
#{
  #nNote
  \bendAfter #-4
  _\markup { \sans \teeny \halign #-2.0 g. }

#})
%-------------------------------------
%　変数
%-------------------------------------
%同じ音が続いたとき、数字を出さないしたときに復帰させる
% \hide TabNoteHeadから復帰
fukki = { \override TabNoteHead.transparent = ##f }
%1回だけのTabNoteHead
% \once \hide TabNoteHead

%ハンマリング、プリングオフ上につける表示する時は「^」下は「-」
%数値か\right-alignで適宜調整
hammer = \markup { \sans \teeny \halign #0.1 H. }
pringoff = \markup { \sans \teeny \halign #0.1 P. }
gtGliss = \markup { \sans \teeny \halign #0.1 g. }
cho = \markup { \sans \teeny \halign #0.4 cho. }
chod = \markup { \sans \teeny \halign #0.1 d. }



%-------------------------------------
%　各パート(変数に代入)
%-------------------------------------
gtPartCb = {
 %1
 s1
 %2
 s1
 \pageBreak
 %3
 s1
 %4
 s1
 \pageBreak
 %5 
 s1
 %6
 s1
 \pageBreak
 %7
 s1
 %8
 s1
}

bassPartCb = {
 %1
 
 %2
 
 %3
 
 %4
 
 %5
 
 %6
 
 %7
 
 %8
 
}


%------------------------------------------------------------------------
\score {
<<
 \new TabStaff \with { instrumentName = "E.G."
 %ベースタブとの間隔
 \override VerticalAxisGroup.default-staff-staff-spacing =
 #'((basic-distance . 3.5)
 (padding . 12))

 } {

 \key a \major
 \tabFullNotation
 \stemUp
 %intro
 \mark \markup { \sans \teeny \box C2 }
 \gtPartCb
 }

 \new TabStaff \with { instrumentName = "E.B."
 stringTunings = #bass-tuning
 } {
 %\clef bass
 \tabFullNotation
 \fixed c, {
 \bassPartCb
 }
}
>>
 \layout {
 \context {
 \Score
 %グリッサンド
 \override Glissando.minimum-length = #5
 \override Glissando.springs-and-rods =
 #ly:spanner::set-spacing-rods
 \override Glissando.thickness = #2
 \omit StringNumber
 % or:
 %\override StringNumber.stencil = ##f


 %譜表の大きさ
 #(layout-set-staff-size 44)

 }
 }
}
