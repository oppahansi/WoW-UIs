if ( GetLocale() == "zhTW" ) then
	PREFORM_AV_ENABLER_SELF = "Preform AV Enabler";
	PREFORM_AV_ENABLER_PREFORM = "Preform";
	PREFORM_AV_ENABLER_CMD = "/preformav";

	PREFORM_AV_ENABLER_AV = "奧特蘭克山谷";
	PREFORM_AV_ENABLER_WSG = "戰歌峽谷";
	PREFORM_AV_ENABLER_AB = "阿拉希盆地";
	PREFORM_AV_ENABLER_EYE = "暴風之眼";
	PREFORM_AV_ENABLER_AV_ABR = "AV";
	PREFORM_AV_ENABLER_WSG_ABR = "WSG";
	PREFORM_AV_ENABLER_AB_ABR = "AB";
	PREFORM_AV_ENABLER_EYE_ABR = "Eye";
	PREFORM_AV_ENABLER_STRAND = "遠祖灘頭";
	PREFORM_AV_ENABLER_STRAND_ABR = "SotA";

	PREFORM_AV_ENABLER_DESERTER = "Deserter";
	PREFORM_AV_ENABLER_QUEUED = "Queued";
	PREFORM_AV_ENABLER_CONFIRM = "Confirm";
	PREFORM_AV_ENABLER_INSIDE = "Inside";
	PREFORM_AV_ENABLER_FIRSTAVAIL = "First Avail";
	PREFORM_AV_ENABLER_OPEN = "Open";
	PREFORM_AV_ENABLER_CLOSED = "Closed";
	PREFORM_AV_ENABLER_WINDOW = "BM";
	PREFORM_AV_ENABLER_VER = "Ver";

	PREFORM_AV_ENABLER_NOTINSTALLED = "Status Unknown/Not Installed";
	PREFORM_AV_ENABLER_ATTEMPT = "Attempting to Join ";
	PREFORM_AV_ENABLER_INSTANCE = "Instance ID ";
	PREFORM_AV_ENABLER_NOTFOUND = " not found.  Re-open battlefield selection window quickly to queue!";
	PREFORM_AV_ENABLER_WAKE_UP = "Open the %s battlemaster window";

	PREFORM_AV_ENABLER_GROUPLEAVE = "Group Leave";
	PREFORM_AV_ENABLER_STATUSCHECK = "Status Check";
	PREFORM_AV_ENABLER_QUEUE = "Queue";
	PREFORM_AV_ENABLER_AUTOMATE = "Automate";
	PREFORM_AV_ENABLER_THRESHOLD = "Threshold";
	PREFORM_AV_ENABLER_LEAVEALL = "Leave All";
	PREFORM_AV_ENABLER_NOTIFY = "Notify";

	PREFORM_AV_ENABLER_TOOLTIP0 = "Click this if you believe the status window to be inaccurate";
	PREFORM_AV_ENABLER_TOOLTIP1 = "Force every group member to solo queue first available for this particular BG.  Note: raid members must have the appropriate battlemaster window open to be queued";
	PREFORM_AV_ENABLER_TOOLTIP2 = "Send the signal to join the battleground instance ID that the majority \"confirm\" status users have.  Anybody who did not get that instance will leave their queues and queue for the majority's instance";
	PREFORM_AV_ENABLER_TOOLTIP3 = "Leave the queue (if you are in it)";
	PREFORM_AV_ENABLER_TOOLTIP4 = "Force everybody with the addon installed to leave their queues for this BG";
	PREFORM_AV_ENABLER_TOOLTIP5 = "Automate the queue/leave process until all raid members get the same instance or until the threshold is met.  Note: Every raid/party member will need to have the addon installed, and must have the appropriate battlemaster window open for automate to work.";
	PREFORM_AV_ENABLER_TOOLTIP6 = "Set the acceptable number of raid members that get the same instance before automate sends the signal to join.  Anyone who does not get the instance of the majority will be sent signals to join that specific instance.  If the threshold becomes impossible to meet, then the requeue signal will be sent.  If this is set higher than the total number of raid members, then the signal to join will not be sent until everybody gets the same instance.";
	PREFORM_AV_ENABLER_TOOLTIP7 = "Force everybody with this addon installed to leave any and all battleground queues they may have, not just AV";
	PREFORM_AV_ENABLER_TOOLTIP8 = "Notify the raid members whom do not have the battlemaster window you have open to open it";
end
