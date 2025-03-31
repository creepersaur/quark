marked.setOptions({
	highlight: function (code, lang) {
		// Use Prism to highlight the code
		const validLang = Prism.languages[lang] ? lang : "lua"; // Default to 'clike' if language isn't found
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

// Add extension to Marked
marked.use({ extensions: [commentExtension] });

function fileMarkdown(file_path) {
	fetch("docs/" + file_path)
		.then((response) => response.text())
		.then((data) => {
			document.getElementById("Main").innerHTML = marked.parse(data);
			Prism.highlightAll();
		})
		.catch((error) => console.error("Error loading topbar:", error));
}
