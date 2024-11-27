import { useState } from "react";

import viteLogo from "/vite.svg";
import reactLogo from "./assets/react.svg";

function App() {
	const [count, setCount] = useState(0);

	return (
		<>
			<div className="flex justify-around">
				<a href="https://vitejs.dev" target="_blank" rel="noreferrer">
					<img
						src={viteLogo}
						className="h-24 p-2 will-change-[filter] transition-[filter_300ms] hover:drop-shadow-[0_0_2em_#646cffaa]"
						alt="Vite logo"
					/>
				</a>
				<a href="https://react.dev" target="_blank" rel="noreferrer">
					<img
						src={reactLogo}
						className="h-24 p-2 will-change-[filter] transition-[filter_300ms] hover:drop-shadow-[0_0_2em_#61dafbaa] animate-[spin_infinite_20s_linear] motion-reduce:animate-none"
						alt="React logo"
					/>
				</a>
			</div>
			<h1 className="font-bold text-5xl">Vite + React</h1>
			<div className="p-8">
				<button
					className="bg-[#f9f9f9] dark:bg-[#1a1a1a] border border-transparent rounded px-3 py-2 font-medium transition-colors hover:border-[#646cff] focus:outline-[4px_auto_-webkit-focus-ring-color] focus:visible:outline-[4px_auto_-webkit-focus-ring-color]"
					type="button"
					onClick={() => {
						setCount((count) => count + 1);
					}}
				>
					count is {count}
				</button>
				<p>
					Edit <code>src/App.tsx</code> and save to test HMR
				</p>
			</div>
			<p className="text-[#888]">
				Click on the Vite and React logos to learn more
			</p>
		</>
	);
}

export default App;
