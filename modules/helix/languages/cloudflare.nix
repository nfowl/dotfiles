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
				rev = "6615e95bcbf449b48605ec92bd78b1a440792e2d";
			};
		}];
	};
}
