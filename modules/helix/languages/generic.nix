{ config, pkgs, inputs, system, ... }:
{
	programs.helix.languages = {
		language = [
		{
			name = "starlark";
			language-servers = ["efm-bazel"];
			auto-format = true;
		}
		{
			name = "json";
			language-servers = ["efm-prettier" "vscode-json-language-server"];
		}
		];

		language-server = {
      vscode-json-language-server.config.provideFormatter = false;
			efm-bazel = {
				command = "efm-langserver";
				config = {
					documentFormatting = true;
					languages.starlark = [
						{
							formatCommand = "buildifier";
							formatStdin = true;
						}
					];
				};
			};
			efm-prettier = {
				command = "efm-langserver";
				config = {
					documentFormatting = true;
					languages."=" = [
						{
							formatCommand = "black --stdin-filepath \${INPUT}";
							formatStdin = true;
						}
					];
				};
			};

			nil.config = {
				nil_ls.settings.nil.nix.flake.autoEvalInputs = true;
			};
			# efm-nix = {
			# 	command = "efm-langserver";
			# 	config = {
			# 		documentFormatting = true;
			# 		languages.nix = [
			# 			{
			# 				formatCommand = "alejandra";
			# 				formatStdin = true;
			# 			}
			# 		];
			# 	};
			# };
		};
	};
}
