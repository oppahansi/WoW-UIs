local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Chatter", "koKR")
if not L then return end

-- ./Chatter.lua
L["Standalone Config"] = "단독 설정"
L["Open a standalone config window. You might consider installing |cffffff00BetterBlizzOptions|r to make the Blizzard UI options panel resizable."] = "Chatter 설정창을 엽니다. |cffffff00BetterBlizzOptions|r을 설치하여 Blizzard UI 설정창의 크기를 조절할 수 있습니다."
L["Configure"] = "설정"
L["Modules"] = "모듈"
L["Module"] = "모듈"
L["Settings"] = "현재 설정"
L["Enable "] = "사용: "
L["Enabled"] = "사용중"
L["Disabled"] = "미사용중"
L["Chatter Settings"] = "Chatter 설정"
L["Welcome to Chatter! Type /chatter to configure."] = "/chatter를 입력하면 설정창을 불러옵니다."

-- ./Modules/AltNames.lua
L["Alt Linking"] = "사용자 정보"
L["Use PlayerNames coloring"] = "플레이어 이름 색상 사용"
L["Use custom color"] = "사용자 색상 사용"
L["Use channel color"] = "대화 채널 색상 사용"
L["Name color"] = "이름 색상"
L["Set the coloring mode for alt names"] = "사용자 정보의 색상을 변경합니다."
L["Custom color"] = "사용자 색상"
L["Select the custom color to use for alt names"] = "사용자 정보의 사용자 색상을 선택합니다."
L["Who is %s's main?"] = true
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name."] = "대화창에서 캐릭터 이름의 오른쪽 클릭으로 사용 가능합니다."
L["Set Main"] = "메인 설정"

-- ./Modules/AutoLogChat.lua
L["Chat Autolog"] = "대화 자동저장"
L["Automatically turns on chat logging."] = "대화창의 내용을 자동으로 저장합니다."

-- ./Modules/Buttons.lua
L["Disable Buttons"] = "버튼 사용중지"
L["Show bottom when scrolled"] = "스크롤시 버튼 표시"
L["Show bottom button when scrolled up"] = "마우스로 대화창을 스크롤 할 때 버튼을 표시합니다."
L["Hides the buttons attached to the chat frame"] = "대화창에 표시되는 버튼을 숨깁니다."

-- ./Modules/ChannelColors.lua
L["Channel Colors"] = "채널 색상"
L["Keeps your channel colors by name rather than by number."] = "대화채널을 이름으로 표시합니다."
L["Other Channels"] = "다른 채널"
L["Yell"] = "외치기"
L["Guild"] = "길드"
L["Officer"] = "길드관리자"
L["Raid"] = "공격대"
L["Party"] = "파티"
L["Raid Warning"] = "공격대 경보"
L["Say"] = "일반"
L["Battleground"] = "전장"
L["Whisper"] = "귓속말"
L["Select a color for this channel"] = "현재 채널의 색상을 선택합니다."

-- ./Modules/ChannelNames.lua
L["Channel Names"] = "채널 이름"
L["Raid Leader"] = "공격대장"
L["LookingForGroup"] = "파티찾기"
L["Battleground Leader"] = "전장"
L["Custom Channels"] = "사용자 채널"
L["Add space after channels"] = "채널 뒤에 공간 추가"
L["Replace this channel name with..."] = "현재 채널 이름을 변경합니다."
L["^To "] = true
L["^(.-|h) whispers:"] = "^(.-|h) 귓속말:"
L["Enables you to replace channel names with your own names"] = "채널 이름을 사용자에 따라 변경할 수 있게 합니다."

-- ./Modules/ChatFading.lua
L["Disable Fading"] = "사라짐 방지"
L["Makes old text disappear rather than fade out"] = "일정 시간 후에도 지난 대화가 계속 볼 수 있도록 합니다."

-- ./Modules/ChatFont.lua
L["Chat Font"] = "대화창 폰트"
L["Font"] = "폰트"
L["Font size"] = "폰트 크기"
L["Font Outline"] = "폰트 외곽선"
L["Font outlining"] = "폰트 외곽선을 사용합니다."
L["Chat Frame "] = "대화창 "
L["Enables you to set a custom font and font size for your chat frames"] = "대화창에 사용자 폰트 및 크기를 적용할 수 있습니다."

-- ./Modules/ChatFrameBorders.lua
L["Borders/Background"] = "테두리/배경"
L["Enable"] = "사용"
L["Enable borders on this frame"] = "현재 대화창에 테두리를 표시합니다."
L["Combat Log Fix"] = "전투로그 수정"
L["Resize this border to fit the new combat log"] = "새로운 전투로그의 테두리를 수정해 크기를 변경합니다."
L["Background texture"] = "배경 무늬"
L["Border texture"] = "테두리 무늬"
L["Background color"] = "배경 색상"
L["Border color"] = "테두리 색상"
L["Background Inset"] = "배경 삽입"
L["Tile Size"] = "타일 크기"
L["Edge Size"] = "모서리 크기"
L["Gives you finer control over the chat frame's background and border colors"] = "대화창의 배경 및 테두리에 무늬 및 색상을 변경해 알아보기 쉽게 합니다."

-- ./Modules/ChatLink.Lua
L["Chat Link"] = "대화창 링크"
L["Lets you link items, enchants, spells, and quests in custom channels."] = "사용자 채널에 아이템, 마법부여, 주문 및 퀘스트를 링크할 수 있습니다."
L["Trade -"] = "거래 -"

-- ./Modules/ChatScroll.lua
L["Mousewheel Scroll"] = "마우스 스크롤"
L["Scroll lines"] = "스크롤 줄 수"
L["How many lines to scroll per mouse wheel click"] = "휠 스크롤시 한 번에 몇 줄을 이동할지 선택합니다."
L["Lets you use the mousewheel to page up and down chat."] = "대화창을 마우스 휠의 스크롤을 이용하여 올리거나 내릴 수 있습니다."

-- ./Modules/ChatTabs.lua
L["Chat Tabs"] = "대화창 탭"
L["Button Height"] = "버튼 높이"
L["Button's height, and text offset from the frame"] = "버튼의 높이 및 글자의 위치를 변경합니다."
L["Hide Tabs"] = "탭 숨기기"
L["Hides chat frame tabs"] = "대화창 탭을 숨깁니다."

-- ./Modules/ClickInvite.lua
L["Invite Links"] = "초대 링크"
L["Add Word"] = "단어 추가"
L["Add word to your invite trigger list"] = "초대 가능한 단어를 추가합니다."
L["Remove Word"] = "단어 삭제"
L["Remove a word from your invite trigger list"] = "초대 가능한 단어를 삭제합니다."
L["Remove this word from your trigger list?"] = "현재 단어를 초대 가능한 단어에서 삭제하시겠습니까?"
L["Alt-click name to invite"] = "Alt-클릭시 초대"
L["Lets you alt-click player names to invite them to your party."] = "채널에서 캐릭터 이름에 Alt-클릭시 해당 유저를 초대합니다."
L["invite"] = "초대"
L["inv"] = "ㅅㅅ"
L["Gives you more flexibility in how you invite people to your group."] = "파티에 플레이어를 초대하는 간단한 여러가지 방법을 제공합니다."

-- ./Modules/CopyChat.lua
L["Copy Chat"] = "대화창 복사"
L["Copy text from this frame."] = "현재 창의 내용 복사"
L["Lets you copy text out of your chat frames."] = "대화창의 내용을 복사합니다."

-- ./Modules/EditBox.lua
L["Edit Box Polish"] = "입력창 설정"
L["Top"] = "위"
L["Bottom"] = "아래"
L["Free-floating"] = "자유"
L["Free-floating, Locked"] = "자유 고정"
L["Attach to..."] = "접근"
L["Attach edit box to..."] = "입력창 접근"
L["Color border by channel"] = "채널의 테두리 색상"
L["Sets the frame's border color to the color of your currently active channel"] = "현재 참여하고 있는 채널의 색상을 입력창 테두리의 색상으로 설정합니다."
L["Use Alt key for cursor movement"] = "Alt키 커서 움직임"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Alt키를 누르고 커서를 이동합니다."
L["Select the font to use for the edit box"] = "입력창의 폰트를 선택합니다."
L["Lets you customize the position and look of the edit box"] = "대화입력창의 위치 및 테두리를 변경합니다."

-- ./Modules/GroupSay.lua
L["Group Say (/gr)"] = "파티 대화 (/gr)"
L["Provides a /gr slash command to let you speak in your group (raid, party, or battleground) automatically."] = "/gr 명령어를 이용해 현재 파티(공격대, 파티 또는 전장)에 대화를 자동으로 할 수 있습니다."

-- ./Modules/Highlight.lua
L["Highlights"] = "강조"
L["Use sound"] = "소리 사용"
L["Play a soundfile when one of your keywords is said."] = "대화입력시 저장된 키워드가 입력되면 소리로 알립니다."
L["Show SCT message"] = "SCT 메시지 사용"
L["Show highlights in your SCT mod"] = "강조를 SCT 메시지로 알립니다."
L["Sound File"] = "소리 파일"
L["Sound file to play"] = "연주할 소리 파일"
L["Add word to your highlight list"] = "강조 목록에 단어를 추가합니다."
L["Remove a word from your highlight list"] = "강조 목록에서 단어를 삭제합니다."
L["Remove this word from your highlights?"] = "강조목록에서 단어를 삭제하시겠습니까?"
L["Custom Channel Sounds"] = "사용자 채널 소리"
L["Play a sound when a message is received in this channel"] = "현재 채널에 나오는 대화시 소리로 알립니다."
L["%s said '%s' in %s"] = "%1$s 는 %3$s 에서 '%2$s' 라고 말합니다."
L["Alerts you when someone says a keyword or speaks in a specified channel."] = "저장된 단어가 대화창에 입력되거나 원하는 채널의 모든 대화시 소리로 알립니다."
L["Reroute whole message to SCT"] = "SCT 메시지로 다시 보냄"
L["Reroute whole message to SCT instead of just displaying 'who said keyword in channel'"] = "채널의 키워드를 표시하는데 SCT 메시지로 다시 보냅니다."
L["[%s] %s: %s"] = true

-- ./Modules/Justify.lua
L["Text Justification"] = "대화 위치"
L["Enable text justification"] = "대화의 위치를 변경합니다."
L["Left"] = "왼쪽"
L["Right"] = "오른쪽"
L["Center"] = "가운데"
L["Lets you set the justification of text in your chat frames."] = "대화창의 대화들의 위치를 변경합니다."

-- ./Modules/LinkHover.lua
L["Link Hover"] = "링크 표시"
L["Makes link tooltips show when you hover them in chat."] = "대화창의 링크가 있을 때 직접 바로위에 링크를 표시합니다."

-- ./Modules/PlayerNames.lua
L["Player Names"] = "플레이어 이름"
L["Warlock"] = "흑마법사"
L["Warrior"] = "전사"
L["Hunter"] = "사냥꾼"
L["Mage"] = "마법사"
L["Priest"] = "사제"
L["Druid"] = "드루이드"
L["Paladin"] = "성기사"
L["Shaman"] = "주술사"
L["Rogue"] = "도적"
L["Save Data"] = "데이터 저장"
L["Save data between sessions. Will increase memory usage"] = "현재 세션의 데이터를 저장합니다. 따라서 메모리가 증가합니다."
L["Save class data from guild between sessions."] = "현재 세션의 길드의 직업 데이터를 저장합니다."
L["Group"] = "파티"
L["Save class data from groups between sessions."] = "현재 파티의 직업정보를 저장합니다."
L["Target/Mouseover"] = "대상 및 마우스 대상"
L["Save class data from target/mouseover between sessions."] = "현재 세션의 대상 및 마우스 대상의 직업 정보를 저장합니다."
L["Who"] = "누구"
L["Save class data from /who queries between sessions."] = "현재 세션의 /who(/누구) 목록의 직업정보를 저장합니다."
L["Reset Data"] = "데이터 초기화"
L["Destroys all your saved class/level data"] = "모든 직업/레벨 데이터를 삭제합니다."
L["Are you sure you want to delete all your saved class/level data?"] = "모든 저장된 직업/레벨 데이터를 삭제하시겠습니까?"
L["Left Bracket"] = "왼쪽 괄호"
L["Character to use for the left bracket"] = "캐릭터의 왼쪽 괄호을 사용합니다."
L["Right Bracket"] = "오른쪽 괄호"
L["Character to use for the right bracket"] = "캐릭터의 오른쪽 괄호을 사용합니다."
L["Use Tab Complete"] = "탭키 입력 사용"
L["Use tab key to automatically complete character names."] = "탭키를 이용하여 캐릭터 이름을 자동으로 입력합니다."
L["Level Options"] = "레벨 설정"
L["Include level"] = "레벨 포함"
L["Include the player's level"] = "플레이어 레벨을 포함합니다."
L["Exclude Level 70s"] = "70레벨 제외"
L["Exclude level display for level 70s"] = "70레벨은 표시하지 않습니다."
L["Color level by difficulty"] = "레벨에 따른 색상"
L["Color Player Names By..."] = "캐릭터 이름의 색상"
L["Select a method for coloring player names"] = "캐릭터 이름의 표시방법을 선택합니다."
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "플레이어 이름 및 레벨에 따른 색상을 표시하고, 탭키를 이용해 플레이어 이름을 자동으로 입력합니다."
L["Color self in messages"] = "자신의 캐릭명 색상 표시"
L["Color own charname in messages."] = "대화내용에서 자신의 캐릭터 이름이 나오면 캐릭터 이름의 색상을 변경하여 표시합니다."
L["Emphasize self in messages"] = "자신의 캐릭명 강조 표시"
L["Add surrounding brackets to own charname in messages."] = "대화내용에서 자신의 캐릭터 이름이 나오면 캐릭터 이름의 괄호를 표시하여 강조합니다."
L["Class"] = "직업"
L["Name"] = "이름"
L["None"] = "없음"

-- ./Modules/StickyChannels.lua
L["Sticky Channels"] = "채널 고정"
L["Emote"] = "감정표현"
L["Raid warning"] = "공격대 경보"
L["Custom channels"] = "사용자 채널"
L["Make %s sticky"] = "%s 채널고정"
L["Makes channels you select sticky."] = "선택한 채널을 채널고정으로 만듭니다."

-- ./Modules/Telltarget.lua
L["Tell Target (/tt)"] = "대상 귓말(/tt)"
L["Enables the /tt command to send a tell to your target."] = "/tt를 입력하여 대상에게 귓속말을 사용합니다."

-- ./Modules/Timestamps.lua
L["Timestamps"] = "시간표시"
L["HH:MM:SS AM (12-hour)"] = "시:분:초 오전 (12시간제)"
L["HH:MM (12-hour)"] = "시:분 (12시간제)"
L["HH:MM:SS (24-hour)"] = "시:분:초 (24시간제)"
L["HH:MM (24-hour)"] = "시:분 (24시간제)"
L["MM:SS"] = "분:초"
L["Timestamp format"] = "시간표시 형식"
L["Custom format (advanced)"] = "사용자 형식"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "시간표시 형식을 입력하세요. 사용되는 변수는 http://www.lua.org/pil/22.1.html를 참조하세요."
L["Timestamp color"] = "시간표시 색상"
L["Color timestamps the same as the channel they appear in."] = "시간표시의 색상을 대화채널의 색상과 동일하게 합니다."
L["Adds timestamps to chat."] = "대화창에 시간표시를 추가합니다."
L["Per chat frame settings"] = "각 대화창 설정"
L["Choose which chat frames display timestamps"] = "시간을 표시할 대화창을 선택합니다."

-- ./Modules/TinyChat.lua
L["Tiny Chat"] = "작은 대화창"
L["Allows you to make the chat frames much smaller than usual."] = "현재보다 대화창을 작게 만듭니다."

-- ./Modules/UrlCopy.lua
L["URL Copy"] = "홈페이지 주소"
L["Lets you copy URLs out of chat."] = "대화창의 홈페이지 주소를 복사할 수 있습니다."

-- ./Modules/Scrollback.lua
L["Scrollback"] = "스크롤백"
L["Enable Scrollback length modification"] = "대화창의 지난 대화의 한 번에 스크롤백하는 줄 수를 변경하는 모듈입니다."
L["Lets you set the scrollback length of your chat frames."] = "대화창의 스크롤백 줄수를 설정하십시오."
-- L["Chat Frame "] exists in ChatFrame section
