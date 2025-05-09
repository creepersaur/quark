function load_docs() {
	if (window.location.hash.length)
		window.location.href = "docs.html"
}

setTimeout(load_docs(), 0);