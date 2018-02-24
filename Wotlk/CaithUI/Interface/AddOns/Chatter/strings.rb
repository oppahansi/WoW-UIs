puts <<EOF 
-- This file is script-generated and should not be manually edited. 
-- Localizers may copy this file to edit as necessary. 
local AceLocale = LibStub:GetLibrary("AceLocale-3.0") 
local L = AceLocale:NewLocale("Chatter", "enUS", true) 
if not L then return end 
 
EOF 
 
usedStrings = [] 
EXCLUDE_DIRS = ["Localization", "Libs"] 
Dir.glob("#{ARGV[0].gsub(/\/$/, "")}/**/*.lua").each do |filename| 
		valid = true 
		EXCLUDE_DIRS.each {|d| if filename.match d then valid = false; break end } 
		next unless valid 
 
		puts "-- #{filename}" 
		ct = 0 
		File.open(filename).each do |line| 
				matches = line.match(/L\[\"[^\]]+\]/) 
				if matches then 
						match = matches[0] 
						if not usedStrings.include? match then 
								usedStrings.push match 
								puts "#{match} = true" 
								ct = ct + 1 
						end 
				end 
		end 
		puts "-- no localization" if ct == 0 
		puts "\n" 
end
