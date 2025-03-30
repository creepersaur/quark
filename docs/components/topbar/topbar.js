fetch("components/topbar/topbar.html")
	.then(response => response.text())
	.then(data => {
		const topbar = document.createElement("div");
		document.body.prepend(topbar);
		
		const link = document.createElement("link");
		link.rel = "stylesheet";
		link.href = "components/topbar/topbar.css"; // Make sure this file exists
		document.head.appendChild(link);

		topbar.classList.add("topbar");
		topbar.innerHTML = data;

		// Quark home button
		topbar.querySelector("#HomeButton").addEventListener("click", () => {
			window.location.href = "index.html"
			console.log("CLICKED")
		})
	})
	.catch(error => console.error("Error loading topbar:", error));