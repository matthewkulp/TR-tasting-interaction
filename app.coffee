showDelay = 1

# Container for the first few layers
pane1 = new Layer
	x: 0
	y: 0
	width: 640
	height: 1136
	
translateTime = 0.3
translateCurve = 'cubic-bezier'

pane1.states.add
	show:
		x: 0
	hide:
		x: -640
pane1.states.animationOptions = 
	time: translateTime
	curve: translateCurve


bg1 = new Layer 
	x:0, y:0, width:640, height:1136, image:"images/bgSwirl.png"
pane1.addSubLayer bg1
overlay = new Layer 
	x:0, y:0, width:640, height:1136, image:"images/overlay.png", opacity:0
pane1.addSubLayer overlay
	
buttonAnimationOptions = 
	curve: 'spring'
	curveOptions:
		friction: 32
	time: 0.5
	delay: 0.3
	
back = new Layer 
	x:-100, y:33, width:77, height:77, image:"images/back.png"
back.states.add
	hide:
		x: -100
	show:
		x: 33
back.states.animationOptions = buttonAnimationOptions
pane1.addSubLayer back

next = new Layer 
	x:636, y:1032, width:77, height:77, image:"images/next.png"
next.states.add
	hide:
		x: 740
	show:
		x: 536
next.states.animationOptions = buttonAnimationOptions
pane1.addSubLayer next

timer = new Layer 
	x:277, y:1019, width:87, height:87, image:"images/timer.png"
pane1.addSubLayer timer

text = new Layer 
	x:125, y:346, width:312, height:176, image:"images/text.png", opacity: 0
text.states.add
	hide: 
		y: 346
		opacity: 0
	show:
		y: 336
		opacity: 1
text.states.animationOptions = 
	time: 0.3
	curve: 'cubic-bezier'
pane1.addSubLayer text

showOverlay = ->
	
	overlayAnimation = overlay.animate
		properties:
			opacity: 1
		time: 0.3
		
	overlayAnimation.on 'end', ->
			
		text.states.switch 'show'
		back.states.switch 'show'
		next.states.switch 'show'
				
next.on 'click', ->
	pane1.states.switch 'hide'
	sniff.states.switch 'show'
		
		
sniff = new Layer 
	x:640, y:0, width:640, height:1136, image:"images/sniff.png"
sniff.states.add
	show:
		x: 0
	hide:
		x: 640
sniff.states.animationOptions = 
	time: translateTime
	curve: translateCurve
	
	
sniff.on 'click', ->
	# Go back
	pane1.states.switch 'show'
	sniff.states.switch 'hide'
	# Hide everything
	back.states.switchInstant 'hide'
	next.states.switchInstant 'hide'
	text.states.switchInstant 'hide'
	overlay.opacity = 0
	# Animate in again
	Utils.delay showDelay, showOverlay
	
		
Utils.delay showDelay, showOverlay