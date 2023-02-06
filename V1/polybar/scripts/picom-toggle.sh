#!/usr/bin/sh
if (($(ps -aux | grep picom | wc -l) > 0))
then
  polybar-msg hook blur-toggle 1
  pkill picom && picom &
else
  polybar-msg hook blur-toggle 2
 pkill picom && picom --experimental-backends -b 
fi