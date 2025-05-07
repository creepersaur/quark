const sidebar = document.getElementById("Sidebar");

function connect_items() {
	const items = document.querySelectorAll(".FoldItem");

	items.forEach((i) => {
		i.addEventListener("click", () => {
			items.forEach((e) => e.removeAttribute("active"));
			i.setAttribute("active", 1);

			fileMarkdown(i.getAttribute("path"));
			document.title = `Quark - ${i.getAttribute("name")}`;

			let split = window.location.href.split("#");
			let path = i.getAttribute("path");
			window.location.href =
				split[0] + "#" + path.substring(0, path.length - 3);
		});
	});
}

function open_page(page) {
	const items = document.querySelectorAll(".FoldItem");

	items.forEach((i) => {
		if (i.getAttribute("path") == page + ".md") {
			i.click();
		}
	});
}

function setup_sidebar() {
	return fetch("docs/init.json")
		.then((response) => response.json())
		.then((data) => {
			for (const key in data) {
				// console.log("FOLD:", key);

				let fold = document.createElement("div");
				fold.className = "Fold";

				let fold_name = document.createElement("strong");
				fold_name.innerHTML = key;
				fold.appendChild(fold_name);

				let itemHolder = document.createElement("li");
				fold.appendChild(itemHolder);

				sidebar.appendChild(fold);

				for (let name in data[key]) {
					// console.log("\tInner:", name);

					let item = document.createElement("a");
					item.className = "FoldItem";
					item.innerHTML = name;
					item.setAttribute("path", data[key][name]);

					let icon = "";
					let split = name.split("|");
					if (split.length > 1) {
						icon = split[0];
						name = split[1];
					}

					if (icon.length > 0) {
						item.innerHTML = `<span class="material-symbols-outlined">
						${icon}
					</span> ${name}`;
					}

					item.setAttribute("name", name);
					itemHolder.appendChild(item);
				}
			}

			connect_items();
		})
		.catch((error) => console.error("Error loading docs:", error));
}

function promptPageUpdate() {
	let split = window.location.href.split("#");
	if (split.length > 1) {
		open_page(split[1]);
	}
}

setup_sidebar().then(promptPageUpdate);
