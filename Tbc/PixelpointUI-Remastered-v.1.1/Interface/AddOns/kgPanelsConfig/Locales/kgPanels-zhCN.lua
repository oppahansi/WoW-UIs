--[[
Chinese simplified by Kurax
]]
local L = LibStub("AceLocale-3.0"):NewLocale("kgPanels","zhCN")
if not L then return end
--Artwork items
L["Delete from Library"] = "从库里删除"
L["Delete"] = "删除"
L["Are you sure?"] = "你确定要删除？"
L["ART_PREVIEW"] = "下面是你刚才所添加的图片的预览。如果你看不到图片，请确认它存在于你的魔兽世界目录，并重新运行游戏。"
L["Add"] = "添加"

-- Panel items
L["OnClick"] = "OnClick"
L["Enter the script for OnClick callback."] = "输入OnClick事件的回调脚本。"
L["OnLoad"] = "OnLoad"
L["Enter the script for OnLoad callback."] = "输入OnLoad事件的回调脚本。"
L["OnLeave"] = "OnLeave"
L["Enter the script for OnLeave callback."] = "输入OnLeave事件的回调脚本。"
L["OnEnter"] = "OnEnter"
L["Enter the script for OnEnter callback."] = "输入OnEnter事件的回调脚本。"
L["OnHide"] = "OnHide"
L["Enter the script for OnHide callback."] = "输入OnHide事件的回调脚本。"
L["OnShow"] = "OnShow"
L["Enter the script for OnShow callback."] = "输入OnShow事件的回调脚本。"
L["OnUpdate"] = "OnUpdate"
L["Enter the script for OnUpdate callback."] = "输入OnUpdate事件的回调脚本。"
L["OnEvent"] = "OnEvent"
L["Enter the script for OnEvent callback."] = "输入OnEvent事件的回调脚本。"
L["Scripts"] = "脚本"
-- text options
L["Top"] = "上"
L["Middle"] = "中"
L["Bottom"] = "下"
L["Left"] = "左"
L["Right"] = "右"
L["Center"] = "正中"
L["Vertical Justification"] = "垂直对齐"
L["Justification of the text."] = "文本的对齐方式。"
L["Horizontal Justification"] = "水平对齐"
L["Y Offset"] = "垂直偏移"
L["Y offset. NOTE: positive for right, negative for left."] = "垂直偏移量。注意：正数向右，负数向左。"
L["X Offset"] = "水平偏移"
L["X offset from center. NOTE: postive for up, negative for down."] = "水平偏移量。注意：正数向上，负数向下。"
L["Text Positioning"] = "文本位置"
L["Font"] = "字体"
L["Font to use for this panel."] = "该面板所使用的字体。"
L["Font Size"] = "字体大小"
L["Size of the text in points."] = "以点为单位的字体大小"
L["Font Color"] = "字体颜色"
L["Color for the text."] = "文字的颜色。"
L["Text"] = "文字"
L["What you would like to appear on the panel."] = "你想让面板上面显示的东西。"
L["General Text Settings"] = "一般文字选项"
L["Text Options"] = "文本选项"
L["Blizzard"] = "暴雪"
L["Texture Options"] = "材质选项"
L["Background Texture"] = "背景材质"
L["Name"] = "名称"
L["Artwork to use for a background."] = "背景所使用的图片。"
L["Rotate"] = "旋转"
L["Rotate the artwork centered on the middle point."] = "以图片为中心进行旋转。"
L["Flip Horizontally"] = "水平翻转"
L["Mirror this background."] = "镜像这个背景。"
L["Flip Vertically"] = "垂直翻转"
L["Invert the artwork."] = "反转图片。"
L["Border Texture"] = "边框材质"
L["Border artwork."] = "边框的图片。"
L["Border Edge Size"] = "边框材质大小"
L["Border edge size, see the FAQ."] = "边框材质的大小，请参考“常见问题”。"
L["Bottom Left"] = "左下"
L["Bottom Right"] = "右下"
L["Top Left"] = "左上"
L["Top Right"] = "右上"
L["Parent Frame"] = "父级框体"
L["Frame you wish to parent against. NOTE: To parent against a panel you have already defined, simply use that name."] = "你所要设定的父级框体。注意：如果要将一个已经定义的面板设定为父级，只需要使用其名字。"
L["Anchor Frame"] = "锚点框体"
L["Frame you wish to anchor this panel to."] = "你要将这个面板所固定到的框体。"
L["Anchor From"] = "自己的锚点"
L["Anchoring from."] = "从这里固定。"
L["Anchor To"] = "目标的锚点"
L["Anchoring to."] = "固定到这里。"
L["Parent And Anchor Settings"] = "父级和锚点设定"
L["Scaling"] = "缩放"
L["Panel scaling options."] = "面板缩放选项。"
L["Background"] = "背景"
L["Low"] = "低"
L["Medium"] = "中"
L["High"] = "高"
L["Artwork"] = "装饰"
L["Dialog"] = "对话框"
L["Tooltip"] = "提示信息"
L["Strata"] = "框架层"
L["Frame strata to set this in, Background is the lowest strata."] = "该面板所处的层级，背景是最低的层级。"
L["Level"] = "层级"
L["Panel level, for Z-Indexing."] = "面板的层级，用来决定Z轴的顺序。"
L["Y offsetting, positive for up, negative for down."] = "垂直偏移量。注意：正数向上，负数向下。"
L["X offsetting, positive for right, negative for left."] = "水平偏移量。注意：正数向右，负数向左。"
L["Panel Height"] = "面板高度"
L["Panel height."] = "面板的高度"
L["Panel Width"] = "面板宽度"
L["Panel width."] = "面板的宽度"
L["Position Settings"] = "位置选项"
L["Solid"] = "纯色"
L["Gradient"] = "渐变"
L["None"] = "无"
L["Horizontal"] = "水平"
L["Vertical"] = "垂直"
L["Blend"] = "Blend"
L["Add"] = "Add"
L["Mod"] = "Mod"
L["AlphaKey"] = "AlphaKey"
L["Disable"] = "禁用"
L["Border Color"] = "边框颜色"
L["Border coloring."] = "边框的颜色。"
L["Background Color Blending"] = "背景颜色混合"
L["Blend mode for the background color."] = "背景颜色的混合模式。"
L["Background Gradient Color"] = "背景的渐变颜色"
L["Color to use for the gradient."] = "渐变所使用的颜色。"
L["Background Gradient Style"] = "背景渐变样式"
L["Gradient style of this panel."] = "该面板的渐变样式。"
L["Background Color"] = "背景颜色"
L["Background color of this panel."] = "该面板的背景颜色。"
L["Background Color Style"] = "背景颜色样式"
L["Color style of this panel. NOTE: None disables background coloring."] = "该面板背景颜色的样式。注意：选“无”会禁用背景着色。"
L["Panel Opacity"] = "面板透明度"
L["Set the opacity of this panel."] = "设置该面板的透明度。"
L["Color And Opacity Settings"] = "颜色和透明度设置"
L["kgPanel"] = "kgPanel"
L["Intercept Mouse Clicks"] = "拦截鼠标点击"
L["This option controls wether the panel will interact with the mouse. Required for OnLeave,OnEnter,OnClick"] = "该选项决定面板是否接受鼠标的事件。OnLeave/OnEnter/OnClick事件需要此选项开启。"
L["Lock Panel"] = "锁定面板"
L["Lock/Unlock this panel."] = "锁定/解锁面板"
L["General Settings"] = "一般设置"
L["User defined Panel"] = "用户定义的面板"
L["Textures"] = "材质"
L["Colors"] = "颜色"
L["Anchors"] = "锚点"
L["Postions"] = "位置"
L["All"] = "所有"
L["Paste"] = "粘贴"
L["Perform a paste."] = "执行粘贴。"
L["From"] = "来自"
L["Panel you wish to copy from."] = "你所要复制自的面板。"
L["Copy"] = "复制"
L["Copy configuration from another panel to use in this panel."] = "从另外一个面板复制配置选项给这个面板使用。"
L["Remove Panel"] = "删除面板"
L["Delete this panel from the layout."] = "从该布局中删除这个面板。"
L["Are you sure you wish to delete this panel? This can not be undone."] = "你确定要删除这个面板么？这个操作无法恢复。"
L["Panel Layout"] = "面板布局"
L["Set as Active Layout"] = "使用该布局"
L["Copy Layout To Clipboard"] = "将布局复制到剪贴板"
L["Export"] = "导出"
L["Export this layout to the clipboard to copy and send to friends."] = "将该布局复制到剪贴板发送给其他人。"
L["Delete Layout"] = "删除布局"
L["Delete this layout from your layout list."] = "从你的布局列表中删除这个布局。"
L["Rename Layout"] = "重命名布局"
L["Enter the new name of the layout"] = "为该布局输入一个新名称"
L["Change the name of this layout"] = "更改该布局的名称"
L["Activate"] = "激活"
L["Set this layout as your active layout."] = "将此布局设置为你的活动布局。"
L["Default"] = "默认"
L["Blizzard Tooltip"] = "默认提示信息框"
L["Blizzard Dialog"] = "默认对话框"
L["Panel Name"] = "面板名称"
L["Name of this new panel"] = "这个新面板的名字"
L["Create"] = "创建"
L["Create a new panel with generic defaults"] = "以通用默认选项创建一个新面板"
L["Panel already exists. Overwrite?"] = "该面板已经存在，覆盖么？"
L["Create Using Defaults"] = "以默认选项创建"
L["Create a new panel using your specific defaults."] = "以你指定的默认选项创建一个新面板。"
L["Panel Creation"] = "面板创建"
L["Active Panels"] = "正在使用的面板"
L["Default Panel Options"] = "默认面板选项"
L["Layout Name"] = "布局名称"
L["This is the name of the layout, as it will appear in drops downs, and the under the Layout tab."] = "这是布局的名字，将会出现在下拉列表里，以及“布局”栏里。"
L["Create"] = "创建"
L["Create a new layout. NOTE: This will change your current layout to the newly created layout."] = "创建一个新布局。注意：这将会从你当前的布局切换到新建的布局。"
L["A layout with that name already exists. Overwrite?"] = "该名字的布局已经存在，要覆盖么？"
L["Add New Layout"] = "添加新布局"
L["Layouts"] = "布局"
L["Layout tab"] = "布局栏"
L["Active Layout: "] = "当前使用的布局："
L["Art Library"] = "图片库"
L["Backgrounds"] = "背景"
L["Borders"] = "边框"
L["Add New Artwork"] = "添加新图片"
L["Artwork Name"] = "图片名字"
L["This is the name as it will appear in drops down menus and the side tab."] = "该名字将会出现在下拉列表和侧边栏里。"
L["Artwork Type"] = "图片类型"
L["Indicate what type of artwork you are adding."] = "指定你所添加的图片的类型。"
L["Artwork Path"] = "图片路径"
L["This is the path to the texture you wish to add. NOTE: this path must be realtive to the WoW folder and seperated by '\\\\'"] = "你所要添加的图片的路径。注意：这个路径必须相对于你的魔兽世界目录，并且以“\\\\”作为分隔符。"
L["Create a new entry in the Artwork Library"] = "给你的图片库创建一个新条目"
L["Artwork already exists. Overwrite?"] = "图片已经存在，覆盖么？"
L["For help using kgPanels, please see the FAQ section."] = "关于kgPanels的使用方法，请参考“常见问题”部分"
L["Enable Addon"] = "启用插件"
L["This option allows you to turn kgPanels on/off"] = "该选项允许你开启/关闭 kgPanels"
L["General Options"] = "基础选项"
L["This is the general option menu. Core seetings are located in this main area."] = "这是基础选项菜单，包含着核心设置选项。"
L["Addon Settings"] = "插件选项"
L["Import New Layout"] = "导入新布局"
L["Import As.."] = "导入为……"
L["Name to import this layout under."] = "导入这个布局所使用的名称。"
L["Import Layout"] = "导入布局"
L["This will import a layout into your configuration."] = "可以导入一个布局到你的配置里。"
L["Import"] = "导入"
L["Perform the import."] = "执行导入。"
L["kgPanels Layout Export"] = "kgPanels布局导出"
L["Press Ctrl-A to select the text, then Ctrl-C to copy."] = "按Ctrl+A选择文本，然后Ctrl+C拷贝。"
L["Press Cmd-A to select the text, then Cmd-C to copy."] = "按Cmd+A选择文本，然后Cmd+C拷贝。"
L["Background Insets"] = "背景边距"
L["Inset Options"] = "边距选项"
L["Top background inset."] = "顶部背景边距。"
L["Left background inset."] = "左侧背景边距。"
L["Bottom background inset."] = "底部背景边距。"
L["Right background inset."] = "右侧背景边距。"
L["Scripts Dependency"] = "脚本依赖"
L["Addon Name"] = "插件名字"
L["Addon this Panels script depends."] = "这个面板脚本所依赖的插件。"
L["Frame Finder"] = "框体查找器"
L["Unknown"] = "未知"
L["Frames"] = "框体"
L["Tile Background"] = "平铺背景"
L["Tile the background texture, NOTE: this disables rotation and flipping."] = "平铺背景贴图，注意：平铺将禁用旋转和翻转。"
L["Tile Size"] = "块大小"
L["Size of each tile."] = "每个平铺块的大小。"
L["Rename Panel"] = "重命名面板"
L["Change the name of this panel."] = "更改这个面板的名字。"
L["There is already a panel with that name. Overwrite?"] = "该名字已经存在，要覆盖么？"
L["Rename"] = "重命名"
L["New name for this panel."] = "该面板的新名字。"
L["Import from eePanels2"] = "从eePanels2导入"
L["Import panels from eePanels2"] = "从eePanels2导入面板"
L["Import complete, eePanels is now OFF, remember to disable or rmove eePanels2"] = "导入完成，eePanels现在已经关闭，记得禁用或者移除eePanels2。"
L["FAQ"] = "常见问题"
L["To create a panel you are required to have a layout active."] = "你必须有一个已经激活的布局才可以创建一个面板"

L["1. kgPanels"] = "1、kgPanels"
L["2. Artwork"] = "2、图片"
L["3. Textures"] = "3、材质"
L["4. Text"] = "4、文字"
L["5. Scripting"] = "5、脚本"
L["6. Import and Export"] = "6、导入与导出"
L["FAQ_1_1"] = [[
|cffffffff布局是什么东西？|r

kgPanels 以布局来组织面板。每个布局都是以全局保存的，每个角色只需要简单的选择他想使用的布局。
]]
L["FAQ_1_2"] = [[
|cffffffff我想要添加一块面板，但是“创建”按钮是灰的，为什么？|r

你必须选择一个布局。在布局菜单下，选择一个你想使用的布局，然后激活它。
]]
L["FAQ_1_3"] = [[
|cffffffff父级框体和锚点|r

kgPanels支持使用你定义的面板名称当作父级框体。
不要使用以 kgPanels 开头的名字作为父级框体名。这样做可能会导致一些不可预知的问题，因为kgPanels会自动依据需要回收框体。
因此，假如你创建了个面板叫做“某面板”，你就可以使用“某面板”来当作父级框体以及锚点的名称。
]]
L["FAQ_1_4"] = [[
|cffffffff获取框体名|r

kgPanels的设置系统为框体获取添加了一个快捷键。在键位设置里为框体获取器设置一个键位后，只需要按下这个键就会打开框体名获取功能并显示你鼠标指向的框体名。
]]
L["FAQ_2_1"] = [[
|cffffffff怎样添加材质？|r

可以使用材质库来添加你需要的元素，如果你安装了SharedMedia它们也会出现在下拉菜单里。
]]
L["FAQ_2_2"] = [[
|cffffffff为什么我设置了材质却看不到颜色渐变效果？|r
将背景设置为渐变或实心就可以使材质变色。
]]
L["FAQ_2_3"] = [[
|cffffffff怎样修改边框颜色呢？|r

在主设置区域为特定面板设置。
]]
L["FAQ_2_4"] = [[
|cffffffff我改变透明度的时候结果是多重的|r

主透明度设置是优先于颜色透明度的。
]]
L["FAQ_3_1"] = [[
|cffffffff我把材质添加进了材质库但是看不到，做错了？|r

添加材质的时候你必须保证WOW可以识别到这个目录并且拼写没有错误。如果你只是把文件复制到磁盘上，你需要重启WoW来使其识别出目录内新增的文件。
]]
L["FAQ_3_2"] = [[
|cffffffff我添加了一个边框，但是看起来很滑稽，做错了什么吗？|r

不幸的是，WoW并不是在任何时候都会返回材质尺寸，所以kgPanels对于边框使用默认的50x50尺寸，这可能会使某些边框的图像扭曲。
]]
L["FAQ_3_3"] = [[
|cffffffff我想使某些材质镜像化（翻转），要怎么做呢？|r

为这个材质使用水平翻转选项，要想上下颠倒就用垂直翻转。
]]
L["FAQ_3_4"] = [[
|cffffffff边框边缘大小是什么？|r

这是WOW为边框设定的大小选项，调整这个参数可以使边框变粗或变细。
]]
L["FAQ_3_5"] = [[
|cffffffffkgPanels是否支持ShardMedia共享媒体资源？|r
支持。
]]
L["FAQ_4_1"] = [[
|cffffffff我想使用某个特定字体，但是列表内只显示暴雪自带的。怎么添加更多字体呢？|r

目前字体支持还有些限制，kgPanels会使用任何ShardMedia内的字体，那个选项是用来通过CF和CF2替换默认界面字体的。
]]
L["FAQ_5_1"] = [[
|cffffffff脚本变量|r
在任何脚本内都可以使用以下变量：|r

|cffff6666self|r总是设定为该脚本指向的面板|r

|cffff6666self.bg|r指的是背景图样框体|r

|cffff6666self.text|r是该框体的文本字串|r

|cffff6666kgPanels|r指的是kgPanels的对象|r

]]
L["FAQ_5_2"] = [[
|cffffffffkgPanels脚本的一些功能？|r

|cffff6666kgPanels:FetchFrame(name)|r获取任何你的样式中定义的框体|r

|cffff6666kgPanels:ActivateLayout(name)|R切换样式|r

还有一些其他的函数，不过如果没有一些终端数据结构知识不建议使用它们。|r
]]
L["FAQ_5_3"] = [[
|cffffffff变量是如何传递的？|r

每个句柄都可以传递到高等级的参数（参照WOWWiki的Event API）。
第一个变量永远是self。

OnEvent，我们把这个变量参数分离了，这样你可以很简单的引用arg1, arg2, arg3...等等。|r

OnUpdate提供了时间相关的参数属性。|r

OnClick则是按钮参数。|r

]]
L["FAQ_5_4"] = [[
|cffffffff我添加了一个OnEvent脚本但是它根本没触发过，少了什么东西？|r

在你的OnLoad里，为你想要获取的事件注册，例如：|r
self:RegisterEvent("PLAYER_LOGIN")|r

同时，非WoW创建的事件是不可用的，所以那些AceEvent-3.0的消息并不会触发你的OnEvent。|r
不过你也可以把AceEvent-3.0嵌入到你的框体指向里，要注意的是这可能会使你一次收到2条同样的事件。|r
]]
L["FAQ_5_5"] = [[
|Cffffffff我添加了一个OnClick/OnEnter/OnLeave脚本但是什么也没有发生，哪里做错了？|r

你需要为面板启用鼠标支持来获取那些事件。

]]
L["FAQ_5_6"] = [[
|cffffffff哪里能找到脚本示例？|r

示例脚本会发布在wowace上。
]]
L["FAQ_6_1"] = [[
|cffffffff我试着导入样式，但是什么也没出现？|r
检查下你的控制台，如果数据解包失败那里应该有一个详细信息。
]]
L["FAQ_6_2"] = [[
|cffffffff我导出了但是不能导入...|r

你确定你是把状态栏复制进了剪贴板？
]]
L["FAQ_6_3"] = [[
|cffffffff我怎么才能导入我的eePanels设置呢？|r

加载eePanels，在样式菜单里添加一个名称，然后点击导出，
导入的时候它会尽可能的保持原有的透明度设置。
不过脚本*不能*从eePanels中导入。
]]