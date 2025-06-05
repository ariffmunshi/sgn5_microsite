function handleCollapsibleToggle(button, targetElement) {
	const isOpen = targetElement.classList.contains("show");

	if (isOpen) {
		targetElement.classList.remove("show");
		button.setAttribute("aria-expanded", "false");
	} else {
		targetElement.classList.add("show");
		button.setAttribute("aria-expanded", "true");
	}
}

function initializeCollapsibles() {
	const toggles = document.querySelectorAll('[data-my-toggle="collapse"]');

	toggles.forEach((btn) => {
		const targetSelector = btn.getAttribute("data-my-target");
		if (!targetSelector) return;

		const menu = document.querySelector(targetSelector);
		if (!menu) return;

		if (!menu.classList.contains("collapse")) {
			menu.classList.add("collapse");
		}

		btn.addEventListener("click", () => handleCollapsibleToggle(btn, menu));
	});
}

window.addEventListener("DOMContentLoaded", initializeCollapsibles);
