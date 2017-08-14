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
	parent: Home
	scrollHorizontal: false
	width: Screen.width
	height: Screen.height - header.height - tabBar.height

feed_wrapper.parent = scroll.content

# Real Data
user = [
	{ 
		"username": "steve_lianardo"
		"avatar": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-19/s320x320/12950243_641406459330614_1802934396_a.jpg"
		"picture": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-15/e35/15306537_1088591907930253_2208198207639388160_n.jpg"
	},
	{ 
		"username": "rizaldygema"
		"avatar": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-19/10643957_469931539816728_944957932_a.jpg"
		"picture": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-15/e35/14482780_1652664471698734_5484316174885847040_n.jpg"
	},
	{ 
		"username": "shylla___"
		"avatar": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-19/s320x320/19623173_1400899839945671_1936471982056931328_a.jpg"
		"picture": "http://lorempixel.com/output/nature-q-c-640-480-5.jpg"
	},
]

# Randomize Function
random_number = ->
	Utils.round(Utils.randomNumber(0, 100))

# Fill our story feed using usernames data 
for item, index in feed.children
	like = item.children[12]
	username = item.children[1]
	caption = item.children[4]
	image = item.children[3]
	avatar = item.children[0]
	
# 	heart = item.children[3].children[0]
# 	heart_active = item.children[5]
# 	heart_default = item.children[6]
	
	username.text = user[index].username
	caption.template = user[index].username
	avatar.image = user[index].avatar
	image.image = user[index].picture
	
	rand_number = random_number()
	like.template = rand_number

# Heart States
heart_active.opacity = 0
heart_active.scale = 0

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