const sidebar = document.getElementById("Sidebar");

fetch("docs/init.json")
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

		const items = document.querySelectorAll(".FoldItem");

		items.forEach((i) => {
			i.addEventListener("click", () => {
				items.forEach((e) => e.removeAttribute("active"));
				i.setAttribute("active", 1);

				fileMarkdown(i.getAttribute("path"));
				document.title = `Quark - ${i.getAttribute("name")}`;
			});
		});
	})
	.catch((error) => console.error("Error loading docs:", error));
