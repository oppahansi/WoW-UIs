@echo off

cd ..
rmdir /s /q Cartographer_Battlegrounds
rmdir /s /q Cartographer_Coordinates
rmdir /s /q Cartographer_Foglight
rmdir /s /q Cartographer_GroupColors
rmdir /s /q Cartographer_GuildPositions
rmdir /s /q Cartographer_InstanceLoot
rmdir /s /q Cartographer_InstanceMaps
rmdir /s /q Cartographer_InstanceNotes
rmdir /s /q Cartographer_LookNFeel
rmdir /s /q Cartographer_Notes
rmdir /s /q Cartographer_POI
rmdir /s /q Cartographer_Professions
rmdir /s /q Cartographer_ZoneInfo
rmdir /s /q Cartographer_Waypoints

cd Cartographer

move Cartographer_Battlegrounds ..\Cartographer_Battlegrounds
move Cartographer_Coordinates ..\Cartographer_Coordinates
move Cartographer_Foglight ..\Cartographer_Foglight
move Cartographer_GroupColors ..\Cartographer_GroupColors
move Cartographer_GuildPositions ..\Cartographer_GuildPositions
move Cartographer_InstanceLoot ..\Cartographer_InstanceLoot
move Cartographer_InstanceMaps ..\Cartographer_InstanceMaps
move Cartographer_InstanceNotes ..\Cartographer_InstanceNotes
move Cartographer_LookNFeel ..\Cartographer_LookNFeel
move Cartographer_Notes ..\Cartographer_Notes
move Cartographer_POI ..\Cartographer_POI
move Cartographer_Professions ..\Cartographer_Professions
move Cartographer_ZoneInfo ..\Cartographer_ZoneInfo
move Cartographer_Waypoints ..\Cartographer_Waypoints
