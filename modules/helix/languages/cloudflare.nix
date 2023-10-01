{ config, pkgs, inputs, system, ... }:
{
	programs.helix.languages = {
		language = [{
			name = "cloudflare";
			scope = "source.cfrule";
			injection-regex = "cfrule";
			file-types = ["cfrule"];
			comment-token = "#";
			grammar = "cloudflare";
			roots = [""];
			diagnostic-severity = "Hint";
		}];

		grammar = [{
			name = "cloudflare";
			source = {
				git = "https://github.com/nfowl/tree-sitter-cloudflare";
				rev = "9576929a5069a2207a8dbb2243b9824d22baa707";
			};
		}];
	};
}
