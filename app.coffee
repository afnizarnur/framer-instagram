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

# Creating flow for making header and footer stick on top and bottom
flow = new FlowComponent
	backgroundColor: "#F5F5F5"

# Initialize screen
flow.showNext(home)

# Usernames Data
usernames = [
	{ "data": "hermiston.brandi" },
	{ "data": "elvera95" },
	{ "data": "dominique.lind" },
	{ "data": "elva.langosh" }
]

# Fill our story feed using usernames data 
for username, i in usernames
	feed_username.text = username.data
	feed_caption.template = username.data
	feed_time.textTransform = "uppercase"
	

# Animate heart icon when tap the image
heart.opacity = 0
heart.scale = 0

feed_image.onDoubleTap (event, layer) ->
	# Show the heart icon
	heart.animate
		opacity: 1
		scale: 1
		options:
			time: 0.5
			curve: Spring
	
	# Using Utils.delay to wait first animation finish, after that hide the heart icon
	Utils.delay 0.5, ->
		heart.animate
			opacity: 0
			scale: 0
			options:
				time: 1
				curve: Spring






