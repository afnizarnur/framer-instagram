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

# Set up ScrollComponent
scroll = new ScrollComponent
	y: header.height
	parent: home
	scrollHorizontal: false
	width: Screen.width
	height: Screen.height - header.height - tabBar.height

feed_wrapper.parent = scroll.content

# Real Data
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
	# Randomize the likes count
	rand_number = Utils.round(Utils.randomNumber(0, 100))	
	like_count.template = rand_number

# Heart States
heart_default.states = 
	default:
		animationOptions:
			time: 0.5
			curve: Spring
		scale: 1
		opacity: 1
	active:
		animationOptions:
			time: 0.5
			curve: Spring
		opacity: 0
		scale: 0
		
heart_active.states =
	default:
		animationOptions:
			time: 0.5
			curve: Spring
		scale: 0
		opacity: 0
	active:
		animationOptions:
			time: 0.5
			curve: Spring
		opacity: 1
		scale: 1

# Fix when first like count not active
if heart_default.states.current.name is "default"
	like_count.template = rand_number++
else 
	like_count.template = rand_number--

# When default heart onTap
heart_default.onTap ->
	heart_active.animate("active")
	heart_default.animate("active")
	
	if heart_default.states.current.name is "active"
		like_count.template = rand_number--
	else
		like_count.template = rand_number++

# When active heart onTap	
heart_active.onTap ->
	heart_active.animate("default")
	heart_default.animate("default")
	
	if heart_active.states.current.name is "default"
		like_count.template = rand_number++
	else
		like_count.template = rand_number--

# Animate heart icon when double tap the image
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
	
	if heart_active.states.current.name is "default"
		like_count.template = rand_number--
				
	heart_active.animate("active")
	heart_default.animate("active")
		
	# Using Utils.delay to wait first animation finish
	Utils.delay 0.5, ->
		heart.animate
			opacity: 0
			scale: 0
			options:
				time: 1
				curve: Spring


