local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Chatter", "zhTW")
if not L then return end

-- ./Chatter.lua
L["Standalone Config"] = "獨立設定"
L["Open a standalone config window. You might consider installing |cffffff00BetterBlizzOptions|r to make the Blizzard UI options panel resizable."] = "打開一個獨立的設定視窗。你也許希望使用|cffffff00BetterBlizzOptions|r插件使得BZ的選項視窗可以調整大小。"
L["Configure"] = "設定"
L["Modules"] = "模組"
L["Module"] = "模組"
L["Settings"] = "設置"
L["Enable "] = "啟用"
L["Enabled"] = "已啟用"
L["Disabled"] = "已禁用"
L["Chatter Settings"] = "Chatter設置"
L["Welcome to Chatter! Type /chatter to configure."] = "歡迎使用Chatter！輸入/chatter命令進行設置。"

-- ./Modules/AltNames.lua
L["Alt Linking"] = "分身鏈接"
L["Use PlayerNames coloring"] = "使用玩家名字顏色"
L["Use custom color"] = "使用自定義顏色"
L["Use channel color"] = "使用頻道顏色"
L["Name color"] = "名字顏色"
L["Set the coloring mode for alt names"] = "設置分身名字的顏色模式"
L["Custom color"] = "自定義顏色"
L["Select the custom color to use for alt names"] = "為分身名字選擇自定義顏色"
L["Who is %s's main?"] = "誰是%s的本尊？"
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name."] = "允許你右鍵點擊一個人的名字，設置一個在聊天視窗中顯示的備註，例如他們的本尊的名字。"
L["Set Main"] = "設定本尊"

-- ./Modules/AutoLogChat.lua
L["Chat Autolog"] = "聊天日誌"
L["Automatically turns on chat logging."] = "自動啟用遊戲自帶的聊天日誌功能。"

-- ./Modules/Buttons.lua
L["Disable Buttons"] = "禁用按鈕"
L["Show bottom when scrolled"] = "當滾動時顯示底部"
L["Show bottom button when scrolled up"] = "當滾上去時顯示底部按鈕"
L["Hides the buttons attached to the chat frame"] = "隱藏附著在聊天框的按鈕"

-- ./Modules/ChannelColors.lua
L["Channel Colors"] = "頻道著色"
L["Keeps your channel colors by name rather than by number."] = "以名稱為頻道著色而不是以數字"
L["Other Channels"] = "其他頻道"
L["Yell"] = "大喊"
L["Guild"] = "公會"
L["Officer"] = "幹部"
L["Raid"] = "團隊"
L["Party"] = "小隊"
L["Raid Warning"] = "團隊警告"
L["Say"] = "說"
L["Battleground"] = "戰場"
L["Whisper"] = "密語"
L["Select a color for this channel"] = "為該頻道選擇一個顏色"

-- ./Modules/ChannelNames.lua
L["Channel Names"] = "頻道名稱"
L["Raid Leader"] = "團隊隊長"
L["LookingForGroup"] = "尋求組隊"
L["Battleground Leader"] = "戰場隊長"
L["Custom Channels"] = "自定義頻道"
L["Add space after channels"] = "頻道後增加空白"
L["Replace this channel name with..."] = "將頻道名字替換為……"
L["^To "] = "^發送給"
L["^(.-|h) whispers:"] = "^(.-|h)悄悄地說:"
L["Enables you to replace channel names with your own names"] = "允許你用自己的名稱替換掉預設的頻道名稱"

-- ./Modules/ChatFading.lua
L["Disable Fading"] = "禁用淡出"
L["Makes old text disappear rather than fade out"] = "使過期文字立刻消失而不是慢慢淡出"

-- ./Modules/ChatFont.lua
L["Chat Font"] = "聊天字體"
L["Font"] = "字體"
L["Font size"] = "字體大小"
L["Font Outline"] = "字體輪廓"
L["Font outlining"] = "字體輪廓"
L["Chat Frame "] = "聊天視窗"
L["Enables you to set a custom font and font size for your chat frames"] = "允許你為你的聊天視窗自定義字體以及字體大小"

-- ./Modules/ChatFrameBorders.lua
L["Borders/Background"] = "邊框/背景"
L["Enable"] = "啟用"
L["Enable borders on this frame"] = "為該窗體啟用邊框"
L["Combat Log Fix"] = "戰鬥日誌修正"
L["Resize this border to fit the new combat log"] = "更改這個邊框的大小以包容新的戰鬥日誌"
L["Background texture"] = "背景貼圖"
L["Border texture"] = "邊框貼圖"
L["Background color"] = "背景顏色"
L["Border color"] = "邊框顏色"
L["Background Inset"] = "背景邊距"
L["Tile Size"] = "背景塊大小"
L["Edge Size"] = "邊框塊大小"
L["Gives you finer control over the chat frame's background and border colors"] = "使你能更好地控制聊天視窗背景及邊框"

-- ./Modules/ChatLink.Lua
L["Chat Link"] = "聊天鏈接"
L["Lets you link items, enchants, spells, and quests in custom channels."] = "使你能夠在自定義頻道裡鏈接物品，附魔，法術以及任務。"
L["Trade -"] = "交易 -"

-- ./Modules/ChatScroll.lua
L["Mousewheel Scroll"] = "滑鼠滾輪滾動"
L["Scroll lines"] = "滾動行數"
L["How many lines to scroll per mouse wheel click"] = "每次滾輪滾動要捲動多少行"
L["Lets you use the mousewheel to page up and down chat."] = "允許你使用滑鼠滾輪進行聊天記錄翻頁"

-- ./Modules/ChatTabs.lua
L["Chat Tabs"] = "聊天分欄"
L["Button Height"] = "按鈕高度"
L["Button's height, and text offset from the frame"] = "按鈕的高度，以及框體文字的偏移量"
L["Hide Tabs"] = "隱藏分欄"
L["Hides chat frame tabs"] = "隱藏聊天框架"

-- ./Modules/ClickInvite.lua
L["Invite Links"] = "邀請鏈接"
L["Add Word"] = "添加關鍵詞"
L["Add word to your invite trigger list"] = "添加關鍵詞到你的邀請觸發列表"
L["Remove Word"] = "移除關鍵詞"
L["Remove a word from your invite trigger list"] = "從你的邀請觸發列表移除關鍵詞"
L["Remove this word from your trigger list?"] = "確定要移除這個關鍵詞？"
L["Alt-click name to invite"] = "使用Alt+左鍵邀請"
L["Lets you alt-click player names to invite them to your party."] = "讓你使用alt+左鍵可以邀請別人進入你的小隊"
L["invite"] = "組我"
L["inv"] = "組"
L["Gives you more flexibility in how you invite people to your group."] = "給你更有彈性的邀請別人進入你的團隊"

-- ./Modules/CopyChat.lua
L["Copy Chat"] = "聊天複製"
L["Copy text from this frame."] = "從此聊天框複製文字"
L["Lets you copy text out of your chat frames."] = "允許你把文字從聊天框複製出來"

-- ./Modules/EditBox.lua
L["Edit Box Polish"] = "輸入框美化"
L["Top"] = "上"
L["Bottom"] = "下"
L["Free-floating"] = "自由浮動"
L["Free-floating, Locked"] = "自由浮動 - 已鎖定"
L["Attach to..."] = "附著到……"
L["Attach edit box to..."] = "附著輸入框到……"
L["Color border by channel"] = "按頻道著色邊框"
L["Sets the frame's border color to the color of your currently active channel"] = "根據你當前使用的頻道來給框體邊框上色"
L["Use Alt key for cursor movement"] = "使用Alt鍵移動光標"
L["Requires the Alt key to be held down to move the cursor in chat"] = "在文字間移動光標的時候需要按住Alt鍵"
L["Select the font to use for the edit box"] = "設置輸入框裡面的文字字體"
L["Lets you customize the position and look of the edit box"] = "允許你自定義輸入框的外觀和位置"

-- ./Modules/GroupSay.lua
L["Group Say (/gr)"] = "智慧發言(/gr)"
L["Provides a /gr slash command to let you speak in your group (raid, party, or battleground) automatically."] = "允許你使用/gr命令自動依據你當前的隊伍情況說在相應的隊伍頻道（團隊，小隊或者戰場）裡。"

-- ./Modules/Highlight.lua
L["Highlights"] = "高亮"
L["Use sound"] = "使用聲音"
L["Play a soundfile when one of your keywords is said."] = "當有人說了你所設定的關鍵字時播放聲音"
L["Show SCT message"] = "顯示SCT訊息"
L["Show highlights in your SCT mod"] = "在SCT插件裡顯示你的高亮訊息"
L["Sound File"] = "聲音文件"
L["Sound file to play"] = "要播放的聲音文件"
L["Add word to your highlight list"] = "添加關鍵詞到你的高亮列表裡"
L["Remove a word from your highlight list"] = "從你的高亮列表裡面移除一個關鍵詞"
L["Remove this word from your highlights?"] = "你確信要移除這個關鍵詞麼？"
L["Custom Channel Sounds"] = "自定義頻道聲音"
L["Play a sound when a message is received in this channel"] = "當這個頻道有新消息時播放一個聲音"
L["%s said '%s' in %s"] = "%s說「%s」(於%s)"
L["Alerts you when someone says a keyword or speaks in a specified channel."] = "當某人說了一個關鍵字或者指定的頻道有人說話時發出警告。"
L["Reroute whole message to SCT"] = "將對話顯示至SCT"
L["Reroute whole message to SCT instead of just displaying 'who said keyword in channel'"] = "將'誰在頻道中說了關鍵字'改為顯示整句對話至SCT"
L["[%s] %s: %s"] = "[%s] %s: %s"

-- ./Modules/Justify.lua
L["Text Justification"] = "文字對齊"
L["Enable text justification"] = "啟用文字對齊"
L["Left"] = "左"
L["Right"] = "右"
L["Center"] = "中"
L["Lets you set the justification of text in your chat frames."] = "允許你設置你的聊天框文字如何對齊。"

-- ./Modules/LinkHover.lua
L["Link Hover"] = "鏈接懸停"
L["Makes link tooltips show when you hover them in chat."] = "當你將滑鼠懸停在鏈接上時顯示其提示訊息框"

-- ./Modules/PlayerNames.lua
L["Player Names"] = "玩家名字"
L["Warlock"] = "術士"
L["Warrior"] = "戰士"
L["Hunter"] = "獵人"
L["Mage"] = "法師"
L["Priest"] = "牧師"
L["Druid"] = "德魯伊"
L["Paladin"] = "聖騎士"
L["Shaman"] = "薩滿"
L["Rogue"] = "盜賊"
L["Save Data"] = "保存數據"
L["Save data between sessions. Will increase memory usage"] = "在多次遊戲間保存數據，將會增加內容使用量"
L["Save class data from guild between sessions."] = "在多次遊戲間保存公會職業數據"
L["Group"] = "小隊"
L["Save class data from groups between sessions."] = "在多次遊戲間保存小隊職業數據"
L["Target/Mouseover"] = "目標/滑鼠懸停"
L["Save class data from target/mouseover between sessions."] = "在多次遊戲間保存目標/滑鼠懸停的職業數據"
L["Who"] = "查詢"
L["Save class data from /who queries between sessions."] = "在多次遊戲間保存/who查詢的職業數據"
L["Reset Data"] = "重置數據"
L["Destroys all your saved class/level data"] = "清空所有你所保存的職業/等級數據"
L["Are you sure you want to delete all your saved class/level data?"] = "你確定要清空這些數據麼？"
L["Left Bracket"] = "左括號"
L["Character to use for the left bracket"] = "設定左括號所使用的字符"
L["Right Bracket"] = "右括號"
L["Character to use for the right bracket"] = "設定右括號所使用的字符"
L["Use Tab Complete"] = "Tab鍵自動完成"
L["Use tab key to automatically complete character names."] = "使用Tab鍵自動完成玩家名字"
L["Level Options"] = "等級選項"
L["Include level"] = "包含等級"
L["Include the player's level"] = "包含玩家的等級"
L["Exclude Level 70s"] = "不包括70級"
L["Exclude level display for level 70s"] = "排除70級的級別顯示"
L["Color level by difficulty"] = "按照等級難度著色等級"
L["Color Player Names By..."] = "用……著色玩家名字"
L["Select a method for coloring player names"] = "選擇為玩家名字著色的方式"
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "提供為玩家名字著色的選項，添加玩家的等級，以及Tab自動完成玩家名字輸入。"
L["Color self in messages"] = "彩色的自我訊息"
L["Color own charname in messages."] = "彩色自己的角色名稱在訊息中"
L["Emphasize self in messages"] = "在訊息中強調自己"
L["Add surrounding brackets to own charname in messages."] = "在訊息中自己的角色名稱加上括號"
L["Class"] = "職業"
L["Name"] = "名稱"
L["None"] = "無"

-- ./Modules/StickyChannels.lua
L["Sticky Channels"] = "固定頻道"
L["Emote"] = "表情"
L["Raid warning"] = "團隊警告"
L["Custom channels"] = "自定義頻道"
L["Make %s sticky"] = "固定%s頻道"
L["Makes channels you select sticky."] = "使你所選擇的頻道成為固定的輸入頻道。"

-- ./Modules/Telltarget.lua
L["Tell Target (/tt)"] = "密語目標(/tt)"
L["Enables the /tt command to send a tell to your target."] = "使用/tt命令發送一條密語到當前目標。"

-- ./Modules/Timestamps.lua
L["Timestamps"] = "時間標籤"
L["HH:MM:SS AM (12-hour)"] = "時:分:秒 上午 (12小時制)"
L["HH:MM (12-hour)"] = "時:分 (12小時制)"
L["HH:MM:SS (24-hour)"] = "時:分:秒 (24小時制)"
L["HH:MM (24-hour)"] = "時:分 (24小時制)"
L["MM:SS"] = "分:秒"
L["Timestamp format"] = "時間標籤格式"
L["Custom format (advanced)"] = "自定義格式（限高級用戶）"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "自定義時間格式。可以參考 http://www.lua.org/pil/22.1.html 以查看都有哪些格式化符號可以使用。"
L["Timestamp color"] = "時間標籤顏色"
L["Color timestamps the same as the channel they appear in."] = "依據時間標籤所在的頻道，用頻道顏色為其著色。"
L["Adds timestamps to chat."] = "給聊天文字增加時間標籤。"
L["Per chat frame settings"] = "各聊天框設置"
L["Choose which chat frames display timestamps"] = "開啟此聊天框的時間標籤"

-- ./Modules/TinyChat.lua
L["Tiny Chat"] = "迷你視窗"
L["Allows you to make the chat frames much smaller than usual."] = "允許你弄一個比平常小得多的聊天視窗。"

-- ./Modules/UrlCopy.lua
L["URL Copy"] = "網址複製"
L["Lets you copy URLs out of chat."] = "允許你將網址從聊天框中複製出來。"

-- ./Modules/Scrollback.lua
L["Scrollback"] = "捲動"
L["Enable Scrollback length modification"] = "啟用捲動長度修改"
L["Lets you set the scrollback length of your chat frames."] = "讓你設定聊天視窗的捲動長度"
-- L["Chat Frame "] exists in ChatFrame section
