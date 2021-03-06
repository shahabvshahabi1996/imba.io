def shuffle array
	var counter = array:length, temp, index

	# While there are elements in the array
	while counter > 0
		# Pick a random index
		index = Math.floor(Math.random * counter)
		counter-- # Decrease counter by 1

		# And swap the last element with it
		temp = array[counter]
		array[counter] = array[index]
		array[index] = temp
	
	return array

tag pattern

	def build
		return self if $node$

		var parts = {tags: [], keywords: [], methods: []}
		var items = []
		var lines = []

		for own k,v of Imba.Tag:prototype
			items.push("<em>{k}</em>")
			parts:methods.push("<em>{k}</em>")

		for k in Imba.HTML_TAGS or HTML_TAGS
			items.push("<u>&lt;{k}&gt;</u>")
			parts:tags.push("<u>&lt;{k}&gt;</u>")

		var words = "def if else elif while until for in of var let class extend export import tag global"

		for k in words.split(" ")
			items.push("<i>{k}</i>")
			parts:keywords.push("<i>{k}</i>")

		var shuffled = shuffle(items)
		var all = [].concat(shuffled)
		var count = items:length - 1

		for ln in [0 .. 14]
			let chars = 0
			lines[ln] = []
			while chars < 300
				let item = (shuffled.pop or all[Math.floor(count * Math.random)])
				if item
					chars += item:length
					lines[ln].push(item)
				else
					chars = 400

		dom:innerHTML = '<div>' + lines.map(|ln,i|
			let o = Math.max(0,((i - 2) * 0.3 / 14)).toFixed(2)
			"<div class='line' style='opacity: {o};'>" + ln.join(" ") + '</div>'
		).join('') + '</div>'
		self

	def awaken
		return self

tag home < page

	def awaken
		var snippets = document.querySelectorAll('code[data-src]')
		for snippet in snippets
			var src = snippet.getAttribute('data-src')
			DEPS[src] = {html: snippet:innerHTML}

		super

	def nav
		null

	def body
		<@body>
			<div#hero.dark>
				<pattern@pattern.awaken>
				<herosnippet.hero.dark src='/home/examples/hero.imba'>

			<@content>
				<marked.section.md.welcome.huge.light> """
					# Create complex web apps with ease!

					Imba is a new programming language for the web that compiles to highly 
					performant and readable JavaScript. It has language level support for defining, 
					extending, subclassing, instantiating and rendering dom nodes. For a simple 
					application like TodoMVC, it is more than 
					[10 times faster than React](http://somebee.github.io/todomvc-render-benchmark/index.html) 
					with less code, and a much smaller library.

					---

					- ## Imba.inspiration
					  Imba brings the best from Ruby, Python, and React (+ JSX) together in a clean language and runtime.

					- ## Imba.interoperability
					  Imba compiles down to clean and readable JavaScript. Use any JS library in Imba and vica-versa.
					
					- ## Imba.performance
					  Build your application views using Imba's native tags for unprecedented performance.

					"""

				<example.dark heading="Simple reminders" src='/home/examples/reminders.imba'>

				<marked.section.md> """
					## Reusable components
					
					A custom tag / component can maintain internal state and control how to render itself.
					With the performance of DOM reconciliation in Imba, you can use one-way declarative bindings,
					even for animations. Write all your views in a straight-forward linear fashion as if you could
					rerender your whole application on **every single** data/state change.
					"""

				<example.dark heading="World clock" src='/home/examples/clock.imba'>

				<marked.section.md> """
					## Extend native tags
					
					In addition to defining custom tags, you can also extend native tags, or inherit from them.
					Binding to dom events is as simple as defining methods on your tags; all events will be
					efficiently delegated and handled by Imba. Let's define a simple sketchpad...
					"""

				<example.dark heading="Custom canvas" src='/home/examples/canvas.imba'>