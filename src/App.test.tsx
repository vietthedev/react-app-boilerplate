import { render } from "@testing-library/react";

import App from "./App";

describe(App.name, () => {
	it("can render", () => {
		render(<App />);
	});
});
