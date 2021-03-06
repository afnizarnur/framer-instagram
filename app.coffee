Framer.Device.background.backgroundColor = "#ccc"

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

# Set up ScrollComponent the feed
scroll = new ScrollComponent
	y: header.height
	parent: Home
	scrollHorizontal: false
	width: Screen.width
	height: Screen.height - header.height - tabBar.height

feed_wrapper.parent = scroll.content

# Set up ScrollComponent for people story
story_scroll = new ScrollComponent
	parent: stories_wrap
	scrollVertical: false
	width: Screen.width
	height: people_story.height + 25
	y: 30
	
people_story.parent = story_scroll.content


# Real Data
user = [
	{ 
		"username": "steve_lianardo"
		"avatar": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-19/s320x320/12950243_641406459330614_1802934396_a.jpg"
		"picture": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-15/e35/15306537_1088591907930253_2208198207639388160_n.jpg"
		"caption" : "Kuy yamin kuy"
	},
	{ 
		"username": "rizaldygema"
		"avatar": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-19/10643957_469931539816728_944957932_a.jpg"
		"picture": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-15/e35/14482780_1652664471698734_5484316174885847040_n.jpg"
		"caption": "Lagi kerja nih"
	},
	{ 
		"username": "shylla___"
		"avatar": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-19/s320x320/19623173_1400899839945671_1936471982056931328_a.jpg"
		"picture": "https://instagram.fcgk10-1.fna.fbcdn.net/t51.2885-15/e35/19932579_291879907942829_2706950881160462336_n.jpg"
		"caption": "Liburan terus"
	},
]

# Randomize Function
random_number = ->
	Utils.round(Utils.randomNumber(0, 100))

# Loop post for the feed and all interaction
for item, index in feed.children
	like = item.children[12]
	username = item.children[1]
	caption = item.children[4]
	image = item.children[3]
	avatar = item.children[0]
	heart = item.children[3].children[0]
	heart_filled1 = item.children[5]
	heart_thin1 = item.children[6]
	username.text = user[index].username
	caption.template = 
		username: user[index].username
		caption: user[index].caption
	avatar.image = user[index].avatar
	image.image = user[index].picture
	like.template = random_number()
	
	# Hide heart icon
	heart.opacity = 0
	heart.scale = 0
	
	# When default heart onTap
	heart_filled1.opacity = 0
	heart_filled1.scale = 0
	
	heart_thin1.onTap ->
		heart_filled = this.parent.children[5]
		like_count = this.parent.children[12]
		
		heart_filled.animate
			opacity: 1
			scale: 1
			options: 
				time: 0.5
				curve: Spring

		this.animate
			opacity: 0
			scale: 0
			options: 
				time: 0.5
				curve: Spring
		
		if heart_filled.opacity is 0
			like_count.template = 
				like_count.template.likes + 1
		else
			like_count.template = 
				like_count.template.likes - 1
	
	# When active heart onTap
	heart_filled1.onTap ->
		heart_thin = this.parent.children[6]
		like_count = this.parent.children[12]
		
		heart_thin.animate
			opacity: 1
			scale: 1
			options: 
				time: 0.5
				curve: Spring
		
		this.animate
			opacity: 0
			scale: 0
			options: 
				time: 0.5
				curve: Spring
		
		if heart_thin.opacity is 0
			like_count.template = 
				like_count.template.likes - 1
		else
			like_count.template = 
				like_count.template.likes + 1

	# Animate heart icon when double tap the image
	image.onDoubleTap (event, layer) ->
		heart_filled2 = this.parent.children[5]
		heart_thin2 = this.parent.children[6]
		like_count = this.parent.children[12]
		heart_filled2.opacity = 0
		heart_filled2.scale = 0
		
		if heart_thin2 .opacity isnt 0
			like_count.template = 
				like_count.template.likes+1

		this.children[0].animate
			opacity: 1
			scale: 1
			options:
				time: 0.5
				curve: Spring
		
		Utils.delay 0.5, =>
			this.children[0].animate
				opacity: 0
				scale: 0
				options:
					time: 1
					curve: Spring
		
		heart_filled2.animate
			opacity: 1
			scale: 1
			options: 
				time: 0.5
				curve: Spring
		
		heart_thin2.animate
			opacity: 0
			scale: 0
			options: 
				time: 0.5
				curve: Spring

