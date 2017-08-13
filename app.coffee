# Statusbar time
setTime = () ->
	date = new Date
	minute = date.getMinutes()
	hour = date.getHours()
	
	if hour < 10
		hour = '0' + hour 
	
	if minute < 10
		minute = '0' + minute 

	statusBarTime.text = "#{hour}:#{minute}"

	Utils.delay 30, ->
		setTime()
		
setTime()

# List
usernames = [
	{
	"data": "hermiston.brandi"
	},
	{
	"data": "elvera95"
	},
	{
	"data": "dominique.lind"
	},
	{
	"data": "elva.langosh"
	}
]

# Data for the story name
for username, i in usernames
	feed_username.text = username.data
	feed_caption.template = username.data
	feed_time.textTransform = "uppercase"

# Flow
flow = new FlowComponent
	backgroundColor: "#F5F5F5"

# Initialize screen
flow.showNext(home)