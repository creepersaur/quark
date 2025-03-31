Prism.languages["luau"] = {
	comment: /^#!.+|--(?:\[(=*)\[[\s\S]*?\]\1\]|.*)/m,
	// \z may be used to skip the following space
	string: {
		pattern:
			/(["'])(?:(?!\1)[^\\\r\n]|\\z(?:\r\n|\s)|\\(?:\r\n|[^z]))*\1|\[(=*)\[[\s\S]*?\]\2\]/,
		greedy: true,
	},
	number: /\b0x[a-f\d]+(?:\.[a-f\d]*)?(?:p[+-]?\d+)?\b|\b\d+(?:\.\B|(?:\.\d*)?(?:e[+-]?\d+)?\b)|\B\.\d+(?:e[+-]?\d+)?\b/i,
	keyword:
		/\b(?:and|break|do|else|elseif|end|false|for|function|goto|if|in|local|nil|not|or|repeat|return|then|true|until|while)\b/,
	function: [/(?!\d)\w+(?=\s*(?:[({]))/, /\bNew\b/, /\print\b/],
	operator: [
		/[-+*%^&|#]|\/\/?|<[<=]?|>[>=]?|[=~]=?/,
		{
			// Match ".." but don't break "..."
			pattern: /(^|[^.])\.\.(?!\.)/,
			lookbehind: true,
		},
	],
	property: /(?<=\.)\w*/,
	punctuation: /[\[\](){},;]|\.+|:+/,
};

marked.setOptions({
	highlight: function (code, lang) {
		code = code.trim();
		// Use Prism to highlight the code
		const validLang = Prism.languages[lang] ? lang : "lua"; // Default to 'lua' if language isn't found
		return Prism.highlight(code, Prism.languages[validLang], validLang);
	},
});

const commentExtension = {
	level: "block",
	name: "comment",
	tokenizer(src) {
		const match = /^-#(.*)/.exec(src);
		if (match) {
			return {
				type: "comment",
				raw: match[0],
				text: match[1].trim(),
			};
		}
		return undefined;
	},
	renderer(token) {
		// Render comment as a faded span
		return `<span class="comment">${marked.parseInline(token.text)}</span>`;
	},
};

const nextPageExtension = {
	level: "block",
	name: "nextPage",
	tokenizer(src) {
		const match = /^\<\!NextPage\|(.*)>\((.*)\)/.exec(src);
		if (match) {
			return {
				type: "nextPage",
				raw: match[0],
				text: match[1].trim(),
				link: match[2].trim(),
			};
		}
		return undefined;
	},
	renderer(token) {
		// Render comment as a faded span
		return `<a
			class="NextPage"
			onclick="
				window.location.href = '${token.link}';
				promptPageUpdate();
		">
			Next Page
			<strong>${token.text}</strong>
		</a>`;
	},
};

// Add extension to Marked
marked.use({ extensions: [commentExtension, nextPageExtension] });

function fileMarkdown(file_path) {
	fetch("docs/" + file_path)
		.then((response) => response.text())
		.then((data) => {
			document.getElementById("Main").innerHTML = marked.parse(data);
			Prism.highlightAll();
		})
		.catch((error) => console.error("Error loading topbar:", error));
}
