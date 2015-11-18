#!/usr/bin/perl

use strict;
use warnings;

my @markup = qw[ ‘      √      “       «       »      ’   ];
my @tex    = qw[!xL{}  !xW{}  !xF{}   !xC{}   !xA{}  !xB{}];
my @ansi   = qw{[37m [32m  [1m   [33m [36m [0m};

my @txtre  = map { my $a = $markup[$_];
                   sub { $_[0] =~ s/$a//g } }
  0..$#markup;
my @texre  = map { my ($a, $b) = ($markup[$_], $tex[$_]);
                   sub { $_[0] =~ s/$a/$b/g } }
  0..$#markup;
my @ansire = map { my ($a, $b) = ($markup[$_], $ansi[$_]);
                   sub { $_[0] =~ s/$a/$b/g } }
  0..$#markup;

open TEX,  q[>], q[logo.tex]         or die $!;
open TXT,  q[>], q[../src/logo.txt]  or die $!;
open ANSI, q[>], q[../src/logo.ansi] or die $!;

for (<DATA>) {
  my ($ansi, $tex, $txt) = ($_, $_, $_);

  for my $f (@ansire) { $f->($ansi) };
  for my $f (@texre)  { $f->($tex) };
  for my $f (@txtre)  { $f->($txt) };

  print ANSI $ansi;
  print TEX  $tex;
  print TXT  $txt;
}

__DATA__
‘          *    *-----------------------------*’
‘         / \    \ “√WOPTIC’ ‘\’ 1.0-rXXX  ‘\’ GPLv2+ ‘\’
‘       “√_’‘/’“√_’  ‘\’ “√\’  ‘\’ √transport with  Wien2k+DMFT’ ‘\’
‘      “√/’‘/’“√|| /|’‘\’“√/’   ‘*-----------------------------*’
‘      “√\ ||/||/’‘\    \’«[Assmann,  Wissgott,  Kuneš,’ ‘\’
‘     *--“√|/’‘-’“√|/’‘--*    \’ «Toschi,  Blaha,  and  Held,’ ‘\’
‘    / \       / \    \ «http://arXiv.org/1507.04881]’‘\’
‘  “√=’ ‘_’“√==\ |=|’ ‘/’“√= /=|’  ‘ *-----------------------------*’
‘ “√| | |=/’‘\’ “√|’ ‘/’ “√| |’ ‘\    \’ code »E Assmann’ & »P Wissgott’ ‘\’
‘ /“√=’ ‘\’“√=’‘/  \’“√=’‘/’  “√= \=/’‘\    \’ at  TU  Wien  and  TU  Graz ‘\’
‘*----*----*---------*    *-----------------------------*  ’
