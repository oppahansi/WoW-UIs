--[[
	OmniCC Localization File
		Russian by StingerSoft
--]]

if GetLocale() == 'ruRU' then
	local L = OMNICC_LOCALS
	L.UpgradeIncompatible = 'Обновлено из несовместимой версии. Загружены стандартные настройки'
	L.Updated = 'Обновлено v%s'

	L.Commands = 'Команды (/omnicc)'
	L.SetSizeDesc = 'Размер шрифта. стандарт: 20'
	L.SetFontDesc = format('Выбор шрифта. %s стандартный', STANDARD_TEXT_FONT)
	L.SetColorDesc = 'Установите цветthe перезарядки <dur>. <dur> может быть vlong, длинный, средний или короткий'
	L.SetScaleDesc = 'Установите масштаб перезарядки <dur>. <dur> может быть vlong, длинный, средний или короткий'
	L.SetMinDurDesc = 'Установите минимальный период перезарядки для отображения (в сек). Стандартное значение: 3'
	L.ToggleModelDesc = 'Вкл/Выкл модуль перезарядки'
	L.TogglePulseDesc = 'Вкл/Выкл импульс когда перезарядка закончена'
	L.ToggleMMSSDesc = 'Вкл/Выкл формат ММ:СС'
	L.ToggleBlacklistDesc = 'Вкл/Выкл отображения перезарядки на фреймах из чёрного списока'
	L.ResetDesc = 'Сброс на стандартные настройки'

	L.SetFont = 'Шрифт: %s'
	L.SetFontSize = 'Размер шрифта: %s'
	L.SetMinDur = 'Минимальный период: %s'
	L.ModelsEnabled = 'Модели перезарядки включены'
	L.ModelsDisabled = 'Модели перезарядки отключены'
	L.PulseEnabled = 'Импульс включен'
	L.PulseDisabled = 'Импульс отключен'
	L.MMSSEnabled = 'Формат ММ:СС включен'
	L.MMSSDisabled = 'Формат ММ:СС выключен'
	L.BlacklistEnabled = 'Скрыть перезарядку на фреймах из чёрного списока'
	L.BlacklistDisabled = 'Отображать текст перезарядки на всех фреймах'
	L.Reset = 'Загружены стандартные настройки'
	L.InvalidCommand = '\'%s\' неверная команда'
end
