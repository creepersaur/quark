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
		/\b(?:type|self|and|break|do|else|elseif|end|false|for|function|goto|if|in|local|nil|not|or|repeat|return|then|true|until|while)\b/,
	builtin:
		/\bworkspace|Axes|BrickColor|CatalogSearchParams|CFrame|Color3|ColorSequence|ColorSequenceKeypoint|DateTime|DockWidgetPluginGuiInfo|Enum|EnumItem|Enums|Faces|Instance|NumberRange|NumberSequence|NumberSequenceKeypoint|PathWaypoint|PhysicalProperties|Random|Ray|RaycastParams|RaycastResult|RBXScriptConnection|RBXScriptSignal|Rect|Region3|Region3int16|TweenInfo|UDim2|UDim|Vector2|Vector2int16|Vector3|Vector3int16\b/,
	function: [
		/(?!\d)\w+(?=\s*(?:[({]))/,
		/\bNew\b(?!<)/,
		/\bprint\b/,
		/\bscript\b/,
	],
	operator: [
		/[-+*%^&|#]|\/\/?|< [<=]?| >[>=]?|[=~]|(\.\.\.)=?/,
		{
			// Match ".." but don't break "..."
			pattern: /(^|[^.])\.\.(?!\.)/,
			lookbehind: true,
		},
	],
	type: [/(?<=:)\s?(\w*)/gim, /(?<=<)(.*)(?=>)/gim, /(New)(?=<)/],
	property: /(?<=\.)\w*/,
	punctuation: /[\[\](),;]|\.+|:+/,
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

const tagExtension = {
	level: "inline",
	name: "tagged",
	tokenizer(src) {
		const match = /^<#(.*?)\|(.*?)>/.exec(src);
		if (match) {
			return {
				type: "tagged",
				raw: match[0],
				text: match[1].trim(),
				tagtype: match[2].trim(),
			};
		}
		return undefined;
	},
	renderer(token) {
		return `<tagged style="background: ${token.tagtype};">${token.text}</tagged>`;
	},
}

// Add extension to Marked
marked.use({
	extensions: [commentExtension, nextPageExtension, tagExtension],
});

function fileMarkdown(file_path) {
	fetch("docs/" + file_path)
		.then((response) => response.text())
		.then((data) => {
			if (data.includes("<!DOCTYPE html>")) {
				fetch("docs/404.md")
					.then((response) => response.text())
					.then((data) => {
						document.getElementById("Main").innerHTML = marked.parse(data);
					})
					.catch((error) =>
						console.error("Error loading 404 file:", error)
					);
			} else {
				document.getElementById("Main").innerHTML = marked.parse(data);
			}
			
			Prism.highlightAll();
		})
		.catch((error) => console.error("Error loading markdown file:", error));
}

Prism.hooks.add('complete', (env) => {
	if (!env.element.parentNode.querySelector('.copy_btn')) {
		const button = document.createElement('span')
		button.className = 'copy_btn material-symbols-outlined'
		button.innerText = 'content_copy'

		const btnText = document.createElement('p')
		btnText.innerHTML = 'copied!'

		button.addEventListener('click', () => {
			navigator.clipboard.writeText(env.code)
			button.setAttribute("copied", true)
			setTimeout(() => {
				button.removeAttribute("copied")
			}, 1000)
		})

		button.appendChild(btnText)
		env.element.parentNode.appendChild(button)
	}
})