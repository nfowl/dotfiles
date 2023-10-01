{ config, pkgs, inputs, system, ... }:
{
	programs.helix.languages = {
		language = [{
			name = "python";
			roots = ["pyproject.toml"  "setup.py"  "poetry.lock"  "pyrightconfig.json" ".git"];
			language-servers = ["pyright" "efm-python"];
			auto-format = true;
		}];

		language-server = {
			pyright = {
				command = "pyright-langserver";
				args = ["--stdio"];
				config = { 
					python.analysis = {
						autoSearchPaths = true;
						useLibraryCodeForTypes = true;
						diagnosticMode = "openFilesOnly";
					};
				};
			};
			efm-python = {
				command = "efm-langserver";
				config = {
					documentFormatting = true;
					languages.python = [
						{
							formatCommand = "black --quiet --line-length=100 -";
							formatStdin = true;
						}
						{
							formatCommand = "isort --profile google --line-length 100 --multi-line 3 --trailing-comma --use-parentheses --ensure-newline-before-comments --quiet -";
							formatStdin = true;
						}
					];
				};
			};
		};
	};
}
