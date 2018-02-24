@echo off

cd ..
rmdir /s /q Quartz_Buff
rmdir /s /q Quartz_Focus
rmdir /s /q Quartz_Flight
rmdir /s /q Quartz_GCD
rmdir /s /q Quartz_Interrupt
rmdir /s /q Quartz_Latency
rmdir /s /q Quartz_Mirror
rmdir /s /q Quartz_Pet
rmdir /s /q Quartz_Player
rmdir /s /q Quartz_Range
rmdir /s /q Quartz_Swing
rmdir /s /q Quartz_Target
rmdir /s /q Quartz_Timer
rmdir /s /q Quartz_Tradeskill

cd Quartz

move Buff ..\Quartz_Buff
move Focus ..\Quartz_Focus
move Flight ..\Quartz_Flight
move GCD ..\Quartz_GCD
move Interrupt ..\Quartz_Interrupt
move Latency ..\Quartz_Latency
move Mirror ..\Quartz_Mirror
move Pet ..\Quartz_Pet
move Player ..\Quartz_Player
move Range ..\Quartz_Range
move Swing ..\Quartz_Swing
move Target ..\Quartz_Target
move Timer ..\Quartz_Timer
move Tradeskill ..\Quartz_Tradeskill
